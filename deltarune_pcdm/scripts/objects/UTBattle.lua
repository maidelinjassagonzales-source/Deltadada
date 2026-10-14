-- ===========================================================================
--  COMBATE ESTILO UNDERTALE (Light World)
--  LUCHAR / ACTUAR / OBJETO / PIEDAD, barra de ataque y el alma en la caja.
--  Se usa desde una cutscene:  local res = UTBattle.run(cutscene, config)
-- ===========================================================================
local UTBattle, super = Class(Object)

local BOX_FULL = { x = 32, y = 250, w = 576, h = 140 }
local BOX_DODGE_W, BOX_DODGE_H = 170, 140
local BUTTONS = { "LUCHAR", "ACTUAR", "OBJETO", "PIEDAD" }
local ORANGE = { 1, 0.5, 0.15 }
local YELLOW = { 1, 1, 0.25 }

--- Ejecuta un combate desde una cutscene y espera a que termine. Devuelve "spare"/"kill"/"flee"/"win".
function UTBattle.run(cutscene, config)
    local b = UTBattle(config)
    Game.stage:addChild(b)
    cutscene:wait(function() return b.done end)
    return b.result
end

function UTBattle:init(config)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.layer = 1400
    self.cfg = config
    self.e = config.enemy
    self.e.max_hp = self.e.max_hp or self.e.hp
    if PCDM.test_easy then self.e.hp = 1 end
    self.e.mercy = 0
    self.e.spareable = false
    self.turn = 0
    self.done = false
    self.result = nil

    local chara = Game.party[1]
    self.p = config.player or {
        name = PCDM.upper(chara and chara:getName() or "Lucía"),
        lv = 1,
        hp = chara and chara.lw_health or 20,
        max_hp = chara and chara:getStat("health", 20, true) or 20,
        atk = 10, def = 10,
    }
    if self.p.hp <= 0 then self.p.hp = self.p.max_hp end

    self.items = config.items or self:gatherItems()

    self.font = Assets.getFont("main_mono")
    self.small = Assets.getFont("main", 24)
    self.heart = Assets.getTexture("player/heart")
    self.heart_small = Assets.getTexture("player/heart_menu") or self.heart

    -- caja
    self.box = { x = BOX_FULL.x, y = BOX_FULL.y, w = BOX_FULL.w, h = BOX_FULL.h }
    self.box_target = { x = BOX_FULL.x, y = BOX_FULL.y, w = BOX_FULL.w, h = BOX_FULL.h }

    -- alma
    self.soul = { x = 320, y = 320, inv = 0 }

    self.bullets = {}
    self.btn = 1
    self.sub = 1
    self.state = "NONE"
    self.timer = 0
    self.enemy_shake = 0
    self.enemy_alpha = 1
    self.dust = nil
    self.dmg_text = nil
    self.paused_for_text = false

    -- música
    self.prev_music = Game.world.music.current
    local mus = PCDM.findMusic(config.music or "combate_light")
    if mus then Game.world.music:play(mus) end

    self.fade = 0
    Assets.playSound("tensionhorn", 0.6, 1.4)
    self:showText(config.intro or ("* " .. self.e.name .. " te corta el paso."), "MENU", true)
end

function UTBattle:gatherItems()
    local list = {}
    if Game.inventory and Game.inventory.getStorage then
        local ok, storage = pcall(function() return Game.inventory:getStorage("items") end)
        if ok and storage then
            for i = 1, storage.max or 8 do
                local it = storage[i]
                if it then
                    table.insert(list, { name = it:getName(), heal = it.heal_amount or 10, item = it, index = i })
                end
            end
        end
    end
    return list
end

-- ------------------------------------------------------------------ texto
function UTBattle:clearText()
    if self.text then
        self.text:remove()
        self.text = nil
    end
end

