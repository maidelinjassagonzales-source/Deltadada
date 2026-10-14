-- Diálogo que interrumpe un ataque enemigo: el combate se PAUSA hasta que lo lees.
local PCDMInterjection, super = Class(Object)

function PCDMInterjection:init(lines, actor, face, callback)
    super.init(self, 0, 0)
    self.layer = BATTLE_LAYERS and BATTLE_LAYERS["top"] or 1000
    -- caja de diálogo normal: 26 letras por línea con retrato, 33 sin él
    self.lines = PCDM.pages(lines, face and 26 or 33, 3)
    self.index = 0
    self.actor = actor
    self.face = face
    self.callback = callback
    self.darken = 0
    self:nextLine()
end

function PCDMInterjection:nextLine()
    if self.textbox then
        self.textbox:remove()
        self.textbox = nil
    end
    self.index = self.index + 1
    if self.index > #self.lines then
        if self.callback then self.callback() end
        self:remove()
        return
    end
    local tb = Textbox(56, 344 - 120, 529, 103)
    tb.layer = 10
    self:addChild(tb)
    if self.actor then tb:setActor(self.actor) end
    tb:setFace(self.face)
    local line = self.lines[self.index]
    if self.actor == "aroy" and not line:find("^%[color") then line = "[color:ff3a3a][shake:1]" .. line end
    tb:setText(line, function() self:nextLine() end)
    tb.active = true
    tb.visible = true
    tb:setAdvance(true)
    tb:setSkippable(true)
    self.textbox = tb
end

function PCDMInterjection:draw()
    Draw.setColor(0, 0, 0, 0.45)
    love.graphics.rectangle("fill", -100, -100, SCREEN_WIDTH + 200, SCREEN_HEIGHT + 200)
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMInterjection
