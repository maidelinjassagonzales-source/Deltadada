local encounter, super = Class(PCDMEncounter, "trump")

function encounter:init()
    super.init(self)
    self.text = "* ¡Trump bloquea el paso con su muro!\n* Tremendo."
    self:setMusic("jefe")
    self:addEnemy("trump")
end

return encounter
