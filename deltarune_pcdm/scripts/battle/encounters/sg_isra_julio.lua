-- RUTA FURRYGRAVE: no quieren pelear. Solo FurryShock acaba con ellos.
local encounter, super = Class(PCDMEncounter, "sg_isra_julio")

function encounter:init()
    super.init(self)
    self.text = "* Isra y Julio se interponen."
    self:setMusic("ruta_furrygrave")
    self.background = false
    self:addEnemy("victima_isra")
    self:addEnemy("victima_julio")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    Game:setTension(math.max(Game:getTension(), 40))
end

return encounter
