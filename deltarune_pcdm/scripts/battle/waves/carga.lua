-- Una embestida enorme cruzando la caja (caballo, tren...), con aviso previo.
local Wave, super = Class(Wave, "carga")

function Wave:init()
    super.init(self)
    self.time = 6
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local function charge()
        local l, t, r, b = WaveKit.arena()
        local y = MathUtils.random(t + 20, b - 20)
        local side = love.math.random(0, 1) == 0 and -1 or 1
        local warn = Rectangle(l, y - 14, r - l, 28)
        warn:setColor(1, 0, 0, 0.35)
        warn.layer = BATTLE_LAYERS["below_bullets"]
        Game.battle:addChild(warn)
        table.insert(self.objects, warn)
        Assets.playSound("alert")
        self.timer:after(0.6, function()
            warn:remove()
            local x = side > 0 and (l - 80) or (r + 80)
            local bl = self:spawnBullet("pcdm", x, y, { sprite = WaveKit.sprite(self, "vagon"), dir = side > 0 and 0 or math.pi, speed = 10 + p * 2, scale = 3 })
            bl.remove_offscreen = false
            self.timer:after(3, function() if bl.parent then bl:remove() end end)
        end)
    end
    charge()
    self.timer:every(1.3 / p, charge)
    self.timer:every(0.6, function()
        local l, t, r, b = WaveKit.arena()
        self:spawnBullet("pcdm", MathUtils.random(l, r), t - 20, { sprite = WaveKit.sprite(self), dir = math.rad(90), speed = 3 })
    end)
end

return Wave
