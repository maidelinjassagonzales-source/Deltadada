-- Buster Wolf
local spell, super = Class(PCDMSpell, "buster_wolf")

function spell:init()
    super.init(self)
    self.name = "Buster Wolf"
    self.effect = "Daño\nBRUTAL"
    self.description = "¡ARE YOU OKAY? BUSTER WOLF!\nUn golpe enorme a un enemigo."
    self.cost = 60
    self.target = "enemy"
    self.kind = "damage"
    self.power = {atk = 14, mag = 4, base = 30, rnd = 15}
    self.fx = { kind = "sparks", color = {1, 0.3, 0.2}, sound = "criticalswing", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡¡BUSTER WOLF!!"}
    self.tags = { "damage" }
end

return spell
