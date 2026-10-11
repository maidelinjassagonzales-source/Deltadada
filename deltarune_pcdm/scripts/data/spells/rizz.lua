-- RIZZ
local spell, super = Class(PCDMSpell, "rizz")

function spell:init()
    super.init(self)
    self.name = "RIZZ"
    self.effect = "+Piedad\nENORME"
    self.description = "El aura definitiva de Xibin.\nDa muchísima piedad a un enemigo."
    self.cost = 40
    self.target = "enemy"
    self.kind = "mercy"
    self.power = {}
    self.fx = { kind = "sparks", color = {0.96, 0.8, 0.19}, sound = "sparkle_gem", count = 16 }
    self.mercy = 60
    self.cast_lines = {"* El enemigo se ha quedado embobado con el aura."}
    self.tags = { "mercy" }
end

return spell
