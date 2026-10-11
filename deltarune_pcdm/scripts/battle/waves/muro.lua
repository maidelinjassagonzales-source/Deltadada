-- Filas de balas (ladrillos) que bajan con un hueco.
local Wave, super = Class(Wave, "muro")

function Wave:init()
    super.init(self)
    self.time = 6.5
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local function row()
        local l, t, r, b = WaveKit.arena()
        local w = r - l
        local n = 7
        local gap = love.math.random(1, n - 1)
        local spr = WaveKit.sprite(self, "ladrillo")
        for i = 0, n do
            if i ~= gap and i ~= gap + 1 then
                local bl = self:spawnBullet("pcdm", l + (i / n) * w, t - 30, { sprite = spr, dir = math.rad(90), speed = 2 + p * 0.6 })
                bl.remove_offscreen = false
                self.timer:after(5, function() if bl.parent then bl:remove() end end)
            end
        end
    end
    row()
    self.timer:every(1.5 / p, row)
end

return Wave
