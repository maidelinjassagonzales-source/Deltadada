local encounter, super = Class(PCDMEncounter, "pablo")

function encounter:init()
    super.init(self)
    self.text = "* ¡El Rey del Armario se levanta de\n  su trono!"
    self:setMusic("jefe")
    self:addEnemy("pablo")
end

return encounter
