-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "carmen_boss")

function actor:init()
    super.init(self)
    self.name = "Carmen"
    self.width = 64
    self.height = 58
    self.hitbox = {3, 44, 58, 12}
    self.soul_offset = {32, 31}
    self.color = {1, 1, 1}
    self.path = "chars/carmen/boss"
    self.default = "idle"
    self.voice = "carmen"
    self.portrait_path = "face/carmen_dw"
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
