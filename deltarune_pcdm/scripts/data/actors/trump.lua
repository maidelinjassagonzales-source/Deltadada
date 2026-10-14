-- Generado por herramientas/generar_todo.py (sprites originales)
local actor, super = Class(Actor, "trump")

function actor:init()
    super.init(self)
    self.name = "Donald Trump"
    self.width = 24
    self.height = 42
    self.hitbox = {3, 28, 18, 12}
    self.soul_offset = {12, 23}
    self.color = {1, 1, 1}
    self.path = "chars/trump/dark"
    self.default = "walk"
    self.voice = "trump"
    self.portrait_path = "face/trump_dw"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["battle/idle"]         = {"battle/idle", 1/6, true},
        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},
        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},
        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},
        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},
        ["battle/swooned"]      = {"battle/defeat", 1/15, false},
        ["battle/transition"]   = {"walk/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/attack", 1/15, true},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
        ["fallen"] = {"fallen", 1, false},
    }
    self.offsets = {
        ["battle/idle"] = {-18, -12},
        ["battle/attack"] = {-18, -12},
        ["battle/attackready"] = {-18, -12},
        ["battle/act"] = {-18, -12},
        ["battle/actready"] = {-18, -12},
        ["battle/actend"] = {-18, -12},
        ["battle/spell"] = {-18, -12},
        ["battle/spellready"] = {-18, -12},
        ["battle/item"] = {-18, -12},
        ["battle/itemready"] = {-18, -12},
        ["battle/defend"] = {-18, -12},
        ["battle/hurt"] = {-18, -12},
        ["battle/defeat"] = {-18, -12},
        ["battle/victory"] = {-18, -12},
        ["fallen"] = {-9, 16},
    }
end

return actor
