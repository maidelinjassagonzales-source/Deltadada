-- Power Geyser
local spell, super = Class(PCDMSpell, "power_geyser")

function spell:init()
    super.init(self)
    self.name = "Power Geyser"
    self.effect = "Daño\na todos"
    self.description = "¡POWER GEYSER! Columna de energía\nque golpea a todos los enemigos."
    self.cost = 40
    self.target = "enemies"
    self.kind = "damage_all"
    self.power = {atk = 4, mag = 5, base = 30, rnd = 10}
    self.fx = { kind = "sparks", color = {1, 0.85, 0.25}, sound = "rudebuster_swing", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡ARE YOU OKAY?!"}
    self.tags = { "damage_all" }
end

return spell
