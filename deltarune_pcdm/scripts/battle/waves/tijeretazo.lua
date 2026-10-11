-- Tijeras gigantes que cruzan en diagonal.
local Wave, super = Class(Wave, "tijeretazo")

function Wave:init()
    super.init(self)
    self.time = 6
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self.timer:every(0.8 / p, function()
        local l, t, r, b, cx, cy = WaveKit.arena()
        local from_left = love.math.random(0, 1) == 0
        local x = from_left and l - 40 or r + 40
        local y = t - 40
        local soul = Game.battle.soul
        local dir = soul and MathUtils.angle(x, y, soul.x, soul.y) or math.rad(45)
        local bl = self:spawnBullet("pcdm", x, y, { sprite = "bullets/tijera_grande", dir = dir, speed = 5 + p, scale = 1.5 })
        bl.rotation = dir + math.rad(90)
        bl.remove_offscreen = false
        Assets.playSound("pcdm_tijera", 0.5)
        self.timer:after(3, function() if bl.parent then bl:remove() end end)
    end)
end

return Wave
