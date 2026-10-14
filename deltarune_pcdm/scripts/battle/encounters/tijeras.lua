local encounter, super = Class(PCDMEncounter, "tijeras")

function encounter:init()
    super.init(self)
    self.text = "* ¡Ris, ras! ¡Dos Tijeritas!"
    self:addEnemy("tijera")
    self:addEnemy("tijera")
end

return encounter
