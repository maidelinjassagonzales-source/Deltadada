-- Stickers de Dayron que giran y te persiguen un poco.
local Wave, super = Class(Wave, "stickers")

function Wave:init()
    super.init(self)
    self.time = 6
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self.timer:every(0.65 / p, function()
        local l, t, r, b, cx, cy = WaveKit.arena()
        local a = MathUtils.random(-math.pi, 0)
        local x, y = cx + math.cos(a) * 170, cy + math.sin(a) * 170
        local bl = self:spawnBullet("pcdm", x, y, { sprite = "bullets/sticker", dir = a + math.pi, speed = 3 + p * 0.5, spin = 0.15, home = 0.03, life = 3.5 })
        bl.remove_offscreen = false
    end)
end

return Wave
