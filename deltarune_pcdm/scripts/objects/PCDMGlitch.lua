-- Interferencia en pantalla cuando Aroy.exe interviene.
local PCDMGlitch, super = Class(Object)

function PCDMGlitch:init(time)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.layer = 2000
    self.time = time or 0.6
    self.timer = 0
    self.bars = {}
end

function PCDMGlitch:update()
    super.update(self)
    self.timer = self.timer + DT
    if self.timer >= self.time then
        self:remove()
        return
    end
    self.bars = {}
    for i = 1, love.math.random(3, 9) do
        table.insert(self.bars, {
            y = love.math.random(0, SCREEN_HEIGHT),
            h = love.math.random(2, 18),
            c = ({ { 1, 0, 0 }, { 0, 1, 0.3 }, { 0.2, 0.3, 1 }, { 1, 1, 1 } })[love.math.random(1, 4)],
            a = love.math.random() * 0.5 + 0.2,
            x = love.math.random(-40, 40),
        })
    end
end

function PCDMGlitch:draw()
    for _, b in ipairs(self.bars) do
        Draw.setColor(b.c[1], b.c[2], b.c[3], b.a)
        love.graphics.rectangle("fill", b.x, b.y, SCREEN_WIDTH, b.h)
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMGlitch
