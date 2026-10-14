-- RUTA FURRYGRAVE: no quieren pelear. Solo FurryShock acaba con ellos.
local encounter, super = Class(PCDMEncounter, "sg_carmen_david_xibin")

function encounter:init()
    super.init(self)
    self.text = "* Carmen, David y Xibin.\n* Los últimos."
    self:setMusic("ruta_furrygrave")
    self.background = false
    self:addEnemy("victima_carmen")
    self:addEnemy("victima_david")
    self:addEnemy("victima_xibin")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    Game:setTension(math.max(Game:getTension(), 40))
end

return encounter
