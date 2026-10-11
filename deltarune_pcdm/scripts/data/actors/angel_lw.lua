-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "angel_lw")

function actor:init()
    super.init(self)
    self.name = "Ángel"
    self.width = 24
    self.height = 47
    self.hitbox = {3, 33, 18, 12}
    self.soul_offset = {12, 25}
    self.color = {1, 1, 1}
    self.path = "chars/angel/light"
    self.default = "walk"
    self.voice = "angel"
    self.portrait_path = "face/angel"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["fallen"] = {"fallen", 1, false},
    }
    self.offsets = {
        ["fallen"] = {-12, 21},
    }
end

return actor
