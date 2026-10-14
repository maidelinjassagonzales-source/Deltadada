-- GABRIEL contra DAYRON. De fondo suena Dayron.ogg con efectos que van cambiando.
local encounter, super = Class(PCDMEncounter, "dayron")

function encounter:init()
    super.init(self)
    self.text = "* ¡Gabriel contra Dayron![wait:5]\n* El duelo del siglo."
    self:setMusic("jefe_dayron")
    self:addEnemy("dayron")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    self.distorter = DayronDistorter()
    Game.battle:addChild(self.distorter)
end

function encounter:onBattleEnd()
    if self.distorter then
        self.distorter:remove()
        self.distorter = nil
    end
end

function encounter:onReturnToWorld()
    if self.distorter then self.distorter:remove() end
end

return encounter
