-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "omega_aroy")

function actor:init()
    super.init(self)
    self.name = "omega_aroy"
    self.width = 160
    self.height = 120
    self.hitbox = {3, 106, 154, 12}
    self.soul_offset = {80, 66}
    self.color = {1, 1, 1}
    self.path = "bosses/omega_aroy"
    self.default = "idle"
    self.voice = "aroy"
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
