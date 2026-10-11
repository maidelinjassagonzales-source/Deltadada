local encounter, super = Class(PCDMEncounter, "papeleta_escano")

function encounter:init()
    super.init(self)
    self.text = "* ¡Una Papeleta y un Escaño!\n* Se huele un pacto de gobierno."
    self:addEnemy("papeleta")
    self:addEnemy("escano")
end

return encounter
