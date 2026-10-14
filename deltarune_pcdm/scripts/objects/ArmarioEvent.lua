-- El armario del aula. Pablo se mete dentro... y se abre una Fuente Oscura.
local ArmarioEvent, super = Class(Event)

function ArmarioEvent:init(x, y, properties)
    super.init(self, x, y, 44 * 2, 76 * 2)
    properties = properties or {}
    self.cutscene = properties.cutscene or "lw_aula.armario"
    self.solid = true
    self:refresh()
    self.collider = Hitbox(self, 0, 76, 88, 76)
    self.glow = 0
end

function ArmarioEvent:refresh()
    if PCDM.flag("armario_abierto") then
        self:setSprite("objects/armario_abierto", nil, false)
    else
        self:setSprite("objects/armario_cerrado", nil, false)
    end
end

function ArmarioEvent:setOpen(open)
    PCDM.setFlag("armario_abierto", open)
    self:refresh()
end

function ArmarioEvent:update()
    super.update(self)
    self.glow = self.glow + DT
end

function ArmarioEvent:draw()
    super.draw(self)
    if PCDM.flag("dia2") or PCDM.flag("armario_abierto") then
        local a = 0.25 + math.sin(self.glow * 3) * 0.15
        Draw.setColor(0.7, 0.3, 1, a)
        love.graphics.rectangle("fill", 8, 8, 72, 136)
        Draw.setColor(1, 1, 1, 1)
    end
end

function ArmarioEvent:onInteract(player, dir)
    self.world:startCutscene(self.cutscene, self, player, dir)
    return true
end

return ArmarioEvent
