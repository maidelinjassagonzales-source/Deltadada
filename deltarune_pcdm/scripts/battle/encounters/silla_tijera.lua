local encounter, super = Class(PCDMEncounter, "silla_tijera")

function encounter:init()
    super.init(self)
    self.text = "* ¡Una Silla y una Tijerita!"
    self:addEnemy("silla")
    self:addEnemy("tijera")
end

return encounter
