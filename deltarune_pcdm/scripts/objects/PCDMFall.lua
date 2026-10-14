-- La caída al Dark World a través del armario.
-- Siluetas del grupo cayendo en espiral entre destellos (efecto original).
local PCDMFall, super = Class(Object)

function PCDMFall:init(actors, time)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.layer = 1600
    self.time = time or 4.5
    self.timer = 0
    self.done = false
    self.chars = {}
    for i, a in ipairs(actors or {}) do
        local tex = Assets.getTexture("chars/" .. a .. "/light/walk/down_1")
        table.insert(self.chars, {
            tex = tex, x = 120 + (i - 1) * (400 / math.max(1, #actors - 1 + 1)),
            y = -60 - i * 40, rot = 0, spin = (love.math.random() - 0.5) * 0.2, vy = 3 + love.math.random() * 2,
        })
    end
    self.sparks = {}
    Assets.playSound("dtrans_lw", 0.8)
    Assets.playSound("dtrans_drone", 0.5)
end

function PCDMFall:update()
    super.update(self)
    self.timer = self.timer + DT
    for _, ch in ipairs(self.chars) do
        ch.y = ch.y + ch.vy * DTMULT
        ch.rot = ch.rot + ch.spin * DTMULT
        if ch.y > SCREEN_HEIGHT + 60 then ch.y = -80 end
    end
    if love.math.random() < 0.6 then
        table.insert(self.sparks, { x = love.math.random(0, SCREEN_WIDTH), y = SCREEN_HEIGHT + 10, vy = -love.math.random(4, 12), life = 1 })
    end
    for i = #self.sparks, 1, -1 do
        local s = self.sparks[i]
        s.y = s.y + s.vy * DTMULT
        s.life = s.life - DT * 0.7
        if s.life <= 0 then table.remove(self.sparks, i) end
    end
    if self.timer > self.time - 1.2 and not self.flipped then
        self.flipped = true
        Assets.playSound("dtrans_flip", 0.8)
    end
    if self.timer >= self.time then
        self.done = true
        self:remove()
    end
end

function PCDMFall:draw()
    local t = self.timer
    -- fondo: del blanco del aula a la oscuridad morada
    local k = math.min(1, t / 1.2)
    Draw.setColor(0.05 * k, 0, 0.1 * k, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    -- líneas de velocidad
    for i = 0, 14 do
        local x = (i * 47 + t * 90) % SCREEN_WIDTH
        Draw.setColor(0.6, 0.3, 1, 0.25)
        love.graphics.rectangle("fill", x, ((i * 97) - t * 900) % (SCREEN_HEIGHT + 200) - 100, 2, 80)
    end
    for _, s in ipairs(self.sparks) do
        Draw.setColor(1, 0.5, 0.85, s.life)
        love.graphics.rectangle("fill", s.x, s.y, 3, 3)
    end
    for _, ch in ipairs(self.chars) do
        if ch.tex then
            Draw.setColor(1, 1, 1, 1)
            Draw.draw(ch.tex, ch.x, ch.y, ch.rot, 2, 2, ch.tex:getWidth() / 2, ch.tex:getHeight() / 2)
        end
    end
    -- destello final
    if t > self.time - 0.6 then
        Draw.setColor(1, 1, 1, (t - (self.time - 0.6)) / 0.6)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMFall
