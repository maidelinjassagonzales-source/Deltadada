-- Ayudas para las peleas contra jefes del bando malo desde las cutscenes.
local Boss = {}

--- Pelea contra un jefe con nombre. Devuelve "killed", "spared" o "other".
function Boss.fight(c, encounter, npc_id, bad_id)
    local npc = npc_id and c:getCharacter(npc_id)
    c:startEncounter(encounter, true, npc)
    if npc and npc.parent then npc:remove() end
    if bad_id and PCDM.isKilled(bad_id) then return "killed" end
    if bad_id and PCDM.isSpared(bad_id) then return "spared" end
    return "other"
end

--- Recompensa por matar a un jefe malo (LV, objetos) con texto.
function Boss.reward(c, bad_id)
    Assets.playSound("levelup")
    for _, line in ipairs(PCDM.killRewardText(bad_id)) do
        c:text(line)
    end
end

return Boss
