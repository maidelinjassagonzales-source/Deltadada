-- RUTA FURRYGRAVE: Gabriel, el último en pie.
local encounter, super = Class(PCDMEncounter, "sg_gabriel")

function encounter:init()
    super.init(self)
    self.text = "* Gabriel se pone en guardia.[wait:5]\n* (Solo FURRYGRAVE puede con él: necesita\n  el 100% de TP.)"
    self:setMusic("jefe_gabriel")
    self.background = true
    self:addEnemy("gabriel_sg")
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    -- casi lleno: con un turno de DEFENDER o rozando balas ya se puede usar FURRYGRAVE
    Game:setTension(80)
end

return encounter
