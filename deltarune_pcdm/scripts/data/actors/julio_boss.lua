-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "julio_boss")

function actor:init()
    super.init(self)
    self.name = "Julio"
    self.width = 64
    self.height = 56
    self.hitbox = {3, 42, 58, 12}
    self.soul_offset = {32, 30}
    self.color = {1, 1, 1}
    self.path = "chars/julio/boss"
    self.default = "idle"
    self.voice = "julio"
    self.portrait_path = "face/julio_dw"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 1/6, true},
        ["hurt"] = {"hurt", 1, false},
        ["spared"] = {"victory", 1/10, false},
        ["attack"] = {"attack", 1/15, false, next="idle"},
        ["spell"] = {"spell", 1/12, false, next="idle"},
        ["defeat"] = {"defeat", 1, false},
        ["act"] = {"act", 1/12, false, next="idle"},
        ["frozen"] = {"hurt", 1, false},
    }
    self.offsets = {
    }
end

return actor
