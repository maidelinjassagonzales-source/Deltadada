-- Almas robadas que orbitan y luego se lanzan contra ti.
local Wave, super = Class(Wave, "almas")

local COLORS = { "roja", "rosa", "amarilla", "verde", "azul", "morada", "naranja", "cian" }

function Wave:init()
    super.init(self)
    self.time = 7
    self.orbit = {}
    self.t = 0
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local n = 6 + math.floor(p * 2)
    for i = 1, n do
        local bl = self:spawnBullet("pcdm", 0, 0, { sprite = "objects/alma_" .. COLORS[(i - 1) % #COLORS + 1], speed = 0, scale = 1.5 })
        bl.remove_offscreen = false
        bl.orbit_a = (i / n) * math.pi * 2
        bl.orbiting = true
        table.insert(self.orbit, bl)
    end
    self.timer:every(0.9 / p, function()
        for _, bl in ipairs(self.orbit) do
            if bl.orbiting and bl.parent then
                bl.orbiting = false
                local soul = Game.battle.soul
                if soul then
                    bl.physics.direction = MathUtils.angle(bl.x, bl.y, soul.x, soul.y)
                    bl.physics.speed = 5 + p
                end
                self.timer:after(3, function() if bl.parent then bl:remove() end end)
                break
            end
        end
    end)
end

function Wave:update()
    self.t = self.t + DT
    local l, t, r, b, cx, cy = WaveKit.arena()
    for _, bl in ipairs(self.orbit) do
        if bl.orbiting and bl.parent then
            local a = bl.orbit_a + self.t * 1.6
            bl.x = cx + math.cos(a) * 95
            bl.y = cy + math.sin(a) * 95
        end
    end
    super.update(self)
end

return Wave
