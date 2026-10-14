-- Gabriel lucha hasta el final: tajos de hacha morada y estrellas.
local Wave, super = Class(Wave, "hacha")

function Wave:init()
    super.init(self)
    self.time = 7
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self.timer:every(0.9 / p, function()
        local l, t, r, b, cx, cy = WaveKit.arena()
        for k = -1, 1, 2 do
            local x = k < 0 and l - 30 or r + 30
            local y = MathUtils.random(t + 10, b - 10)
            local bl = self:spawnBullet("pcdm", x, y, { sprite = "bullets/estrella", dir = k < 0 and 0 or math.pi, speed = 5 + p, spin = 0.3, color = { 0.85, 0.4, 1 } })
            bl.remove_offscreen = false
            self.timer:after(3, function() if bl.parent then bl:remove() end end)
        end
    end)
    self.timer:every(1.4 / p, function()
        local soul = Game.battle.soul
        if not soul then return end
        for i = 0, 7 do
            local a = i * math.pi / 4
            local bl = self:spawnBullet("pcdm", soul.x + math.cos(a) * 120, soul.y + math.sin(a) * 120, { sprite = "bullets/nota", dir = a + math.pi, speed = 2.5, color = { 0.85, 0.4, 1 } })
            bl.remove_offscreen = false
            self.timer:after(3, function() if bl.parent then bl:remove() end end)
        end
    end)
end

return Wave
