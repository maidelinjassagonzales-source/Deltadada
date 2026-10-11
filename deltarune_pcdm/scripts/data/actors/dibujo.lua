-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "dibujo")

function actor:init()
    super.init(self)
    self.name = "dibujo"
    self.width = 40
    self.height = 48
    self.hitbox = {3, 34, 34, 12}
    self.soul_offset = {20, 26}
    self.color = {1, 1, 1}
    self.path = "enemies/dibujo"
    self.default = "idle"
    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 0.35, true},
        ["hurt"] = {"hurt", 1, false},
        ["spared"] = {"spared", 1, false},
        ["frozen"] = {"hurt", 1, false},
    }
    self.offsets = {
    }
end

return actor
