local encounter, super = Class(PCDMEncounter, "angelpedro")

function encounter:init()
    super.init(self)
    self.text = "* ¡Angel Pedro levanta una silla!\n* No sabe muy bien por qué."
    self:setMusic("jefe")
    self:addEnemy("angelpedro")
end

return encounter
