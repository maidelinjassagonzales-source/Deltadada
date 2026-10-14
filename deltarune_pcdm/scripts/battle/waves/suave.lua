-- Ataque flojito: los del bando bueno no quieren pelear contigo...
local Wave, super = Class(Wave, "suave")

function Wave:init()
    super.init(self)
    self.time = 4
end

function Wave:onStart()
    self.timer:every(0.9, function()
        local l, t, r, b = WaveKit.arena()
        local bl = self:spawnBullet("pcdm", MathUtils.random(l + 10, r - 10), t - 20, { sprite = "bullets/corazon_blanco", dir = math.rad(90), speed = 1.6 })
        bl.damage = 4
    end)
end

return Wave
