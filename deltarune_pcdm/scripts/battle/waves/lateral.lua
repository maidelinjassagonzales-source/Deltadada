-- Cosas que cruzan la caja de lado a lado.
local Wave, super = Class(Wave, "lateral")

function Wave:init()
    super.init(self)
    self.time = 5.5
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local side = 1
    self.timer:every(0.5 / p, function()
        local l, t, r, b = WaveKit.arena()
        local y = MathUtils.random(t + 8, b - 8)
        side = -side
        local x = side > 0 and (l - 40) or (r + 40)
        local bl = self:spawnBullet("pcdm", x, y, { sprite = WaveKit.sprite(self), dir = side > 0 and 0 or math.pi, speed = 4 + p * 1.5 })
        bl.remove_offscreen = false
        self.timer:after(4, function() if bl.parent then bl:remove() end end)
    end)
end

return Wave
