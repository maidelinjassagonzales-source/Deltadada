-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "alejandro_lw")

function actor:init()
    super.init(self)
    self.name = "Alejandro"
    self.width = 24
    self.height = 42
    self.hitbox = {3, 28, 18, 12}
    self.soul_offset = {12, 23}
    self.color = {1, 1, 1}
    self.path = "chars/alejandro/light"
    self.default = "walk"
    self.voice = "alejandro"
    self.portrait_path = "face/alejandro"
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
