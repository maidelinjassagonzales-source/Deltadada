-- Espiral desde arriba de la caja.
local Wave, super = Class(Wave, "espiral")

function Wave:init()
    super.init(self)
    self.time = 6
    self.angle = 0
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self.timer:every(0.12 / math.sqrt(p), function()
        local l, t, r, b, cx, cy = WaveKit.arena()
        self.angle = self.angle + 0.45
        for k = 0, 1 do
            local a = self.angle + k * math.pi
            local bl = self:spawnBullet("pcdm", cx, t - 50, { sprite = WaveKit.sprite(self), dir = a, speed = 2.6 + p * 0.5 })
            bl.remove_offscreen = true
        end
    end)
end

return Wave
