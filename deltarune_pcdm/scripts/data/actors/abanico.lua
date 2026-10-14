-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "abanico")

function actor:init()
    super.init(self)
    self.name = "abanico"
    self.width = 48
    self.height = 44
    self.hitbox = {3, 30, 42, 12}
    self.soul_offset = {24, 24}
    self.color = {1, 1, 1}
    self.path = "enemies/abanico"
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
