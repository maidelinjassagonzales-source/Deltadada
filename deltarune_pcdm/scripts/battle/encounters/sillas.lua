local encounter, super = Class(PCDMEncounter, "sillas")

function encounter:init()
    super.init(self)
    self.text = "* ¡Almas de Silla en pena!\n* Huele a tragedia de mobiliario."
    self:addEnemy("silla")
    self:addEnemy("silla")
end

return encounter
