local encounter, super = Class(PCDMEncounter, "dibujo_garra")

function encounter:init()
    super.init(self)
    self.text = "* ¡El Dibujo Sospechoso aparece!\n* Lucía se pone rojísima."
    self:addEnemy("dibujo")
    self:addEnemy("garra")
end

return encounter
