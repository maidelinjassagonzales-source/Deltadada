-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "escano")

function actor:init()
    super.init(self)
    self.name = "escano"
    self.width = 44
    self.height = 48
    self.hitbox = {3, 34, 38, 12}
    self.soul_offset = {22, 26}
    self.color = {1, 1, 1}
    self.path = "enemies/escano"
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
