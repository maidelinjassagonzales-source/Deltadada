-- Aroy.exe rompe el juego: bloques de interferencia (avisan antes de hacer daño).
local Wave, super = Class(Wave, "glitch")

function Wave:init()
    super.init(self)
    self.time = 7
end

function Wave:onStart()
    WaveKit.maybeInterject(self)
    local p = WaveKit.power(self)
    self.timer:every(0.45 / p, function()
        local l, t, r, b = WaveKit.arena()
        local x, y = MathUtils.random(l + 10, r - 10), MathUtils.random(t + 10, b - 10)
        local warn = Rectangle(x - 16, y - 16, 32, 32)
        warn:setColor(1, 0, 0, 0.4)
        warn.layer = BATTLE_LAYERS["below_bullets"]
        Game.battle:addChild(warn)
        table.insert(self.objects, warn)
        self.timer:after(0.45, function()
            warn:remove()
            local bl = self:spawnBullet("pcdm", x, y, { sprite = "bullets/glitch", speed = 0, scale = 3.2 })
            bl.destroy_on_hit = false
            self.timer:after(0.5, function() if bl.parent then bl:remove() end end)
        end)
    end)
    self.timer:every(0.8, function()
        local l, t, r, b = WaveKit.arena()
        self:spawnBullet("pcdm", MathUtils.random(l, r), t - 20, { sprite = "bullets/lagrima", dir = math.rad(90), speed = 4 })
    end)
end

return Wave
