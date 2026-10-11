-- FurryShock
local spell, super = Class(PCDMSpell, "furry_shock")

function spell:init()
    super.init(self)
    self.name = "FurryShock"
    self.effect = "Daño\nFURRO"
    self.description = "Descarga eléctrica de energía furra.\nDaño mágico a un enemigo."
    self.cost = 16
    self.target = "enemy"
    self.kind = "damage"
    self.power = {atk = 0, mag = 12, base = 60, rnd = 20}
    self.fx = { kind = "paws", color = {1, 0.48, 0.85}, sound = "icespell", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Uwu!"}
    self.tags = { "damage" }
end

return spell
