local encounter, super = Class(PCDMEncounter, "netanyahu")

function encounter:init()
    super.init(self)
    self.text = "* ¡Netanyahu viene a vengar a Trump!"
    self:setMusic("jefe")
    self:addEnemy("netanyahu")
end

return encounter
