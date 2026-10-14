local encounter, super = Class(PCDMEncounter, "vito")

function encounter:init()
    super.init(self)
    self.text = "* ¡Vito Quiles te pone el micro en la cara!"
    self:setMusic("jefe")
    self:addEnemy("vito")
end

return encounter
