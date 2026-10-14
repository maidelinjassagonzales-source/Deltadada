-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "bellerin")

function actor:init()
    super.init(self)
    self.name = "Héctor Bellerín"
    self.width = 24
    self.height = 42
    self.hitbox = {3, 28, 18, 12}
    self.soul_offset = {12, 23}
    self.color = {1, 1, 1}
    self.path = "chars/bellerin/dark"
    self.default = "walk"
    self.voice = "bellerin"
    self.portrait_path = "face/bellerin_dw"
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
