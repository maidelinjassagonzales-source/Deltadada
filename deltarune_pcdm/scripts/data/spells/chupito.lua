-- Chupito
local spell, super = Class(PCDMSpell, "chupito")

function spell:init()
    super.init(self)
    self.name = "Chupito"
    self.effect = "Cura\npropia"
    self.description = "Un chupito de ron miel.\nCura mucho a un aliado. Hic."
    self.cost = 16
    self.target = "ally"
    self.kind = "heal"
    self.power = {mag = 5, base = 45}
    self.fx = { kind = "bubbles", color = {1, 0.75, 0.3}, sound = "pcdm_trago", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* Hic."}
    self.tags = { "heal" }
end

return spell
