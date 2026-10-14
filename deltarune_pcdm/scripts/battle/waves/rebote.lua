-- Objetos que rebotan dentro de la caja.
local Wave, super = Class(Wave, "rebote")

function Wave:init()
    super.init(self)
    self.time = 5.5
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local n = 2 + math.floor(p)
    for i = 1, n do
        self.timer:after((i - 1) * 0.6, function()
            local l, t, r, b, cx, cy = WaveKit.arena()
            local bl = self:spawnBullet("pcdm", MathUtils.random(l + 15, r - 15), t + 12, { sprite = WaveKit.sprite(self), dir = MathUtils.random(0.3, 2.8), speed = 3 + p })
            bl.remove_offscreen = false
            bl.bounce = true
        end)
    end
end

function Wave:update()
    local l, t, r, b = WaveKit.arena()
    for _, bl in ipairs(self.bullets) do
        if bl.bounce then
            local d = bl.physics.direction
            local vx, vy = math.cos(d), math.sin(d)
            if (bl.x < l + 6 and vx < 0) or (bl.x > r - 6 and vx > 0) then vx = -vx end
            if (bl.y < t + 6 and vy < 0) or (bl.y > b - 6 and vy > 0) then vy = -vy end
            bl.physics.direction = math.atan2(vy, vx)
        end
    end
    super.update(self)
end

return Wave
