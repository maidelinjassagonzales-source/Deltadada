local encounter, super = Class(PCDMEncounter, "pastillas")

function encounter:init()
    super.init(self)
    self.text = "* ¡Las Hormonas atacan!\n* Bueno, \"atacan\"."
    self:addEnemy("pastilla_e")
    self:addEnemy("pastilla_t")
end

return encounter
