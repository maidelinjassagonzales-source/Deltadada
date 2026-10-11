-- Los "gaster blasters" de Andrés: calaveras de lobo que disparan rayos.
local Wave, super = Class(Wave, "blasters")

function Wave:init()
    super.init(self)
    self.time = 7
end

function Wave:fire()
    local l, t, r, b, cx, cy = WaveKit.arena()
    local soul = Game.battle.soul
    if not soul then return end
    local horizontal = love.math.random(0, 1) == 0
    local spr = Sprite("objects/blaster_1")
    spr:setScale(2)
    spr:setOrigin(0.5, 0.5)
    spr.layer = BATTLE_LAYERS["above_bullets"]
    local tx, ty
    if horizontal then
        tx, ty = l - 70, soul.y
    else
        tx, ty = soul.x, t - 70
        spr.rotation = math.rad(90)
    end
    spr.x, spr.y = tx + (horizontal and -120 or 0), ty + (horizontal and 0 or -120)
    Game.battle:addChild(spr)
    table.insert(self.objects, spr)
    spr:slideTo(tx, ty, 0.35)
    Assets.playSound("pcdm_tijera", 0.6, 0.6)
    self.timer:after(0.75, function()
        spr:setSprite("objects/blaster_2")
        Assets.playSound("rudebuster_hit", 0.8)
        local beam
        if horizontal then
            beam = self:spawnBullet("pcdm", (l + r) / 2 + 40, ty, { sprite = "bullets/foco", dir = 0, speed = 0, scale = 1 })
            beam:setScale((r - l + 200) / 16, 1.6)
        else
            beam = self:spawnBullet("pcdm", tx, (t + b) / 2 + 40, { sprite = "bullets/foco", dir = 0, speed = 0, scale = 1 })
            beam:setScale(1.6, (b - t + 200) / 16)
        end
        beam:setColor(1, 1, 1)
        beam.remove_offscreen = false
        beam.destroy_on_hit = false
        self.timer:tween(0.5, beam, { alpha = 0 }, "linear", function() beam:remove() end)
        self.timer:after(0.5, function() spr:remove() end)
    end)
end

function Wave:onStart()
    local p = WaveKit.power(self)
    self:fire()
    self.timer:every(1.1 / p, function() self:fire() end)
    self.timer:every(0.5, function()
        local l, t, r, b = WaveKit.arena()
        self:spawnBullet("pcdm", MathUtils.random(l, r), t - 20, { sprite = "bullets/tijerita", dir = math.rad(90), speed = 3.5, spin = 0.2 })
    end)
end

return Wave
