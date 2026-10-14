local encounter, super = Class(PCDMEncounter, "carpa_papeleta")

function encounter:init()
    super.init(self)
    self.text = "* ¡La Carpa y la Papeleta!\n* Huele a mitin."
    self:addEnemy("carpa")
    self:addEnemy("papeleta")
end

return encounter
