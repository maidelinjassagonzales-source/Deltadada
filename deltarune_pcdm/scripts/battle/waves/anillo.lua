-- Anillo de balas que se cierra sobre el alma (con un hueco para escapar).
local Wave, super = Class(Wave, "anillo")

function Wave:init()
    super.init(self)
    self.time = 6
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local function ring()
        local soul = Game.battle.soul
        if not soul then return end
        local n = 12 + math.floor(p * 2)
        local gap = love.math.random(1, n)
        local spr = WaveKit.sprite(self)
        for i = 1, n do
            if math.abs(i - gap) > 1 then
                local a = (i / n) * math.pi * 2
                local x, y = soul.x + math.cos(a) * 130, soul.y + math.sin(a) * 130
                local bl = self:spawnBullet("pcdm", x, y, { sprite = spr, dir = a + math.pi, speed = 2.2 + p * 0.4 })
                bl.remove_offscreen = false
                self.timer:after(4, function() if bl.parent then bl:remove() end end)
            end
        end
    end
    ring()
    self.timer:every(2.2 / p, ring)
end

return Wave
