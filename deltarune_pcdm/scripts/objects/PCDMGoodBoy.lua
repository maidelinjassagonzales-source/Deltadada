-- "GOOD BOY" gigante cuando haces lo que Aroy.exe quiere.
local PCDMGoodBoy, super = Class(Object)

function PCDMGoodBoy:init()
    super.init(self, SCREEN_WIDTH / 2, 70)
    self.layer = 1900
    self.tex = Assets.getTexture("ui/goodboy")
    self.timer = 0
    self.alpha = 0
end

function PCDMGoodBoy:update()
    super.update(self)
    self.timer = self.timer + DT
    if self.timer < 0.3 then
        self.alpha = self.timer / 0.3
    elseif self.timer > 2.4 then
        self.alpha = math.max(0, 1 - (self.timer - 2.4) / 0.4)
        if self.alpha <= 0 then self:remove() end
    else
        self.alpha = 1
    end
end

function PCDMGoodBoy:draw()
    if self.tex then
        local s = 1 + math.sin(self.timer * 10) * 0.05
        local hue = (self.timer * 2) % 1
        Draw.setColor(1, 0.85 + 0.15 * math.sin(hue * 6.28), 0.3, self.alpha)
        Draw.draw(self.tex, 0, 0, math.sin(self.timer * 6) * 0.05, s, s, self.tex:getWidth() / 2, self.tex:getHeight() / 2)
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMGoodBoy
