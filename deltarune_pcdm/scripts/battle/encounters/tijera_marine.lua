local encounter, super = Class(PCDMEncounter, "tijera_marine")

function encounter:init()
    super.init(self)
    self.text = "* ¡Una Tijerita y un Marine de Cartón!\n* Huele a Andrés."
    self:addEnemy("tijera")
    self:addEnemy("marine")
end

return encounter
