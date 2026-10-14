-- Parada de las Guaguas Global del Dark World: viaje rápido a zonas ya visitadas.
-- Propiedades: stop (id de la parada), name (nombre visible), map, marker
local GuaguaStop, super = Class(Event)

GuaguaStop.STOPS = {
    { id = "llanuras", name = "Llanuras del Armario", map = "dw/llanuras_3", marker = "guagua" },
    { id = "bosque", name = "Bosque de Tijeras", map = "dw/bosque_2", marker = "guagua" },
    { id = "plato", name = "Plató del Hormiguero", map = "dw/plato_2", marker = "guagua" },
    { id = "cortijo", name = "Cortijo de la Reconquista", map = "dw/cortijo_2", marker = "guagua" },
    { id = "muro", name = "El Muro", map = "dw/muro_1", marker = "guagua" },
}

function GuaguaStop:init(x, y, shape, properties)
    super.init(self, x, y, shape)
    properties = properties or {}
    self.stop = properties.stop or "llanuras"
    self:setSprite("objects/guagua", 0.5, false)
    self.solid = true
    self.collider = Hitbox(self, 0, 40, 240, 70)
end

function GuaguaStop:onLoad()
    if PCDM.flag("guaguas_activas") then
        PCDM.setFlag("parada_" .. self.stop, true)
    end
end

function GuaguaStop:onInteract(player, dir)
    self.world:startCutscene("npcs.guagua", self.stop)
    return true
end

return GuaguaStop
