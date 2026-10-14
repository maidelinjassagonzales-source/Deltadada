-- Bala genérica del mod: puede ser un sprite o una PALABRA (los DMs de Pablo, "PROVE ME WRONG"...).
-- opts: sprite, text, color, dir, speed, spin, scale, gravity, accel, damage, home (velocidad de giro hacia el alma), life
local PCDMBullet, super = Class(Bullet, "pcdm")

function PCDMBullet:init(x, y, opts)
    opts = opts or {}
    super.init(self, x, y, opts.sprite)
    self.opts = opts
    self.text = opts.text
    if self.text then
        self.font = Assets.getFont("main_mono", 16) or Assets.getFont("main_mono")
        local w = self.font:getWidth(self.text)
        local h = self.font:getHeight()
        self.width, self.height = w, h
        self:setHitbox(2, 2, w - 4, h - 4)
        self:setOrigin(0.5, 0.5)
    else
        self:setOrigin(0.5, 0.5)
    end
    self:setScale(opts.scale or (self.text and 1 or 2))
    if opts.color then self:setColor(opts.color[1], opts.color[2], opts.color[3]) end
    self.physics.direction = opts.dir or 0
    self.physics.speed = opts.speed or 4
    self.physics.gravity = opts.gravity
    self.physics.gravity_direction = opts.gravity_dir or math.rad(90)
    self.physics.friction = opts.friction
    self.accel = opts.accel or 0
    self.spin = opts.spin or 0
    self.home = opts.home or 0
    self.life = opts.life
    if opts.damage then self.damage = opts.damage end
    if opts.tp then self.tp = opts.tp end
    self.remove_offscreen = opts.remove_offscreen ~= false
    self.timer_life = 0
end

function PCDMBullet:update()
    self.timer_life = self.timer_life + DT
    if self.accel ~= 0 then
        self.physics.speed = self.physics.speed + self.accel * DTMULT
    end
    if self.spin ~= 0 then
        self.rotation = self.rotation + self.spin * DTMULT
    end
    if self.home > 0 and Game.battle.soul then
        local target = MathUtils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
        self.physics.direction = MathUtils.approachAngle(self.physics.direction, target, self.home * DTMULT)
    end
    if self.life and self.timer_life >= self.life then
        self:remove()
        return
    end
    super.update(self)
end

function PCDMBullet:draw()
    if self.text then
        love.graphics.setFont(self.font)
        local r, g, b = unpack(self.opts.color or { 1, 1, 1 })
        Draw.setColor(0, 0, 0, self.alpha)
        love.graphics.print(self.text, 1, 1)
        Draw.setColor(r, g, b, self.alpha)
        love.graphics.print(self.text, 0, 0)
        Draw.setColor(1, 1, 1, 1)
    end
    super.draw(self)
end

return PCDMBullet
