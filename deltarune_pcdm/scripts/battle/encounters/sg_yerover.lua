-- RUTA FURRYGRAVE: no quieren pelear. Solo FurryShock acaba con ellos.
local encounter, super = Class(PCDMEncounter, "sg_yerover")

function encounter:init()
    super.init(self)
    self.text = "* Yerover no quiere pelear contigo."
    self:setMusic("ruta_furrygrave")
    self.background = false
    self:addEnemy("victima_yerover")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    Game:setTension(math.max(Game:getTension(), 40))
end

return encounter
