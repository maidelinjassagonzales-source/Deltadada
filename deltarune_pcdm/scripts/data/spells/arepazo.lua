-- Arepazo
local spell, super = Class(PCDMSpell, "arepazo")

function spell:init()
    super.init(self)
    self.name = "Arepazo"
    self.effect = "Curar\naliado"
    self.description = "Una arepa rellena de amor.\nCura mucho a un aliado."
    self.cost = 24
    self.target = "ally"
    self.kind = "heal"
    self.power = {mag = 5, base = 60}
    self.fx = { kind = "hearts", color = {1, 0.85, 0.5}, sound = "power", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Épale, qué rica!"}
    self.tags = { "heal" }
end

return spell
