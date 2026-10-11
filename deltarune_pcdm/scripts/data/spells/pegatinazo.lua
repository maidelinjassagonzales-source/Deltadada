-- Pegatinazo
local spell, super = Class(PCDMSpell, "pegatinazo")

function spell:init()
    super.init(self)
    self.name = "Pegatinazo"
    self.effect = "Daño"
    self.description = "Pega un sticker con su cara\nen la frente del enemigo."
    self.cost = 16
    self.target = "enemy"
    self.kind = "damage"
    self.power = {atk = 6, mag = 6, base = 30, rnd = 10}
    self.fx = { kind = "stars", color = {1, 0.3, 0.3}, sound = "bump", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Toma sticker!"}
    self.tags = { "damage" }
end

return spell
