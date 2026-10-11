-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "carmen_lw")

function actor:init()
    super.init(self)
    self.name = "Carmen"
    self.width = 24
    self.height = 44
    self.hitbox = {3, 30, 18, 12}
    self.soul_offset = {12, 24}
    self.color = {1, 1, 1}
    self.path = "chars/carmen/light"
    self.default = "walk"
    self.voice = "carmen"
    self.portrait_path = "face/carmen"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["fallen"] = {"fallen", 1, false},
    }
    self.offsets = {
        ["fallen"] = {-10, 18},
    }
end

return actor
