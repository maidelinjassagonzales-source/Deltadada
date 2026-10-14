-- RUTA FURRYGRAVE: AROY.EXE en su forma final.
local encounter, super = Class(PCDMEncounter, "aroy_omega")

function encounter:init()
    super.init(self)
    self.text = "* AROY.EXE TE MIRA DESDE LA PANTALLA.\n* Las almas del bando malo están atrapadas dentro."
    self:setMusic("jefe_aroy")
    self:addEnemy("omega_aroy", 470, 200)
end

function encounter:onBattleStart()
    super.onBattleStart(self)
    Game:setTension(30)
end

return encounter
