local encounter, super = Class(PCDMEncounter, "abascal")

function encounter:init()
    super.init(self)
    self.text = "* ¡Abascal carga a caballo!\n* El caballo no quiere."
    self:setMusic("jefe")
    self:addEnemy("abascal")
end

return encounter
