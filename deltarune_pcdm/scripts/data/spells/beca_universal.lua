-- Beca Universal
local spell, super = Class(PCDMSpell, "beca_universal")

function spell:init()
    super.init(self)
    self.name = "Beca Universal"
    self.effect = "Curar\nequipo"
    self.description = "Becas y ayudas para todo el\nmundo. Cura a todo el equipo."
    self.cost = 32
    self.target = "party"
    self.kind = "heal_all"
    self.power = {mag = 3, base = 15}
    self.fx = { kind = "hearts", color = {1, 0.45, 0.45}, sound = "power", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Ayudas para todes!"}
    self.tags = { "heal_all" }
end

return spell
