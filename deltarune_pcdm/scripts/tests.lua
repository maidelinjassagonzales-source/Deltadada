-- Pruebas automáticas (solo con PCDM_TEST=<nombre>). No afectan al juego.
local tests = {}

function tests.humo(t)
    t:wait(1)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    Game.world:loadMap("dw/llanuras_1", "spawn", "down")
    t:wait(1)
    t:shot("mapa")
    Game:encounter("garra_abanico", true)
    t:waitBattle(5)
    t:wait(2.5)
    t:shot("combate")
    t:auto({ "z", "z", "z", "right", "z", "down" }, 0.15)
    t:wait(25)
    t:shot("combate_tras")
    t:auto(nil)
end

function tests.ut(t)
    t:wait(1)
    Game.world:loadMap("lw/casa_lucia", "spawn", "down")
    t:wait(1)
    local cfg = {
        intro = "* Pablo se acerca con el móvil en la mano.",
        enemy = {
            name = "Pablo", sprite = "chars/pablo/light/walk/down_1", scale = 4,
            hp = 40, atk = 3, def = 0, hit_damage = 14,
            check = "* Sigue a 847 cuentas. 846 son bots.",
            flavor = { "* Pablo te enseña su Instagram.", "* Huele a Axe y a desesperación." },
            dialogue = { "hola guapa.\nq tal", "dame tu insta" },
            acts = { { name = "Ignorar", mercy = 40, text = "* Ignoras a Pablo." }, { name = "Bloquear", mercy = 60, text = "* Le bloqueas." } },
            waves = { "palabras", "lluvia" }, bullet_words = { "hola", "q tal", "porfa" }, bullet_sprites = { "billete" },
        },
    }
    Game.world:startCutscene(function(c) UTBattle.run(c, cfg) end)
    t:wait(1.2)
    t:shot("ut_intro")
    t:press("z") t:wait(0.4) t:press("z") t:wait(0.3)
    t:shot("ut_target")
    t:press("z") t:wait(0.6) t:press("z") t:wait(0.5)
    t:shot("ut_fight")
    t:wait(1.5)
    t:shot("ut_talk")
    t:press("z") t:wait(1.5)
    t:shot("ut_dodge")
    t:auto({ "z", "left", "right", "z", "down" }, 0.2)
    t:wait(30)
    t:auto(nil)
    t:shot("ut_end")
end

local MAPAS = {
    "lw/casa_pablo", "lw/casa_lucia", "lw/calle", "lw/pasillo", "lw/aula", "lw/patio", "lw/casa_andres", "lw/pino",
    "dw/llanuras_1", "dw/llanuras_2", "dw/llanuras_3", "dw/bosque_1", "dw/bosque_2", "dw/plato_1", "dw/plato_2",
    "dw/cortijo_1", "dw/cortijo_2", "dw/muro_1", "dw/muro_2", "dw/torre_aroy", "dw/sg_camino", "dw/sg_cumbre", "dw/sg_vacio",
}

