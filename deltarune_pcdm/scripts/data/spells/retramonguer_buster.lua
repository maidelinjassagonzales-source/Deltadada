-- Retramonguer Buster
local spell, super = Class(PCDMSpell, "retramonguer_buster")

function spell:init()
    super.init(self)
    self.name = "Retramonguer Buster"
    self.effect = "Daño\nRUDO"
    self.description = "Un Rude Buster de imitación.\nGabriel lo ha practicado mucho."
    self.cost = 50
    self.target = "enemy"
    self.kind = "damage"
    self.power = {atk = 11, mag = 5, base = 10, rnd = 10}
    self.fx = { kind = "stars", color = {0.85, 0.3, 1}, sound = "rudebuster_swing", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Por Susie, joder!"}
    self.tags = { "damage" }
end

return spell
