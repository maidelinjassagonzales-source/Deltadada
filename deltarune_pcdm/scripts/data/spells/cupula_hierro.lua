-- Cúpula de Hierro
local spell, super = Class(PCDMSpell, "cupula_hierro")

function spell:init()
    super.init(self)
    self.name = "Cúpula de Hierro"
    self.effect = "DEF\nequipo"
    self.description = "Un escudo que protege a todo el\nequipo. Sube la defensa en combate."
    self.cost = 40
    self.target = "party"
    self.kind = "buff_party"
    self.power = {}
    self.fx = { kind = "sparks", color = {0.4, 0.7, 1}, sound = "boost", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Escudo activado!"}
    self.tags = { "buff_party" }
end

function spell:onBuff(user)
    for _, battler in ipairs(Game.battle.party) do
        battler.chara:addStatBuff("defense", 4, 12)
        battler:statusMessage("msg", "up")
        battler:sparkle(0.4, 0.7, 1)
    end
end

return spell
