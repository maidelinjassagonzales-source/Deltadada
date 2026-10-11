local encounter, super = Class(PCDMEncounter, "trio_andres")

function encounter:init()
    super.init(self)
    self.text = "* ¡Las cosas de Andrés cobran vida!"
    self:addEnemy("tijera")
    self:addEnemy("marine")
    self:addEnemy("silla")
end

return encounter
