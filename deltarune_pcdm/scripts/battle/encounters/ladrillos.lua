local encounter, super = Class(PCDMEncounter, "ladrillos")

function encounter:init()
    super.init(self)
    self.text = "* ¡Un muro de Ladrillos MAGA!"
    self:addEnemy("ladrillo")
    self:addEnemy("ladrillo")
end

return encounter
