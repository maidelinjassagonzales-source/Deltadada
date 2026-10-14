-- Generado por herramientas/abascal_caballo.py (sprites originales)
-- Abascal montado a caballo en el mapa del Cortijo
local actor, super = Class(Actor, "abascal_montado")

function actor:init()
    super.init(self)
    self.name = "Santiago Abascal"
    self.width = 80
    self.height = 72
    self.hitbox = {10, 56, 60, 14}
    self.color = {1, 1, 1}
    self.path = "chars/abascal/caballo"
    self.default = "idle"
    self.voice = "abascal"
    self.portrait_path = "face/abascal_dw"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 1/4, true},
    }
    self.offsets = {
    }
end

return actor
