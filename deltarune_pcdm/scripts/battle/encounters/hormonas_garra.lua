local encounter, super = Class(PCDMEncounter, "hormonas_garra")

function encounter:init()
    super.init(self)
    self.text = "* ¡Hormonas y garras!\n* Lucía está en su salsa."
    self:addEnemy("pastilla_e")
    self:addEnemy("garra")
    self:addEnemy("pastilla_t")
end

return encounter
