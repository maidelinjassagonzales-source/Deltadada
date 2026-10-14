-- Efecto de FURRYGRAVE: tormenta de huellas, corazones y arcoíris. Daño FATAL a todos.
local FurryGraveSpell, super = Class(Object)

function FurryGraveSpell:init(user)
    super.init(self, 0, 0)
    self.caster = user
    self.timer = 0
    self.damage = 0
    self.hurt_done = false
    self.alpha = 0
    self.parts = {}
    self.dark = PCDM.flag("ruta_furrygrave", false)
    Assets.playSound("snowgrave", 0.6, self.dark and 0.7 or 1.15)
    Assets.playSound("pcdm_uwu", 0.5, self.dark and 0.5 or 1)
end

function FurryGraveSpell:update()
    super.update(self)
    self.timer = self.timer + DTMULT
    if self.timer < 12 then
        self.alpha = math.min(0.65, self.alpha + 0.06 * DTMULT)
    elseif self.timer > 92 then
        self.alpha = math.max(0, self.alpha - 0.03 * DTMULT)
    end
    if self.timer > 14 and self.timer < 80 then
        for i = 1, 2 do
            table.insert(self.parts, {
                x = love.math.random(-20, SCREEN_WIDTH + 20), y = -20,
                vy = love.math.random(6, 14), vx = love.math.random(-3, 3),
                kind = love.math.random(1, 3), size = love.math.random(6, 14),
                hue = love.math.random(),
            })
        end
    end
    for _, p in ipairs(self.parts) do
        p.y = p.y + p.vy * DTMULT
        p.x = p.x + p.vx * DTMULT
    end
    if not self.hurt_done and self.timer >= 95 then
        self.hurt_done = true
        for _, enemy in ipairs(Game.battle.enemies) do
            if enemy then
                enemy.hit_count = 0
                PCDM._furry_hit = true
                enemy:hurt(self.damage + MathUtils.round(MathUtils.random(100)), self.caster, enemy.onDefeatFatal)
                PCDM._furry_hit = false
                if enemy.health > 0 then enemy:flash() end
            end
        end
    end
    if self.timer >= 125 then
        Game.battle:finishAction()
        self:remove()
    end
end

local function hsv(h)
    local r, g, b = ColorUtils.HSVToRGB(h % 1, 0.55, 1)
    return r, g, b
end

function FurryGraveSpell:draw()
    if self.dark then
        Draw.setColor(0.15, 0, 0.1, self.alpha)
    else
        Draw.setColor(1, 0.45, 0.8, self.alpha * 0.8)
    end
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    -- franjas arcoíris
    if not self.dark then
        for i = 0, 5 do
            local r, g, b = hsv(i / 6 + self.timer / 120)
            Draw.setColor(r, g, b, self.alpha * 0.35)
            love.graphics.rectangle("fill", 0, ((i * 80) + self.timer * 6) % (SCREEN_HEIGHT + 80) - 80, SCREEN_WIDTH, 40)
        end
    end
    for _, p in ipairs(self.parts) do
        local r, g, b = hsv(p.hue)
        if self.dark then r, g, b = 0.6, 0.6, 0.65 end
        Draw.setColor(r, g, b, math.min(1, self.alpha * 1.6))
        if p.kind == 1 then
            love.graphics.circle("fill", p.x, p.y, p.size * 0.6)
            for k = -1, 1 do
                love.graphics.circle("fill", p.x + k * p.size * 0.6, p.y - p.size * 0.8, p.size * 0.25)
            end
        elseif p.kind == 2 then
            local s = p.size * 0.6
            love.graphics.circle("fill", p.x - s / 2, p.y, s / 2 + 0.5)
            love.graphics.circle("fill", p.x + s / 2, p.y, s / 2 + 0.5)
            love.graphics.polygon("fill", p.x - s, p.y + 1, p.x + s, p.y + 1, p.x, p.y + s * 1.3)
        else
            love.graphics.polygon("fill", p.x, p.y - p.size, p.x + p.size * 0.3, p.y, p.x, p.y + p.size, p.x - p.size * 0.3, p.y)
        end
    end
    if self.timer > 30 and self.timer < 90 then
        local f = Assets.getFont("main_mono")
        love.graphics.setFont(f)
        Draw.setColor(1, 1, 1, math.min(1, (self.timer - 30) / 15))
        local txt = self.dark and "FURRYGRAVE" or "F U R R Y G R A V E"
        love.graphics.printf(txt, 0, 60 + math.sin(self.timer / 5) * 4, SCREEN_WIDTH, "center")
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return FurryGraveSpell
