-- JakoSherry
local spell, super = Class(PCDMSpell, "jakosherry")

function spell:init()
    super.init(self)
    self.name = "JakoSherry"
    self.effect = "Daño\na todos"
    self.description = "Invoca a JakoSherry desde Roblox.\nDaño a todos los enemigos."
    self.cost = 35
    self.target = "enemies"
    self.kind = "damage_all"
    self.power = {mag = 6, base = 30, rnd = 10}
    self.fx = { kind = "sparks", color = {0.79, 0.6, 0.36}, sound = "bump", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡OOF!"}
    self.tags = { "damage_all" }
end

return spell
