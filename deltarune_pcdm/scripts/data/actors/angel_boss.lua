-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "angel_boss")

function actor:init()
    super.init(self)
    self.name = "Ángel"
    self.width = 64
    self.height = 61
    self.hitbox = {3, 47, 58, 12}
    self.soul_offset = {32, 33}
    self.color = {1, 1, 1}
    self.path = "chars/angel/boss"
    self.default = "idle"
    self.voice = "angel"
    self.portrait_path = "face/angel_dw"
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
