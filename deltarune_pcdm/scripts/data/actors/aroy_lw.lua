-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "aroy_lw")

function actor:init()
    super.init(self)
    self.name = "Aroy.exe"
    self.width = 24
    self.height = 47
    self.hitbox = {3, 33, 18, 12}
    self.soul_offset = {12, 25}
    self.color = {1, 1, 1}
    self.path = "chars/aroy/light"
    self.default = "walk"
    self.voice = "aroy"
    self.portrait_path = "face/aroy"
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
