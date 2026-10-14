-- Cosas que caen del cielo dentro de la caja.
local Wave, super = Class(Wave, "lluvia")

function Wave:init()
    super.init(self)
    self.time = 5.5
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self.timer:every(0.42 / p, function()
        local l, t, r, b = WaveKit.arena()
        local x = MathUtils.random(l + 8, r - 8)
        self:spawnBullet("pcdm", x, t - 30, { sprite = WaveKit.sprite(self), dir = math.rad(90), speed = 3 + p, accel = 0.08, spin = 0.05 })
    end)
end

return Wave