--- Muestra texto en la caja grande. next_state: estado al terminar. menu_text: si es el texto que acompaña al menú.
function UTBattle:showText(lines, next_state, menu_text, callback)
    self:clearText()
    self.box_target = { x = BOX_FULL.x, y = BOX_FULL.y, w = BOX_FULL.w, h = BOX_FULL.h }
    lines = PCDM.pages(lines, 33, 3)
    if menu_text then lines = { lines[1] } end
    local t = DialogueText(lines, BOX_FULL.x + 26, BOX_FULL.y + 18, BOX_FULL.w - 40, BOX_FULL.h - 20, { style = "none" })
    t.layer = 10
    self:addChild(t)
    self.text = t
    if menu_text then
        -- el texto del menú no se "avanza": se queda mientras eliges
        t.can_advance = false
        self.state = "MENU"
        self.menu_text = true
        return
    end
    self.menu_text = false
    self.state = "TEXT"
    t:setText(lines, function()
        self:clearText()
        if callback then callback() end
        if next_state then self:enter(next_state) end
    end)
end

-- ------------------------------------------------------------------ estados
function UTBattle:enter(state)
    self.state = state
    self.timer = 0
    if state == "MENU" then
        self.turn = self.turn + 1
        local flav = self.e.flavor
        local txt
        if self.e.spareable then
            txt = self.e.spareable_text or ("* " .. self.e.name .. " ya no quiere pelear.")
        elseif self.e.hp <= self.e.max_hp * 0.3 and self.e.low_text then
            txt = self.e.low_text
        elseif type(flav) == "table" then
            txt = flav[love.math.random(1, #flav)]
        else
            txt = flav or "* ..."
        end
        self:showText(txt, nil, true)
    elseif state == "ENEMY_TALK" then
        self:clearText()
        local d = self.e.dialogue
        local line
        if type(d) == "function" then
            line = d(self, self.turn)
        elseif type(d) == "table" then
            line = self.dialogue_override or d[love.math.random(1, #d)]
        end
        self.dialogue_override = nil
        if self.cfg.on_turn then
            local extra = self.cfg.on_turn(self, self.turn)
            if extra then line = extra end
        end
        if line then
            if type(line) == "string" then line = { line } end
            local bubble = DialogueText(line, 400, 40, 210, 100, { style = "none", font = "main", font_size = 16, color = { 0, 0, 0, 1 } })
            bubble.layer = 20
            bubble:setText(line, function()
                bubble:remove()
                self.bubble = nil
                self:enter("DODGE_START")
            end)
            self:addChild(bubble)
            self.bubble = bubble
        else
            self:enter("DODGE_START")
        end
        self.box_target = { x = 320 - BOX_DODGE_W / 2, y = 245, w = BOX_DODGE_W, h = BOX_DODGE_H }
    elseif state == "DODGE_START" then
        self.soul.x, self.soul.y = 320, 315
        self.soul.inv = 0
        self.bullets = {}
        local waves = self.e.waves or { "lluvia" }
        self.wave = waves[love.math.random(1, #waves)]
        self.wave_time = self.e.wave_time or 5
        self.spawn_timer = 0
        self.state = "DODGE"
    elseif state == "WIN" then
        self:clearText()
        local money = self.e.money or 2
        Game.lw_money = (Game.lw_money or 0) + money
        local lines
        if self.result == "kill" then
            lines = { "* ¡HAS GANADO!\n* Ganaste 0 EXP y " .. money .. " euros." }
        elseif self.result == "spare" then
            lines = { "* ¡HAS GANADO!\n* Ganaste 0 EXP y " .. money .. " euros." }
        else
            lines = { self.e.flee_text or ("* " .. self.e.name .. " huye.") }
        end
        if self.e.end_text then
            for _, l in ipairs(self.e.end_text) do table.insert(lines, l) end
        end
        self:showText(lines, "END")
    elseif state == "END" then
        self:finish()
    end
end

function UTBattle:finish()
    if self.done then return end
    local chara = Game.party[1]
    if chara then chara.lw_health = math.max(1, self.p.hp) end
    if self.prev_music then
        Game.world.music:play(self.prev_music)
    end
    self.done = true
    self:remove()
end

-- ------------------------------------------------------------------ acciones
function UTBattle:doFight()
    self.state = "FIGHT_BAR"
    self:clearText()
    self.bar_x = 0
    self.bar_dir = 1
    self.timer = 0
end

function UTBattle:resolveHit(accuracy)
    -- accuracy 0..1 (1 = centro perfecto)
    local base = (self.e.hit_damage or 12)
    local dmg = math.max(0, math.floor(base * (0.25 + accuracy) - (self.e.def or 0)))
    if accuracy <= 0 then dmg = 0 end
    self.state = "FIGHT_ANIM"
    self.timer = 0
    self.pending_dmg = dmg
    Assets.playSound("laz_c")
end

function UTBattle:applyHit()
    local dmg = self.pending_dmg or 0
    if dmg > 0 then
        Assets.playSound("damage")
        self.e.hp = self.e.hp - dmg
        self.enemy_shake = 12
        self.dmg_text = { txt = tostring(dmg), t = 0 }
    else
        self.dmg_text = { txt = "FALLO", t = 0 }
    end
    if self.e.on_hit then self.e.on_hit(self, dmg) end
end

function UTBattle:afterFight()
    if self.e.hp <= 0 then
        self.e.hp = 0
        if self.e.lethal then
            self.result = "kill"
            Assets.playSound("deathnoise")
            self.dust = 0
            local lines = self.e.death_text or { "* " .. self.e.name .. " se convirtió en polvo." }
            self:showText(lines, "WIN")
        else
            self.result = "flee"
            self:showText(self.e.defeat_text or { "* " .. self.e.name .. " ya no puede más." }, "WIN")
        end
        return
    end
    self:enter("ENEMY_TALK")
end

function UTBattle:doAct(act)
    local lines = act.text
    if type(lines) == "function" then lines = lines(self) end
    if type(lines) == "string" then lines = { lines } end
    if act.mercy then
        self.e.mercy = self.e.mercy + act.mercy
    end
    if act.func then act.func(self) end
    if act.dialogue then self.dialogue_override = act.dialogue end
    if self.e.mercy >= (self.e.mercy_needed or 100) and not self.e.spareable then
        self.e.spareable = true
        Assets.playSound("mercyadd")
    end
    self:showText(lines or { "* ..." }, "ENEMY_TALK")
end

function UTBattle:doCheck()
    self:showText({ "* " .. PCDM.upper(self.e.name) .. " - ATQ " .. (self.e.atk or 1) .. " DEF " .. (self.e.def or 0) .. "\n" .. (self.e.check or "* ...") }, "ENEMY_TALK")
end

function UTBattle:doItem(it)
    local heal = it.heal or 10
    self.p.hp = math.min(self.p.max_hp, self.p.hp + heal)
    Assets.playSound("power")
    local txt = "* Te comes " .. it.name .. ".\n* "
    if self.p.hp >= self.p.max_hp then txt = txt .. "¡Tus PV están al máximo!" else txt = txt .. "Recuperas " .. heal .. " PV." end
    if it.item and Game.inventory and Game.inventory.removeItem then
        pcall(function() Game.inventory:removeItem(it.item) end)
    end
    for i, v in ipairs(self.items) do
        if v == it then table.remove(self.items, i) break end
    end
    self:showText({ txt }, "ENEMY_TALK")
end

function UTBattle:doSpare()
    if self.e.spareable then
        self.result = "spare"
        Assets.playSound("spare")
        self.enemy_alpha = 0.5
        self:showText(self.e.spare_text or { "* Perdonaste a " .. self.e.name .. "." }, "WIN")
    else
        self:showText({ "* Perdonaste a " .. self.e.name .. ".\n* ...Pero su nombre no estaba [color:yellow]AMARILLO[color:reset]." }, "ENEMY_TALK")
    end
end

-- ------------------------------------------------------------------ balas
function UTBattle:addBullet(b)
    b.w = b.w or 10
    b.h = b.h or 10
    b.vx = b.vx or 0
    b.vy = b.vy or 0
    b.t = 0
    if b.sprite then b.tex = Assets.getTexture(b.sprite) end
    table.insert(self.bullets, b)
    return b
end

function UTBattle:spawnWave(dt)
    local box = self.box
    local p = self.e.wave_power or 1
    self.spawn_timer = self.spawn_timer + dt
    local w = self.wave
    local rate = ({ lluvia = 0.32, palabras = 0.55, lateral = 0.45, anillo = 1.6, apuntado = 0.6, stickers = 0.6 })[w] or 0.4
    rate = rate / p
    if self.spawn_timer < rate then return end
    self.spawn_timer = 0
    local spr = self.e.bullet_sprites and ("bullets/" .. self.e.bullet_sprites[love.math.random(1, #self.e.bullet_sprites)]) or "bullets/estrella"
    if w == "lluvia" then
        self:addBullet({ x = MathUtils.random(box.x + 8, box.x + box.w - 8), y = box.y - 14, vy = 2.6 + p, sprite = spr, w = 12, h = 12 })
    elseif w == "lateral" then
        local left = love.math.random(0, 1) == 0
        self:addBullet({ x = left and box.x - 14 or box.x + box.w + 14, y = MathUtils.random(box.y + 8, box.y + box.h - 8), vx = (left and 1 or -1) * (3 + p), sprite = spr, w = 12, h = 12 })
    elseif w == "palabras" then
        local word = self.e.bullet_words and self.e.bullet_words[love.math.random(1, #self.e.bullet_words)] or "!"
        local fw = self.small:getWidth(word) * 0.7
        self:addBullet({ x = MathUtils.random(box.x + fw / 2, box.x + box.w - fw / 2), y = box.y - 10, vy = 2 + p * 0.8, text = word, w = fw, h = 10 })
    elseif w == "apuntado" then
        local a = MathUtils.random(-math.pi, 0)
        local cx, cy = box.x + box.w / 2, box.y + box.h / 2
        local x, y = cx + math.cos(a) * 140, cy + math.sin(a) * 140
        local ang = MathUtils.angle(x, y, self.soul.x, self.soul.y)
        self:addBullet({ x = x, y = y, vx = math.cos(ang) * (3 + p), vy = math.sin(ang) * (3 + p), sprite = spr, w = 12, h = 12 })
    elseif w == "anillo" then
        local n = 10
        local gap = love.math.random(1, n)
        for i = 1, n do
            if math.abs(i - gap) > 1 then
                local a = i / n * math.pi * 2
                local x, y = self.soul.x + math.cos(a) * 110, self.soul.y + math.sin(a) * 110
                self:addBullet({ x = x, y = y, vx = -math.cos(a) * 2, vy = -math.sin(a) * 2, sprite = spr, w = 12, h = 12, life = 3 })
            end
        end
    elseif w == "stickers" then
        local x = MathUtils.random(box.x, box.x + box.w)
        self:addBullet({ x = x, y = box.y - 14, vy = 2, home = 0.06, sprite = "bullets/sticker", w = 12, h = 12, life = 4 })
    end
end

function UTBattle:updateDodge(dt)
    -- movimiento del alma
    local sp = 4 * DTMULT
    if Input.down("left") then self.soul.x = self.soul.x - sp end
    if Input.down("right") then self.soul.x = self.soul.x + sp end
    if Input.down("up") then self.soul.y = self.soul.y - sp end
    if Input.down("down") then self.soul.y = self.soul.y + sp end
    local box = self.box
    self.soul.x = MathUtils.clamp(self.soul.x, box.x + 10, box.x + box.w - 10)
    self.soul.y = MathUtils.clamp(self.soul.y, box.y + 10, box.y + box.h - 10)
    if self.soul.inv > 0 then self.soul.inv = self.soul.inv - dt end

    self.timer = self.timer + dt
    if self.timer < self.wave_time - 0.6 then
        self:spawnWave(dt)
    end
    for i = #self.bullets, 1, -1 do
        local b = self.bullets[i]
        b.t = b.t + dt
        if b.home then
            local ang = MathUtils.angle(b.x, b.y, self.soul.x, self.soul.y)
            b.vx = b.vx + math.cos(ang) * b.home * DTMULT
            b.vy = b.vy + math.sin(ang) * b.home * DTMULT
        end
        b.x = b.x + b.vx * DTMULT
        b.y = b.y + b.vy * DTMULT
        local dead = (b.life and b.t > b.life) or b.y > SCREEN_HEIGHT + 30 or b.x < -60 or b.x > SCREEN_WIDTH + 60 or b.y < -80
        -- choque
        if not dead and self.soul.inv <= 0 then
            if math.abs(b.x - self.soul.x) < (b.w / 2 + 5) and math.abs(b.y - self.soul.y) < (b.h / 2 + 5) then
                local dmg = math.max(1, (self.e.atk or 3) + love.math.random(0, 1))
                self.p.hp = self.p.hp - dmg
                self.soul.inv = 1
                Assets.playSound("hurt")
                dead = true
                if self.p.hp <= 0 then
                    self:gameOver()
                    return
                end
            end
        end
        if dead then table.remove(self.bullets, i) end
    end
    if self.timer >= self.wave_time then
        self.bullets = {}
        if self.cfg.after_wave then self.cfg.after_wave(self, self.turn) end
        if not self.done and self.state == "DODGE" then
            self:enter("MENU")
        end
    end
end

function UTBattle:gameOver()
    -- En el Light World no se muere: Aroy.exe te devuelve la vida (de mala gana)
    self.bullets = {}
    self.p.hp = self.p.max_hp
    self.state = "TEXT"
    self:clearText()
    Assets.playSound("pcdm_glitch")
    Game.stage:addChild(PCDMGlitch(0.8))
    self:showText({
        "[color:ff3a3a]* ¿EN SERIO?[wait:5] ¿TE HAS MUERTO AQUÍ?",
        "[color:ff3a3a]* Venga, te curo.[wait:5] Pero que no se repita.[wait:5]\n* Que esto lo he programado yo con la BECA MEC.",
    }, "MENU")
end

-- ------------------------------------------------------------------ input
function UTBattle:update()
    super.update(self)
    local dt = DT
    self.fade = math.min(1, self.fade + dt * 4)
    -- caja animada
    for _, k in ipairs({ "x", "y", "w", "h" }) do
        self.box[k] = MathUtils.approach(self.box[k], self.box_target[k], 30 * DTMULT)
    end
    if self.enemy_shake > 0 then self.enemy_shake = self.enemy_shake - DTMULT end
    if self.dmg_text then self.dmg_text.t = self.dmg_text.t + dt end
    if self.dust then self.dust = self.dust + dt end

    local s = self.state
    if s == "MENU" then
        if Input.pressed("left") then self.btn = (self.btn - 2) % 4 + 1; Assets.playSound("ui_move") end
        if Input.pressed("right") then self.btn = self.btn % 4 + 1; Assets.playSound("ui_move") end
        if Input.pressed("confirm") then
            Assets.playSound("ui_select")
            self.sub = 1
            if self.btn == 1 then
                self.state = "FIGHT_TARGET"
            elseif self.btn == 2 then
                self.state = "ACT_TARGET"
            elseif self.btn == 3 then
                if #self.items == 0 then
                    Assets.playSound("ui_cant_select")
                    self.state = "MENU"
                else
                    self.state = "ITEM_MENU"
                end
            else
                self.state = "MERCY_MENU"
            end
            if self.state ~= "MENU" and self.text then self.text.visible = false end
        end
    elseif s == "FIGHT_TARGET" or s == "ACT_TARGET" then
        if Input.pressed("cancel") then self:backToMenu() end
        if Input.pressed("confirm") then
            Assets.playSound("ui_select")
            if s == "FIGHT_TARGET" then self:doFight() else self.state = "ACT_MENU"; self.sub = 1 end
        end
    elseif s == "ACT_MENU" then
        local n = #(self.e.acts or {}) + 1
        self:moveSub(n, 2)
        if Input.pressed("cancel") then self.state = "ACT_TARGET" end
        if Input.pressed("confirm") then
            Assets.playSound("ui_select")
            if self.sub == 1 then self:doCheck() else self:doAct(self.e.acts[self.sub - 1]) end
        end
    elseif s == "ITEM_MENU" then
        self:moveSub(#self.items, 2)
        if Input.pressed("cancel") then self:backToMenu() end
        if Input.pressed("confirm") and self.items[self.sub] then
            Assets.playSound("ui_select")
            self:doItem(self.items[self.sub])
        end
    elseif s == "MERCY_MENU" then
        local n = self.cfg.can_flee and 2 or 1
        self:moveSub(n, 1)
        if Input.pressed("cancel") then self:backToMenu() end
        if Input.pressed("confirm") then
            Assets.playSound("ui_select")
            if self.sub == 1 then
                self:doSpare()
            else
                self.result = "flee"
                self:showText({ "* Huyes como una rata." }, "END")
            end
        end
    elseif s == "FIGHT_BAR" then
        self.timer = self.timer + dt
        self.bar_x = self.bar_x + 9 * DTMULT
        if Input.pressed("confirm") or self.bar_x > 560 then
            local d = math.abs(self.bar_x - 280) / 280
            local acc = self.bar_x > 560 and 0 or (1 - d)
            self:resolveHit(acc)
        end
    elseif s == "FIGHT_ANIM" then
        self.timer = self.timer + dt
        if self.timer >= 0.35 and not self.hit_applied then
            self.hit_applied = true
            self:applyHit()
        end
        if self.timer >= 1.3 then
            self.hit_applied = false
            self.dmg_text = nil
            self:afterFight()
        end
    elseif s == "DODGE" then
        self:updateDodge(dt)
    end
end

function UTBattle:moveSub(n, cols)
    if n <= 0 then return end
    if Input.pressed("down") then self.sub = math.min(n, self.sub + cols); Assets.playSound("ui_move") end
    if Input.pressed("up") then self.sub = math.max(1, self.sub - cols); Assets.playSound("ui_move") end
    if cols > 1 then
        if Input.pressed("right") and self.sub % cols ~= 0 and self.sub < n then self.sub = self.sub + 1; Assets.playSound("ui_move") end
        if Input.pressed("left") and self.sub % cols ~= 1 then self.sub = self.sub - 1; Assets.playSound("ui_move") end
    end
end

function UTBattle:backToMenu()
    self.state = "MENU"
    if self.text then self.text.visible = true end
end

-- ------------------------------------------------------------------ dibujo
function UTBattle:drawEnemy()
    local e = self.e
    local tex = e.tex
    if not tex and e.sprite then
        if type(e.sprite) == "table" then
            local fr = math.floor(love.timer.getTime() * 3) % #e.sprite + 1
            tex = Assets.getTexture(e.sprite[fr])
        else
            tex = Assets.getTexture(e.sprite)
        end
    end
    if not tex then return end
    local sc = e.scale or 4
    local w, h = tex:getWidth() * sc, tex:getHeight() * sc
    local x = 320 - w / 2 + (self.enemy_shake > 0 and math.sin(self.enemy_shake * 2) * 6 or 0)
    local y = 236 - h
    if self.dust then
        -- se deshace en polvo
        local a = math.max(0, 1 - self.dust)
        Draw.setColor(1, 1, 1, a)
        Draw.draw(tex, x, y - self.dust * 30, 0, sc, sc)
        for i = 1, 30 do
            Draw.setColor(1, 1, 1, a)
            love.graphics.rectangle("fill", x + (i * 37 % w), y + (i * 53 % h) - self.dust * (40 + i * 3), 3, 3)
        end
    else
        Draw.setColor(1, 1, 1, self.enemy_alpha)
        Draw.draw(tex, x, y, 0, sc, sc)
    end
    Draw.setColor(1, 1, 1, 1)
end

function UTBattle:drawBox()
    local b = self.box
    Draw.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle("line", b.x, b.y, b.w, b.h)
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", b.x + 2.5, b.y + 2.5, b.w - 5, b.h - 5)
    love.graphics.setLineWidth(1)
end

function UTBattle:drawStats()
    love.graphics.setFont(self.small)
    Draw.setColor(1, 1, 1, 1)
    local y = 400
    love.graphics.print(self.p.name, 32, y)
    love.graphics.print("LV " .. (self.p.lv or 1), 32 + self.small:getWidth(self.p.name) + 30, y)
    local hx = 300
    love.graphics.print("PV", hx - 34, y + 4, 0, 0.7, 0.7)
    Draw.setColor(0.8, 0, 0, 1)
    love.graphics.rectangle("fill", hx, y + 2, self.p.max_hp * 1.25, 21)
    Draw.setColor(1, 1, 0, 1)
    love.graphics.rectangle("fill", hx, y + 2, math.max(0, self.p.hp) * 1.25, 21)
    Draw.setColor(1, 1, 1, 1)
    love.graphics.print(math.max(0, self.p.hp) .. " / " .. self.p.max_hp, hx + self.p.max_hp * 1.25 + 14, y)
end

function UTBattle:drawButtons()
    love.graphics.setFont(self.small)
    for i, name in ipairs(BUTTONS) do
        local x = 32 + (i - 1) * 153
        local y = 432
        local sel = (self.state == "MENU" and self.btn == i)
        local c = sel and YELLOW or ORANGE
        Draw.setColor(c[1], c[2], c[3], 1)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", x, y, 110, 42)
        love.graphics.setLineWidth(1)
        love.graphics.print(name, x + 40, y + 9, 0, 0.85, 1)
        if sel then
            Draw.setColor(1, 0, 0, 1)
            Draw.draw(self.heart, x + 10, y + 13)
        else
            -- icono simple
            love.graphics.rectangle("fill", x + 12, y + 14, 14, 14)
        end
    end
    Draw.setColor(1, 1, 1, 1)
end

function UTBattle:drawMenuList(options, cols)
    love.graphics.setFont(self.font)
    for i, opt in ipairs(options) do
        local c = (i - 1) % cols
        local r = math.floor((i - 1) / cols)
        local x = BOX_FULL.x + 60 + c * 270
        local y = BOX_FULL.y + 20 + r * 32
        local col = opt.color or { 1, 1, 1 }
        Draw.setColor(col[1], col[2], col[3], 1)
        love.graphics.print(opt.text, x, y)
        if i == self.sub then
            Draw.setColor(1, 0, 0, 1)
            Draw.draw(self.heart, x - 28, y + 8)
        end
    end
    Draw.setColor(1, 1, 1, 1)
end

function UTBattle:draw()
    Draw.setColor(0, 0, 0, self.fade)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    Draw.setColor(1, 1, 1, 1)
    self:drawEnemy()
    self:drawBox()
    local s = self.state
    local name_col = self.e.spareable and YELLOW or { 1, 1, 1 }
    if s == "FIGHT_TARGET" or s == "ACT_TARGET" then
        self.sub = 1
        self:drawMenuList({ { text = "* " .. self.e.name, color = name_col } }, 1)
        -- barra de vida del enemigo
        if s == "FIGHT_TARGET" then
            Draw.setColor(0.8, 0, 0, 1)
            love.graphics.rectangle("fill", BOX_FULL.x + 360, BOX_FULL.y + 28, 100, 16)
            Draw.setColor(0, 1, 0, 1)
            love.graphics.rectangle("fill", BOX_FULL.x + 360, BOX_FULL.y + 28, 100 * math.max(0, self.e.hp) / self.e.max_hp, 16)
        end
    elseif s == "ACT_MENU" then
        local opts = { { text = "* Comprobar" } }
        for _, a in ipairs(self.e.acts or {}) do table.insert(opts, { text = "* " .. a.name }) end
        self:drawMenuList(opts, 2)
    elseif s == "ITEM_MENU" then
        local opts = {}
        for _, it in ipairs(self.items) do table.insert(opts, { text = "* " .. it.name }) end
        self:drawMenuList(opts, 2)
    elseif s == "MERCY_MENU" then
        local opts = { { text = "* Perdonar", color = name_col } }
        if self.cfg.can_flee then table.insert(opts, { text = "* Huir" }) end
        self:drawMenuList(opts, 1)
    elseif s == "FIGHT_BAR" or s == "FIGHT_ANIM" then
        -- diana
        local bx, by = BOX_FULL.x + 8, BOX_FULL.y + 8
        local w, h = BOX_FULL.w - 16, BOX_FULL.h - 16
        for i = 0, 10 do
            local f = 1 - math.abs(i - 5) / 5
            Draw.setColor(0.1 + 0.6 * f, 0.6 * f, 0.1, 1)
            love.graphics.rectangle("fill", bx + i * w / 11, by + 10, w / 11 - 2, h - 20)
        end
        Draw.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", bx + w / 2 - 2, by + 4, 4, h - 8)
        if s == "FIGHT_BAR" then
            Draw.setColor(1, 1, 1, 1)
            love.graphics.rectangle("fill", bx + self.bar_x, by, 8, h)
        else
            -- tajo
            local k = math.min(1, self.timer / 0.35)
            Draw.setColor(1, 0.2, 0.2, 1 - math.max(0, self.timer - 0.6))
            love.graphics.setLineWidth(4)
            love.graphics.line(300 - 40 + 80 * k, 120 - 40 + 80 * k, 300 - 40, 120 - 40)
            love.graphics.setLineWidth(1)
        end
    elseif s == "DODGE" then
        -- balas (solo se ven dentro de la caja, como en UNDERTALE)
        local bx = self.box
        Draw.pushScissor()
        Draw.scissor(bx.x + 2.5, bx.y + 2.5, bx.w - 5, bx.h - 5)
        for _, b in ipairs(self.bullets) do
            if b.text then
                love.graphics.setFont(self.small)
                Draw.setColor(1, 1, 1, 1)
                love.graphics.print(b.text, b.x - b.w / 2, b.y - 8, 0, 0.7, 0.7)
            elseif b.tex then
                Draw.setColor(1, 1, 1, 1)
                Draw.draw(b.tex, b.x, b.y, b.t * 3, 2, 2, b.tex:getWidth() / 2, b.tex:getHeight() / 2)
            else
                love.graphics.rectangle("fill", b.x - b.w / 2, b.y - b.h / 2, b.w, b.h)
            end
        end
        Draw.popScissor()
        -- alma
        if self.soul.inv <= 0 or math.floor(self.soul.inv * 10) % 2 == 0 then
            Draw.setColor(1, 0, 0, 1)
            Draw.draw(self.heart, self.soul.x - 8, self.soul.y - 8)
        end
    end
    if self.bubble then
        Draw.setColor(1, 1, 1, 1)
        love.graphics.rectangle("fill", 390, 30, 230, 110, 10, 10)
        love.graphics.polygon("fill", 390, 80, 376, 90, 390, 96)
    end
    if self.dmg_text then
        love.graphics.setFont(self.font)
        local t = self.dmg_text
        Draw.setColor(t.txt == "FALLO" and 0.7 or 1, t.txt == "FALLO" and 0.7 or 0.1, t.txt == "FALLO" and 0.7 or 0.1, 1)
        love.graphics.printf(t.txt, 0, 70 - math.sin(math.min(1, t.t * 3) * math.pi) * 20, SCREEN_WIDTH, "center")
        -- barra de vida del enemigo
        Draw.setColor(0.4, 0.4, 0.4, 1)
        love.graphics.rectangle("fill", 220, 110, 200, 14)
        Draw.setColor(0, 1, 0, 1)
        love.graphics.rectangle("fill", 220, 110, 200 * math.max(0, self.e.hp) / self.e.max_hp, 14)
    end
    self:drawStats()
    self:drawButtons()
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return UTBattle
