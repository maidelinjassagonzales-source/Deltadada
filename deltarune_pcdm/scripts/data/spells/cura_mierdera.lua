-- Cura Mierdera
local spell, super = Class(PCDMSpell, "cura_mierdera")

function spell:init()
    super.init(self)
    self.name = "Cura Mierdera"
    self.effect = "Cura\nmala"
    self.description = "Cura de mierda. Cura poquísimo.\nComo la de Susie. Es canon."
    self.cost = 30
    self.target = "ally"
    self.kind = "heal"
    self.power = {mag = 1, base = 10, rnd = 4}
    self.fx = { kind = "smoke", color = {0.7, 0.5, 0.9}, sound = "power", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* Ha curado... algo. Más o menos."}
    self.tags = { "heal" }
end

return spell
