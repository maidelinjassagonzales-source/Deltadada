-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "paco_lw")

function actor:init()
    super.init(self)
    self.name = "Paco el Guagüero"
    self.width = 24
    self.height = 42
    self.hitbox = {3, 28, 18, 12}
    self.soul_offset = {12, 23}
    self.color = {1, 1, 1}
    self.path = "chars/paco/light"
    self.default = "walk"
    self.voice = "paco"
    self.portrait_path = "face/paco"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["fallen"] = {"fallen", 1, false},
    }
    self.offsets = {
        ["fallen"] = {-9, 16},
    }
end

return actor
