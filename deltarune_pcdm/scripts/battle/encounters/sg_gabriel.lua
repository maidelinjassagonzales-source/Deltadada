-- RUTA FURRYGRAVE: Gabriel, el último en pie.
local encounter, super = Class(PCDMEncounter, "sg_gabriel")

function encounter:init()
    super.init(self)
    self.text = "* Gabriel se pone en guardia.[wait:5]\n* No va a caer."
    self:setMusic("jefe_gabriel")
    self.background = true
    self:addEnemy("gabriel_sg")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    Game:setTension(50)
end

return encounter
