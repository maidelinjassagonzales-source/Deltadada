-- Ruta de Tally Hall
local spell, super = Class(PCDMSpell, "tally_hall_hall")

function spell:init()
    super.init(self)
    self.name = "Ruta de Tally Hall"
    self.effect = "Curar\nequipo"
    self.description = "Un concierto improvisado.\nCura a todo el equipo."
    self.cost = 28
    self.target = "party"
    self.kind = "heal_all"
    self.power = {mag = 3, base = 10}
    self.fx = { kind = "notes", color = {1, 0.85, 0.3}, sound = "power", count = 16 }
    self.mercy = 0
    self.cast_lines = nil
    self.tags = { "heal_all" }
end

return spell
