-- Generado por herramientas/abascal_caballo.py (sprites originales)
-- Abascal montado a caballo (sprite de combate combinado)
local actor, super = Class(Actor, "abascal_caballo")

function actor:init()
    super.init(self)
    self.name = "Santiago Abascal"
    self.width = 80
    self.height = 72
    self.hitbox = {6, 58, 68, 12}
    self.soul_offset = {40, 36}
    self.color = {1, 1, 1}
    self.path = "chars/abascal/caballo"
    self.default = "idle"
    self.voice = "abascal"
    self.portrait_path = "face/abascal_dw"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 1/6, true},
        ["hurt"] = {"hurt", 1, false},
        ["spared"] = {"victory", 1/10, false},
        ["attack"] = {"attack", 1/15, false, next="idle"},
        ["spell"] = {"spell", 1/12, false, next="idle"},
        ["defeat"] = {"defeat", 1, false},
        ["act"] = {"act", 1/12, false, next="idle"},
        ["frozen"] = {"hurt", 1, false},
    }
    self.offsets = {
    }
end

return actor
