local encounter, super = Class(PCDMEncounter, "motos")

function encounter:init()
    super.init(self)
    self.text = "* ¡Pablo Motos te invita a su programa!\n* La música suena al revés..."
    self:setMusic("jefe_motos")
    self:addEnemy("motos")
end

return encounter
