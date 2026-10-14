-- Sprite decorativo para los mapas (opcionalmente interactuable).
-- Propiedades: texture, speed, solid, cutscene, text, scale, oy
local DecoSprite, super = Class(Event)

function DecoSprite:init(x, y, properties)
    super.init(self, x, y, 40, 40)
    properties = properties or {}
    self.props = properties
    if properties.texture then
        self:setSprite(properties.texture, properties.speed)
        if properties.scale then self.sprite:setScale(properties.scale) end
    end
    self.solid = properties.solid or false
    self.cutscene = properties.cutscene
    self.text = properties.text
    if properties.oy then self.y = self.y + properties.oy end
    if properties.ox then self.x = self.x + properties.ox end
    if self.solid and self.sprite then
        -- caja de colisión solo en la parte de abajo
        local w, h = self.width, self.height
        self.collider = Hitbox(self, 4, math.max(0, h - 30), w - 8, math.min(h, 30))
    end
end

function DecoSprite:onInteract(player, dir)
    if self.cutscene then
        self.world:startCutscene(self.cutscene, self, player, dir)
        return true
    elseif self.text then
        self.world:startCutscene(function(c) c:text(self.text) end)
        return true
    end
end

return DecoSprite