function tests.mapas(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    for _, id in ipairs(MAPAS) do
        Game.world:loadMap(id, "spawn", "down")
        Game.world.player.visible = true
        for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do e:remove() end
        t:wait(0.6)
        -- la cámara en el centro del mapa para ver la distribución
        local m = Game.world.map
        Game.world.camera:setAttached(false)
        Game.world.camera.keep_in_bounds = false
        Game.world.camera:setPosition(m.width * m.tile_width / 2, m.height * m.tile_height / 2)
        Game.world.camera:setZoom(math.min(SCREEN_WIDTH / (m.width * 40), SCREEN_HEIGHT / (m.height * 40)))
        t:wait(0.3)
        t:shot(id:gsub("/", "_"))
        Game.world.camera:setZoom(1)
        Game.world.camera:setAttached(true)
        Game.world.camera.keep_in_bounds = true
    end
end

-- Recorre una cutscene pulsando Z sin parar y saca capturas cada cierto tiempo
local function autoplay(t, start, seconds, every, keys)
    if start and not Game.world:hasCutscene() then Game.world:startCutscene(start) end
    t:auto(keys or { "z", "left", "z" }, 0.09)
    local elapsed, last = 0, -999
    local lastmap = nil
    while elapsed < seconds do
        t:wait(0.5)
        elapsed = elapsed + 0.5
        local mapid = Game.world and Game.world.map and Game.world.map.id
        if mapid ~= lastmap then
            t:log("mapa:", mapid)
            lastmap = mapid
        end
        if elapsed - last >= (every or 6) then
            last = elapsed
            t:shot((mapid or "x"):gsub("/", "_"))
        end
    end
    t:auto(nil)
end

function tests.historia_lw(t)
    t:wait(0.5)
    autoplay(t, "intro.aroy", 240, 8)
    t:log("flags:", PCDM.flag("lucia_despierta"), PCDM.flag("aula_hecho"))
end

function tests.aula(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia" })
    Game.world:loadMap("lw/aula", "asiento", "up")
    t:wait(0.5)
    autoplay(t, "lw_aula.pablo", 200, 7)
end

function tests.patio(t)
    t:wait(0.5)
    PCDM.setParty({ "gabriel" })
    Game.world:loadMap("lw/patio", "spawn", "up")
    t:wait(0.5)
    autoplay(t, "lw_patio.dayron", 120, 7)
    PCDM.setFlag("patio_dayron", true)
    autoplay(t, "lw_patio.silla", 150, 7)
end

function tests.andres_pino(t)
    t:wait(0.5)
    PCDM.setParty({ "andres" })
    Game.world:loadMap("lw/casa_andres", "spawn", "up")
    t:wait(0.5)
    for _, cs in ipairs({ "lw_andres.entrar", "lw_andres.pc", "lw_andres.cajon", "lw_andres.movil" }) do
        if not Game.world:hasCutscene() then Game.world:startCutscene(cs) end
        t:auto({ "z", "left", "z" }, 0.09)
        t:waitNoCutscene(60)
        t:auto(nil)
        t:wait(0.3)
    end
    autoplay(t, nil, 40, 8)
    -- en el Pino: bebe 5 chupitos
    for i = 1, 5 do
        if not Game.world:hasCutscene() then Game.world:startCutscene("lw_pino.ron") end
        t:auto({ "z", "left", "z" }, 0.1)
        t:waitNoCutscene(30)
        t:auto(nil)
        t:wait(0.2)
        t:shot("pino_chupito_" .. i)
    end
    autoplay(t, nil, 120, 8)
end

function tests.dark_world(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia" })
    Game.world:loadMap("lw/aula", "armario", "up")
    PCDM.setFlag("dia2", true)
    t:wait(0.5)
    autoplay(t, "lw_aula.armario", 160, 8)
end

-- Partida entera "a ciegas": un caminante va pisando los scripts, usando los objetos
-- y cruzando las transiciones de cada mapa, pulsando Z (y ← en los menús de elegir).
-- PCDM_RUTA=furrygrave también coge el sticker dorado.
local function freeRoam()
    return Game.state == "OVERWORLD" and Game.world.state == "GAMEPLAY" and not Game.world:hasCutscene()
        and not Game.world:isTextboxOpen() and not Game.battle and Game.world.player ~= nil
end

local function center(ev)
    return ev.x + ev.width / 2, ev.y + ev.height / 2 + 4
end

function tests.recorrido(t)
    local ruta = os.getenv("PCDM_RUTA") or "verdadera"
    local limit = tonumber(os.getenv("PCDM_TIEMPO") or "2400")
    t:wait(0.5)
    Game.world:startCutscene("intro.aroy")
    t:auto({ "z", "left", "z" }, 0.09)
    local visits, used = {}, {}
    local last_map, idle, elapsed, last_shot, stuck_logged = nil, 0, 0, -999, nil
    while elapsed < limit do
        t:wait(0.25)
        elapsed = elapsed + 0.25
        -- modo dios: nadie del equipo se muere en las pruebas
        for _, chara in pairs(Game.party_data) do
            chara.stats.health = math.max(chara.stats.health, 900)
            if chara.health < 300 then chara.health = 900 end
        end
        if Game.state == "GAMEOVER" then
            t:log("GAME OVER en", Game.world.map and Game.world.map.id)
            break
        end
        local map = Game.world.map
        if map ~= last_map then
            last_map = map
            used = {}
            if map then
                visits[map.id] = (visits[map.id] or 0) + 1
                t:log("mapa:", map.id, "equipo:", PCDM.leaderId(), "muertos:", PCDM.killCount())
                t:shot(map.id:gsub("/", "_"))
            end
        end
        if Game.battle and elapsed - last_shot > 20 then
            last_shot = elapsed
            t:shot("combate_" .. tostring(Game.battle.encounter and Game.battle.encounter.id))
        end
        if Game.state == "MENU" or (Game.world and Game.world.pcdm_creditos_fin) then
            t:log("de vuelta al menú: partida terminada")
            break
        end
        -- las teclas solo se pulsan en cinemáticas y combates; andando, el caminante
        -- se mueve solo (si no, Z no para de hablar con los muebles)
        if freeRoam() and map then
            idle = idle + 0.25
            t:auto(nil)
        else
            idle = 0
            t:auto({ "z", "left", "z" }, 0.09)
        end
        if idle >= 1 then
            idle = 0
            local player = Game.world.player
            local pick, kind
            -- 1) objetos con los que hablar (el ron del Pino se usa hasta 5 veces)
            for i, ev in ipairs(map.events) do
                if not pick and ev.parent and not ev.removed then
                    local cs = ev.cutscene
                    local times = (cs == "lw_pino.ron") and 5 or 1
                    local is_obj = ev:includes(Interactable) or ev:includes(ArmarioEvent)
                        or (ev:includes(DecoSprite) and cs)
                    if cs == "furrygrave.sticker" and ruta ~= "furrygrave" then is_obj = false end
                    if is_obj and (used[ev] or 0) < times then
                        pick, kind = ev, "interact"
                    end
                end
            end
            -- 2) zonas de script
            if not pick then
                for _, ev in ipairs(map.events) do
                    if not pick and ev.parent and ev:includes(Script) and not used[ev] then
                        pick, kind = ev, "script"
                    end
                end
            end
            -- 3) transiciones: primero a mapas nuevos
            if not pick then
                local best, best_n
                for _, ev in ipairs(map.events) do
                    if ev.parent and ev:includes(Transition) and ev.target.map and not used[ev] then
                        local n = visits[ev.target.map] or 0
                        if not best or n < best_n then best, best_n = ev, n end
                    end
                end
                if best then pick, kind = best, "trans" end
            end
            if pick then
                used[pick] = (used[pick] or 0) + 1
                stuck_logged = nil
                local x, y = center(pick)
                t:log("  ->", kind, pick.cutscene or (pick.target and pick.target.map) or pick.id)
                if kind == "interact" then
                    player:setPosition(x, y + pick.height / 2 + 24)
                    player:setFacing("up")
                    pick:onInteract(player, "up")
                else
                    player:setPosition(x, y)
                    pick:onEnter(player)
                end
            elseif stuck_logged ~= map then
                stuck_logged = map
                t:log("ATASCADO en", map.id, "(no queda nada que pisar)")
                t:shot("atascado_" .. map.id:gsub("/", "_"))
            end
        end
    end
    t:auto(nil)
    local killed = {}
    for _, id in ipairs(PCDM.BAD_BOSSES) do
        table.insert(killed, id .. "=" .. (PCDM.isKilled(id) and "muerto" or (PCDM.isSpared(id) and "perdonado" or "-")))
    end
    t:log("resumen:", table.concat(killed, " "))
    t:log("ruta:", PCDM.route(), "final:", tostring(PCDM.flag("final_visto")))
