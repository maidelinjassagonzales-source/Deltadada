-- Abrazo Furro
local spell, super = Class(PCDMSpell, "abrazo_furro")

function spell:init()
    super.init(self)
    self.name = "Abrazo Furro"
    self.effect = "Curar\naliado"
    self.description = "Un abrazo blandito que cura\nbastante a un aliado."
    self.cost = 32
    self.target = "ally"
    self.kind = "heal"
    self.power = {mag = 6, base = 20}
    self.fx = { kind = "hearts", color = {1, 0.6, 0.8}, sound = "power", count = 16 }
    self.mercy = 0
    self.cast_lines = nil
    self.tags = { "heal" }
end

return spell
