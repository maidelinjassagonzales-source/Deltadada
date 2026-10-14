-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "tijerafang")

function actor:init()
    super.init(self)
    self.name = "tijerafang"
    self.width = 96
    self.height = 110
    self.hitbox = {3, 96, 90, 12}
    self.soul_offset = {48, 60}
    self.color = {1, 1, 1}
    self.path = "bosses/tijerafang"
    self.default = "idle"
    self.voice = "andres"
    self.portrait_path = nil
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["hurt"] = {"hurt", 1, false},
        ["spared"] = {"idle", 0.2, true},
        ["angry"] = {"angry", 1, false},
        ["frozen"] = {"hurt", 1, false},
    }
    self.offsets = {
    }
end

return actor
