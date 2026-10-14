-- Ayudas para las peleas contra jefes del bando malo desde las cutscenes.
local Boss = {}

--- Pelea contra un jefe con nombre. Devuelve "killed", "spared" o "other".
--- Lanza el combate contra un jefe que está en el mapa. Devuelve "killed"/"spared"/"other" y el NPC.
--- Si muere, desaparece (ya se ha hecho polvo en el combate), salvo con keep = true.
--- Si se le perdona, se queda en el mapa: la escena decide si se va (Boss.leave) o se queda.
function Boss.fight(c, encounter, npc_id, bad_id, keep)
    local npc = npc_id and c:getCharacter(npc_id)
    c:startEncounter(encounter, true, npc)
    local killed = bad_id and PCDM.isKilled(bad_id)
    if npc and npc.parent and killed and not keep then npc:remove() end
    if killed then return "killed", npc end
    if bad_id and PCDM.isSpared(bad_id) then return "spared", npc end
    return "other", npc
end

--- Un personaje se va andando y se desvanece (en vez de desaparecer de golpe).
function Boss.leave(c, npc, dx, dy, time, wait)
    if not npc or not npc.parent then return end
    time = time or 1.2
    local dir = math.abs(dx) > math.abs(dy) and (dx > 0 and "right" or "left") or (dy > 0 and "down" or "up")
    c:walkTo(npc, npc.x + dx, npc.y + dy, time, dir)
    Game.world.timer:after(time * 0.5, function()
        Game.world.timer:tween(time * 0.5, npc, { alpha = 0 }, "linear", function()
            if npc.parent then npc:remove() end
        end)
    end)
    if wait ~= false then c:wait(time + 0.05) end
end

--- Un personaje se deshace en polvo en el mapa.
function Boss.dust(c, npc)
    if not npc or not npc.parent then return end
    Assets.playSound("deathnoise")
    npc:flash()
    Game.world.timer:tween(0.8, npc, { alpha = 0 }, "linear", function()
        if npc.parent then npc:remove() end
    end)
    c:wait(0.85)
end

--- Recompensa por matar a un jefe malo (LV, objetos) con texto.
function Boss.reward(c, bad_id)
    Assets.playSound("levelup")
    for _, line in ipairs(PCDM.killRewardText(bad_id)) do
        c:text(line)
    end
end

return Boss
