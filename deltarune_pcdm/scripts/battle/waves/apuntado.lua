-- Disparos que apuntan al alma desde los bordes.
local Wave, super = Class(Wave, "apuntado")

function Wave:init()
    super.init(self)
    self.time = 5.5
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self.timer:every(0.7 / p, function()
        local l, t, r, b, cx, cy = WaveKit.arena()
        local a = MathUtils.random(0, math.pi * 2)
        local x, y = cx + math.cos(a) * 160, cy + math.sin(a) * 160
        local soul = Game.battle.soul
        local dir = soul and MathUtils.angle(x, y, soul.x, soul.y) or a + math.pi
        local bl = self:spawnBullet("pcdm", x, y, { sprite = WaveKit.sprite(self), dir = dir, speed = 1, accel = 0.25 + 0.1 * p })
        bl.remove_offscreen = false
        self.timer:after(4, function() if bl.parent then bl:remove() end end)
    end)
end

return Wave
