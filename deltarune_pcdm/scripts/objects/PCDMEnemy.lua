-- Base de todos los enemigos del mod.
-- Si es un personaje del BANDO MALO con nombre (bad_id), al bajarle la vida a 0 MUERE (como en Undertale)
-- y cuenta para el final verdadero. Si lo perdonas, cuenta como perdonado.
local PCDMEnemy, super = Class(EnemyBattler)

function PCDMEnemy:init(actor)
    super.init(self, actor)
    self.bad_id = nil            -- id del bando malo (pablo, trump...) si cuenta para los finales
    self.lethal = false          -- si al llegar a 0 HP muere (polvo) en vez de huir
    self.bullet_sprites = { "estrella" }
    self.bullet_words = nil
    self.word_color = { 1, 1, 1 }
    self.wave_power = 1
    self.act_data = {}           -- [nombre] = { text = {...}, mercy = n, tired = bool, func = fn }
    self.death_lines = nil       -- frase al morir (bocadillo)
    self.spare_lines = nil
    self.dust_color = { 1, 1, 1 }
    self.exit_on_defeat = true
    self.tired_percentage = 0.35
    self.low_health_percentage = 0.35
end

--- Configura un jefe a partir de una tabla
function PCDMEnemy:setup(t)
    self.name = t.name
    self.max_health = t.hp
    self.health = t.hp
    self.attack = t.atk or 6
    self.defense = t.def or 1
    self.money = t.money or 100
    self.experience = 0
    self.spare_points = t.spare_points or 0
    self.bad_id = t.bad_id
    self.lethal = t.lethal or false
    self.bullet_sprites = t.sprites or { "estrella" }
    self.bullet_words = t.words
    self.word_color = t.word_color or { 1, 1, 1 }
    self.wave_power = t.power or 1.2
    self.waves = t.waves or { "lluvia" }
    self.dialogue = t.dialogue or { "..." }
    self.check = t.check or "..."
    self.text = t.text or { "* ..." }
    self.low_health_text = t.low
    self.spareable_text = t.spareable
    self.death_lines = t.death
    if t.disable_mercy then self.disable_mercy = true end
    for _, a in ipairs(t.acts or {}) do
        self:act(a[1], a[2], a[3], a[4])
    end
end

-- Los jefes con nombre (Vito, Trump, Dayron...) se ven más grandes que el equipo
function PCDMEnemy:onAdd(parent)
    super.onAdd(self, parent)
    local id = self.actor and self.actor.id or ""
    if not self.only_furry and id:sub(-5) == "_boss" and not self.pcdm_scaled then
        self.pcdm_scaled = true
        self:setScale(3)
    end
end

--- Registra un ACT con datos (texto, piedad, cansancio, función extra)
function PCDMEnemy:act(name, data, description, party)
    self:registerAct(name, description or "", party)
    self.act_data[name] = data
end

function PCDMEnemy:onAct(battler, name)
    local d = self.act_data[name]
    if d then
        if d.mercy then self:addMercy(d.mercy) end
        if d.tired then self:setTired(true) end
        if d.dialogue then self.dialogue_override = d.dialogue end
        if d.func then
            local r = d.func(self, battler)
            if r ~= nil then return r end
        end
        local text = d.text
        if type(text) == "function" then text = text(self, battler) end
        if type(text) == "table" and type(text[1]) == "table" then
            -- varias variantes: se elige una al azar
            text = text[love.math.random(1, #text)]
        end
        return text
    end
    return super.onAct(self, battler, name)
end

function PCDMEnemy:isBadNamed()
    return self.bad_id ~= nil
end

-- Muerte "de verdad" (polvo como en Undertale)
function PCDMEnemy:dieForReal(damage, battler)
    self.hurt_timer = -1
    if self.bad_id then
        PCDM.kill(self.bad_id)
        Game.battle.pcdm_killed = Game.battle.pcdm_killed or {}
        table.insert(Game.battle.pcdm_killed, self.bad_id)
    end
    Assets.playSound("deathnoise")
    local sprite = self:getActiveSprite()
    sprite:stopShake()
    if self.death_lines then
        self:spawnSpeechBubble(self.death_lines)
    end
    local death_x, death_y = sprite:getRelativePos(0, 0, self)
    sprite.visible = false
    local death = FatalEffect(sprite:getTexture(), death_x, death_y, function() self:remove() end)
    death:setColor(sprite:getDrawColor())
    death:setScale(sprite:getScale())
    self:addChild(death)
    if self.onKilled then self:onKilled() end
    self:defeat("KILLED", true)
end

-- Los del bando bueno en la ruta FURRYGRAVE solo caen con FurryShock / FURRYGRAVE
function PCDMEnemy:hurt(amount, battler, on_defeat, color, show_status, attacked)
    if self.only_furry and not PCDM._furry_hit then
        amount = 0
    end
    if self.min_health and not PCDM._furry_hit and not (on_defeat and on_defeat == self.onDefeatFatal) then
        if self.health - amount < self.min_health then
            amount = math.max(0, self.health - self.min_health)
            if not self.refused_once then
                self.refused_once = true
                if self.on_refuse then self:on_refuse() end
            end
        end
    end
    if self.damage_mult and amount > 0 then
        amount = math.max(1, math.floor(amount * self.damage_mult))
    end
    return super.hurt(self, amount, battler, on_defeat, color, show_status, attacked)
end

function PCDMEnemy:onDefeat(damage, battler)
    if self.lethal or self.bad_id then
        self:dieForReal(damage, battler)
    else
        super.onDefeat(self, damage, battler)
    end
end

function PCDMEnemy:onDefeatFatal(damage, battler)
    if self.lethal or self.bad_id then
        self:dieForReal(damage, battler)
    else
        super.onDefeatFatal(self, damage, battler)
    end
end

function PCDMEnemy:freeze()
    if self.lethal or self.bad_id then
        self:dieForReal()
    else
        super.freeze(self)
    end
end

function PCDMEnemy:onSpared()
    if self.bad_id then
        PCDM.spare(self.bad_id)
    end
    if self.onSparedExtra then self:onSparedExtra() end
    super.onSpared(self)
end

return PCDMEnemy
