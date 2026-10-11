-- Hidden in the Sand
local spell, super = Class(PCDMSpell, "hidden_in_the_sand")

function spell:init()
    super.init(self)
    self.name = "Hidden in the Sand"
    self.effect = "PERDONA\ncansados"
    self.description = "Canta Tally Hall. Si el enemigo\nestá CANSADO, lo perdona."
    self.cost = 24
    self.target = "enemy"
    self.kind = "pacify"
    self.power = {}
    self.fx = { kind = "notes", color = {0.5, 1, 0.6}, sound = "spell_pacify", count = 16 }
    self.mercy = 10
    self.cast_lines = nil
    self.tags = { "pacify" }
end

return spell
