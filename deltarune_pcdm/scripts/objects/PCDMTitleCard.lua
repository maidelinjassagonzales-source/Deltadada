-- Tarjeta negra con texto (cambios de punto de vista, capítulos, finales).
local PCDMTitleCard, super = Class(Object)

function PCDMTitleCard:init(title, subtitle, time, color)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.layer = 1500
    self.title = title or ""
    self.subtitle = subtitle
    self.time = time or 2.2
    self.timer = 0
    self.done = false
    self.color = color or { 1, 1, 1 }
    self.font = Assets.getFont("main_mono")
    self.small = Assets.getFont("main")
end

function PCDMTitleCard:update()
    super.update(self)
    self.timer = self.timer + DT
    if Input.pressed("confirm") and self.timer > 0.6 then
        self.timer = math.max(self.timer, self.time - 0.3)
    end
    if self.timer >= self.time then
        self.done = true
        self:remove()
    end
end

function PCDMTitleCard:draw()
    local a = 1
    if self.timer < 0.3 then a = self.timer / 0.3 end
    if self.timer > self.time - 0.3 then a = math.max(0, (self.time - self.timer) / 0.3) end
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setFont(self.font)
    Draw.setColor(self.color[1], self.color[2], self.color[3], a)
    love.graphics.printf(self.title, 0, SCREEN_HEIGHT / 2 - 40, SCREEN_WIDTH, "center")
    if self.subtitle then
        love.graphics.setFont(self.small)
        Draw.setColor(0.7, 0.7, 0.8, a)
        love.graphics.printf(self.subtitle, 20, SCREEN_HEIGHT / 2 + 10, SCREEN_WIDTH - 40, "center")
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMTitleCard
