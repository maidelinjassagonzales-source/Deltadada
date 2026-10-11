-- Profecía
local spell, super = Class(PCDMSpell, "profecia")

function spell:init()
    super.init(self)
    self.name = "Profecía"
    self.effect = "Daño\na todos"
    self.description = "Profetiza la ruina de los enemigos.\nDaño mágico a todos."
    self.cost = 40
    self.target = "enemies"
    self.kind = "damage_all"
    self.power = {mag = 7, base = 20, rnd = 10}
    self.fx = { kind = "cards", color = {0.78, 0.5, 1}, sound = "spellcast", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* Las cartas no mienten."}
    self.tags = { "damage_all" }
end

return spell
