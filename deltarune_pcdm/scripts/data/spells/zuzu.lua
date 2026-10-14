-- ZUZU
local spell, super = Class(PCDMSpell, "zuzu")

function spell:init()
    super.init(self)
    self.name = "ZUZU"
    self.effect = "Daño\n+piedad"
    self.description = "Invoca a Zuzu, la fursona de Ángel.\nDaña y da piedad."
    self.cost = 45
    self.target = "enemy"
    self.kind = "damage"
    self.power = {mag = 10, base = 40, rnd = 15}
    self.fx = { kind = "paws", color = {1, 0.48, 0.72}, sound = "pcdm_uwu", count = 16 }
    self.mercy = 20
    self.cast_lines = {"* ¡ZUZU, YO TE ELIJO!"}
    self.tags = { "damage" }
end

return spell