end

-- Un solo combate para ver cómo queda: PCDM_COMBATE=<encuentro>
function tests.jefe(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    Game.world:loadMap("dw/llanuras_1", "spawn", "down")
    for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do e:remove() end
    Game:encounter(os.getenv("PCDM_COMBATE") or "vito", true)
    t:waitBattle(5)
    t:wait(3)
    t:shot("inicio")
    t:auto({ "z" }, 0.1)
    t:wait(14)
    t:shot("turno")
    t:auto(nil)
    t:finish()
end

-- Todos los combates del Dark World, uno detrás de otro, pulsando Z (siempre LUCHAR)
local COMBATES = { "garra_abanico", "pastillas", "stickers", "ladrillo_carpa", "trio_andres",
    "vito", "angelpedro", "motos", "hormigas", "abascal", "pablo", "trump", "netanyahu", "dayron", "andres",
    "sg_yerover", "sg_malos1", "sg_gabriel", "aroy_omega" }

function tests.combates(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    Game.world:loadMap("dw/llanuras_1", "spawn", "down")
    for _, chara in pairs(Game.party_data) do
        chara.stats.health = 9999
        chara.health = 9999
    end
    local only = os.getenv("PCDM_COMBATE")
    for _, enc in ipairs(COMBATES) do
        if not only or only == enc then
            if enc == "dayron" then PCDM.setParty({ "gabriel" }) end
            if enc:sub(1, 3) == "sg_" or enc == "aroy_omega" then
                PCDM.setFlag("ruta_furrygrave", true)
                PCDM.setParty({ "dayron", "lucia" })
            end
            for _, chara in pairs(Game.party_data) do chara.stats.health = 9999; chara.health = 9999 end
            Game:encounter(enc, true)
            t:waitBattle(5)
            local turns = 0
            local start = love.timer.getTime()
            t:wait(2)
            t:shot(enc)
            t:auto({ "z" }, 0.08)
            local shot2 = false
            local max_turn = 0
            while Game.battle and love.timer.getTime() - start < 150 do
                t:wait(0.5)
                if Game.battle then max_turn = math.max(max_turn, Game.battle.turn_count or 0) end
                if not shot2 and love.timer.getTime() - start > 20 then
                    shot2 = true
                    t:shot(enc .. "_mitad")
                end
            end
            t:auto(nil)
            local secs = math.floor(love.timer.getTime() - start)
            t:log("combate", enc, Game.battle and "SIN TERMINAR" or "terminado", "segundos:", secs,
                "turnos:", max_turn)
            if Game.battle then
                Game.battle:returnToWorld()
                t:wait(2)
            end
            PCDM.setParty({ "lucia", "yerover", "angel" })
            t:wait(1)
        end
    end
end

return tests
