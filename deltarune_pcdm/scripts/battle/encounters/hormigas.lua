-- Trancas y Barrancas vienen a vengar a Pablo Motos.
local encounter, super = Class(PCDMEncounter, "hormigas")

function encounter:init()
    super.init(self)
    self.text = "* ¡Trancas y Barrancas atacan!\n* ¿O era Barrancas y Trancas?"
    self:setMusic("jefe_motos")
    self:addEnemy("trancas")
    self:addEnemy("barrancas")
end

function encounter:onBattleEnd()
    local killed = 0
    for _, e in ipairs(self:getDefeatedEnemies()) do
        if e.done_state == "KILLED" then killed = killed + 1 end
    end
    if killed >= 2 then
        PCDM.kill("hormigas")
    else
        PCDM.spare("hormigas")
    end
end

return encounter
