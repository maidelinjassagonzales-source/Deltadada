-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "percha")

function actor:init()
    super.init(self)
    self.name = "Príncipe Percha"
    self.width = 26
    self.height = 44
    self.hitbox = {3, 30, 20, 12}
    self.soul_offset = {13, 24}
    self.color = {1, 1, 1}
    self.path = "chars/percha"
    self.default = "walk"
    self.voice = "percha"
    self.portrait_path = "face/percha"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
    }
    self.offsets = {
    }
end

return actor
