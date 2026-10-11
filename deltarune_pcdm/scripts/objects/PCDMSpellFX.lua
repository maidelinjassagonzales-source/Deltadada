-- Efectos visuales genéricos para la magia del equipo (partículas, iconos, estrellas...).
local PCDMSpellFX, super = Class(Object)

-- kind: "stars", "hearts", "notes", "paws", "smoke", "sparks", "cards", "bubbles", "stickers"
function PCDMSpellFX:init(x, y, kind, color, count, duration)
    super.init(self, x, y)
    self.kind = kind or "stars"
    self.fxcolor = color or { 1, 1, 1 }
    self.duration = duration or 0.8
    self.timer = 0
    self.parts = {}
    for i = 1, count or 14 do
        local a = love.math.random() * math.pi * 2
        local s = love.math.random(2, 7)
        table.insert(self.parts, {
            x = 0, y = 0, vx = math.cos(a) * s, vy = math.sin(a) * s - 1,
            r = love.math.random() * 6, size = love.math.random(3, 7),
        })
    end
    self.layer = BATTLE_LAYERS and BATTLE_LAYERS["above_battlers"] or 200
end

function PCDMSpellFX:update()
    super.update(self)
    self.timer = self.timer + DT
    for _, p in ipairs(self.parts) do
        p.x = p.x + p.vx * DTMULT
        p.y = p.y + p.vy * DTMULT
        p.vx = p.vx * 0.94
        p.vy = p.vy * 0.94 + (self.kind == "bubbles" and -0.05 or 0.06)
        p.r = p.r + 0.2 * DTMULT
    end
    if self.timer >= self.duration then self:remove() end
end

local function heart(x, y, s)
    love.graphics.circle("fill", x - s / 2, y, s / 2 + 0.5)
    love.graphics.circle("fill", x + s / 2, y, s / 2 + 0.5)
    love.graphics.polygon("fill", x - s, y + 1, x + s, y + 1, x, y + s * 1.3)
end

function PCDMSpellFX:draw()
    local a = 1 - math.max(0, (self.timer - self.duration * 0.6) / (self.duration * 0.4))
    local c = self.fxcolor
    for _, p in ipairs(self.parts) do
        Draw.setColor(c[1], c[2], c[3], a)
        if self.kind == "hearts" then
            heart(p.x, p.y, p.size)
        elseif self.kind == "notes" then
            love.graphics.rectangle("fill", p.x, p.y, 3, 3)
            love.graphics.rectangle("fill", p.x + 2, p.y - 8, 1, 8)
            love.graphics.rectangle("fill", p.x + 2, p.y - 8, 4, 2)
        elseif self.kind == "paws" then
            love.graphics.circle("fill", p.x, p.y, p.size * 0.6)
            for k = -1, 1 do
                love.graphics.circle("fill", p.x + k * p.size * 0.6, p.y - p.size * 0.8, p.size * 0.25)
            end
        elseif self.kind == "smoke" then
            love.graphics.circle("fill", p.x, p.y, p.size * (1 + self.timer))
        elseif self.kind == "cards" then
            love.graphics.push()
            love.graphics.translate(p.x, p.y)
            love.graphics.rotate(p.r)
            love.graphics.rectangle("fill", -4, -6, 8, 12)
            Draw.setColor(0.55, 0.25, 0.75, a)
            love.graphics.rectangle("fill", -2, -3, 4, 6)
            love.graphics.pop()
        elseif self.kind == "bubbles" then
            love.graphics.circle("line", p.x, p.y, p.size)
        elseif self.kind == "sparks" then
            love.graphics.line(p.x, p.y, p.x - p.vx * 2, p.y - p.vy * 2)
        else
            local s = p.size
            love.graphics.push()
            love.graphics.translate(p.x, p.y)
            love.graphics.rotate(p.r)
            love.graphics.polygon("fill", 0, -s, s * 0.3, -s * 0.3, s, 0, s * 0.3, s * 0.3, 0, s, -s * 0.3, s * 0.3, -s, 0, -s * 0.3, -s * 0.3)
            love.graphics.pop()
        end
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMSpellFX
