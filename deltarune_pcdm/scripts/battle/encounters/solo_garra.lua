local encounter, super = Class(PCDMEncounter, "solo_garra")

function encounter:init()
    super.init(self)
    self.text = "* ¡Una Garra Furra salvaje!\n* Uwu."
    self:addEnemy("garra")
end

return encounter
