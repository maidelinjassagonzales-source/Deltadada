local encounter, super = Class(PCDMEncounter, "garra_abanico")

function encounter:init()
    super.init(self)
    self.text = "* ¡Una Garra Furra y un Abanico\n  Arcoíris te cortan el paso!"
    self:addEnemy("garra")
    self:addEnemy("abanico")
end

return encounter
