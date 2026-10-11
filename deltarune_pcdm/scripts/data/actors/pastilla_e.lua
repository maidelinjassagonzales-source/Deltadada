-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "pastilla_e")

function actor:init()
    super.init(self)
    self.name = "pastilla_e"
    self.width = 36
    self.height = 44
    self.hitbox = {3, 30, 30, 12}
    self.soul_offset = {18, 24}
    self.color = {1, 1, 1}
    self.path = "enemies/pastilla_e"
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
