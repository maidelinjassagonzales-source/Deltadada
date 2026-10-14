-- RUTA FURRYGRAVE: no quieren pelear. Solo FurryShock acaba con ellos.
local encounter, super = Class(PCDMEncounter, "sg_angel_alejandro")

function encounter:init()
    super.init(self)
    self.text = "* Ángel y Alejandro te cortan el paso.\n* Lloran."
    self:setMusic("ruta_furrygrave")
    self.background = false
    self:addEnemy("victima_angel")
    self:addEnemy("victima_alejandro")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    Game:setTension(math.max(Game:getTension(), 40))
end

return encounter
