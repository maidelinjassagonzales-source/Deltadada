local encounter, super = Class(PCDMEncounter, "ladrillo_carpa")

function encounter:init()
    super.init(self)
    self.text = "* ¡Un Ladrillo MAGA y una Carpa!\n* Quieren debatir sobre muros."
    self:addEnemy("ladrillo")
    self:addEnemy("carpa")
end

return encounter
