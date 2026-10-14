-- Pruebas automáticas (solo con PCDM_TEST=<nombre>). No afectan al juego.
local tests = {}

-- Detector de textos que se salen de su caja: mide cada página con el mismo ancho y
-- fuente que la caja real y avisa si ocupa más de 3 líneas.
function tests.detector()
    local seen = {}
    local function check(where, width, pages, max_lines)
        for _, p in ipairs(type(pages) == "table" and pages or { pages }) do
            if type(p) == "string" and not seen[p] then
                seen[p] = true
                local ok, h = pcall(function()
                    local t = DialogueText(p, 0, 0, width, 2000, { font = "main_mono" })
                    return t:getTextHeight()
                end)
                local lines = ok and math.floor((h - 32) / 36 + 1.5) or -1
                if lines > (max_lines or 3) then
                    print(string.format("[PCDMTEST] DESBORDE %s (%d líneas, ancho %d): %s", where, lines, width, (p:gsub("\n", " / "))))
                end
            end
        end
    end
    Utils.hook(Textbox, "setText", function(orig, self, text, callback)
        check(self.battle_box and "batalla" or "caja", self.text.width, text, 3)
        return orig(self, text, callback)
    end)
end

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
        elseif Game.battle then
            -- en combate también X, para salir de menús (magias sin TP suficiente, etc.)
            idle = 0
            t:auto({ "z", "z", "z", "x" }, 0.09)
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
                    -- guardar y viajar en guagua abren menús que el caminante no sabe usar
                    if ev:includes(Savepoint) or ev:includes(GuaguaStop) then is_obj = false end
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

-- Pasa TODOS los textos de los scripts por el paginador y los mide con la fuente real
local function stringsOf(src)
    local out, i, n = {}, 1, #src
    while i <= n do
        local c = src:sub(i, i)
        if c == "-" and src:sub(i, i + 1) == "--" then
            local j = src:find("\n", i, true) or n
            i = j + 1
        elseif c == '"' then
            local j, buf = i + 1, {}
            while j <= n do
                local d = src:sub(j, j)
                if d == "\\" then
                    local e = src:sub(j + 1, j + 1)
                    table.insert(buf, e == "n" and "\n" or e)
                    j = j + 2
                elseif d == '"' then
                    break
                else
                    table.insert(buf, d)
                    j = j + 1
                end
            end
            table.insert(out, table.concat(buf))
            i = j + 1
        else
            i = i + 1
        end
    end
    return out
end

function tests.textos(t)
    t:wait(0.5)
    local W = { world = { [true] = 427, [false] = 543 }, battle = { [true] = 494, [false] = 610 } }
    local total, bad = 0, 0
    for _, probe in ipairs({ "* a", "* a\n* b", "* a\n* b\n* c", "* a\n* b\n* c\n* d", "* a[wait:5]\n* b[wait:5]\n* c" }) do
        local tx = DialogueText(probe, 0, 0, 543, 2000, { font = "main_mono" })
        t:log("calibra", (probe:gsub("\n", "/")), tx:getTextHeight())
    end
    local function files(dir, list)
        for _, f in ipairs(love.filesystem.getDirectoryItems(dir)) do
            local p = dir .. "/" .. f
            if love.filesystem.getInfo(p, "directory") then files(p, list)
            elseif f:sub(-4) == ".lua" then table.insert(list, p) end
        end
        return list
    end
    local base = Mod.info.path .. "/scripts/"
    for _, sub in ipairs({ "world/cutscenes", "battle", "objects", "globals", "data" }) do
        local battle = sub ~= "world/cutscenes"
        for _, path in ipairs(files(base .. sub, {})) do
            for _, s in ipairs(stringsOf(love.filesystem.read(path))) do
                local plain = s:gsub("%[[^%]]*%]", "")
                -- los patrones de búsqueda (con %) no se muestran nunca
                if #plain > 20 and not s:find("%%") and (plain:find("^%* ") or plain:find("^%(") or plain:find("\n")) then
                    total = total + 1
                    for _, face in ipairs({ true, false }) do
                        local kind = battle and "battle" or "world"
                        local pages = PCDM.fitText(s, face, battle)
                        if type(pages) == "string" then pages = { pages } end
                        for _, page in ipairs(pages) do
                            local tx = DialogueText(page, 0, 0, W[kind][face], 2000, { font = "main_mono" })
                            local lines = math.floor((tx:getTextHeight() - 32) / 36 + 1.5)
                            if lines > 3 then
                                bad = bad + 1
                                t:log(string.format("DESBORDE %s %s cara=%s (%d líneas): %s", path:gsub(".*/scripts/", ""), kind, tostring(face), lines, (page:gsub("\n", " / "))))
                            end
                        end
                    end
                end
            end
        end
    end
    t:log("textos revisados:", total, "desbordes:", bad)
    t:finish()
end

function tests.mide(t)
    t:wait(0.3)
    local probes = {
        "* Dayron me ha dicho que",
        "  aquí hay muchas sillas.[wait:5]",
        "  aquí hay muchas sillas.",
        "* Dayron me ha dicho que\n  aquí hay muchas sillas.[wait:5]\n  Y que hay que",
        "* 123456789012345678901234",
        "* 1234567890123456789012345",
        "* 12345678901234567890123456",
        "aaaaaaaaaaaaaaaaaaaaaaaaaa",
        "aaaaaaaaaaaaaaaaaaaaaaaaaaa",
    }
    for _, p in ipairs(probes) do
        local tx = DialogueText(p, 0, 0, 427, 2000, { font = "main_mono" })
        t:log("mide", tx:getTextHeight(), tx:getTextWidth(), (p:gsub("\n", "/")))
    end
    t:finish()
end

-- Usar un objeto desde el menú del Light World (antes crasheaba)
function tests.objeto_lw(t)
    t:wait(0.5)
    Game.world:loadMap("lw/casa_lucia", "spawn", "down")
    t:wait(1)
    local chara = Game.party[1]
    chara:setHealth(5)
    t:log("vida antes:", chara:getHealth(), "objetos:", #Game.inventory:getStorage("items"))
    -- igual que el jugador: C (menú) -> OBJETO -> primer objeto -> USAR
    for _, k in ipairs({ "c", "z", "z", "z" }) do
        t:press(k)
        t:wait(0.6)
    end
    t:shot("usado")
    t:auto({ "z" }, 0.2)
    t:wait(3)
    t:auto(nil)
    t:log("vida despues:", chara:getHealth())
    -- y la llamada directa que hace el motor (lo que crasheaba)
    local it = Game.inventory:getItem(Game.inventory:getStorage("items"), 1)
    if it then
        it:onWorldUse(Game.party)
        t:wait(0.5)
        t:shot("directo")
        t:auto({ "z" }, 0.2)
        t:wait(2)
        t:auto(nil)
    end
    t:log("vida final:", chara:getHealth())
    t:finish()
end

-- Guaguas: bloqueadas al principio y con menú de varias páginas al final
function tests.guagua(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "gabriel", "angel" })
    Game.world:loadMap("dw/llanuras_3", "spawn", "down")
    t:wait(0.8)
    Game.world:startCutscene("npcs.guagua", "llanuras")
    t:wait(1.5)
    t:shot("bloqueada")
    t:auto({ "z" }, 0.25)
    t:waitNoCutscene(15)
    t:auto(nil)
    t:log("activas:", tostring(PCDM.flag("guaguas_activas")))
    for _, id in ipairs({ "llanuras", "bosque", "plato", "cortijo", "muro" }) do PCDM.setFlag("parada_" .. id, true) end
    PCDM.setFlag("guaguas_activas", true)
    PCDM.setFlag("reunion", true)
    Game.world:loadMap("dw/muro_1", "spawn", "down")
    t:wait(0.8)
    Game.world:startCutscene("npcs.guagua", "muro")
    t:press("z") t:wait(1.2) t:press("z") t:wait(1.2)
    t:shot("menu1")
    -- "Más..." es la tercera opción (arriba): flecha arriba y Z
    t:press("up") t:wait(0.3) t:press("z") t:wait(1)
    t:shot("menu2")
    -- elegir la primera de la segunda página
    t:press("left") t:wait(0.3) t:press("z") t:wait(2)
    t:auto({ "z" }, 0.25)
    t:waitNoCutscene(15)
    t:auto(nil)
    t:log("llegada:", Game.world.map.id)
    t:shot("llegada")
    t:finish()
end

-- ¿Suena la música del mapa a la vez que la del combate?
function tests.musica_combate(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    local function sources()
        local n = love.audio.getActiveSourceCount and love.audio.getActiveSourceCount() or -1
        return n
    end
    local casos = {
        { "dw/llanuras_1", "garra_abanico" }, { "dw/bosque_1", "vito" }, { "dw/plato_2", "motos" },
        { "dw/muro_2", "dayron" }, { "dw/cortijo_1", "abascal" }, { "dw/torre_aroy", "andres" },
    }
    for _, cs in ipairs(casos) do
        Game.world:loadMap(cs[1], "spawn", "down")
        for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do e:remove() end
        t:wait(1.5)
        local wm = Game.world.music
        t:log(cs[1], "mapa suena:", tostring(wm.current), tostring(wm:isPlaying()), "fuentes:", sources())
        Game:encounter(cs[2], true)
        t:waitBattle(5)
        t:wait(2.5)
        local bm = Game.battle.music
        t:log("  combate", cs[2], "-> mapa:", tostring(wm.current), "playing=" .. tostring(wm:isPlaying()),
            "| combate:", tostring(bm.current), "playing=" .. tostring(bm:isPlaying()), "| fuentes activas:", sources())
        Game.battle:returnToWorld()
        t:wait(1.5)
        t:log("  vuelta -> mapa:", tostring(wm.current), "playing=" .. tostring(wm:isPlaying()))
    end
    t:finish()
end

-- Un enemigo derrotado no vuelve a salir al volver al mapa
function tests.reaparecer(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    PCDM.setFlag("llanuras_intro", true)
    Game.world:loadMap("dw/llanuras_2", "spawn", "down")
    t:wait(1)
    local chasers = Game.world.stage:getObjects(ChaserEnemy)
    t:log("enemigos al entrar:", #chasers)
    local ch = chasers[1]
    Game:encounter(ch.encounter, true, ch, ch)  -- igual que al tocarlo
    t:waitBattle(5)
    t:wait(2)
    -- ganar: todos los enemigos fuera
    for _, e in ipairs(Game.battle.enemies) do e:defeat("VIOLENCED", true) end
    t:auto({ "z" }, 0.15)
    local ok = t:waitNoBattle(60)
    t:auto(nil)
    t:wait(1)
    local vivos = 0
    for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do if e.parent then vivos = vivos + 1 end end
    t:log("combate terminado:", tostring(ok), "enemigos tras ganar:", vivos)
    Game.world:loadMap("dw/llanuras_1", "spawn", "down")
    t:wait(1)
    Game.world:loadMap("dw/llanuras_2", "spawn", "down")
    t:wait(1)
    local vuelta = 0
    for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do if e.parent then vuelta = vuelta + 1 end end
    t:log("enemigos al volver:", vuelta)
    t:finish()
end

-- Abascal montado a caballo, y el caballo huyendo cuando muere
function tests.abascal(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    Game.world:loadMap("dw/cortijo_1", "spawn", "down")
    for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do e:remove() end
    Game:encounter("abascal", true)
    t:waitBattle(5)
    t:wait(2.5)
    t:shot("montado")
    local e = Game.battle.enemies[1]
    e:hurt(60, Game.battle.party[1])
    t:wait(0.25)
    t:shot("golpe")
    t:wait(1)
    e:hurt(e.health + 50, Game.battle.party[1])
    t:wait(0.5)
    t:shot("muere")
    t:wait(0.6)
    t:shot("caballo_huye")
    t:log("muerto:", tostring(PCDM.isKilled("abascal")))
    t:finish()
end

function tests.abascal_mapa(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "yerover", "angel" })
    Game.world:loadMap("dw/cortijo_1", "spawn", "down")
    for _, e in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do e:remove() end
    local ab = Game.world:getCharacter("abascal_montado")
    Game.world.player:setPosition(ab.x - 200, ab.y)
    t:wait(1)
    t:shot("mapa")
    Game.world:startCutscene("dw_cortijo.abascal")
    t:auto({ "z", "z", "x" }, 0.12)
    t:waitBattle(40)
    t:wait(2)
    t:shot("combate")
    local e = Game.battle and Game.battle.enemies[1]
    if e then e:hurt(e.health + 50, Game.battle.party[1]) end
    t:waitNoBattle(60)
    t:wait(2)
    t:auto(nil)
    t:shot("despues")
    t:log("muerto:", tostring(PCDM.isKilled("abascal")), "npc sigue:", tostring(Game.world:getCharacter("abascal_montado") ~= nil))
    t:finish()
end

-- Se puede bajar de la azotea del Muro y volver de la Torre
function tests.muro_volver(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "gabriel", "angel" })
    for _, f in ipairs({ "reunion", "trump_hecho", "dayron_hecho" }) do PCDM.setFlag(f, true) end
    local function salirPor(destino)
        for _, ev in ipairs(Game.world.map.events) do
            if ev:includes(Transition) and ev.target.map == destino then
                Game.world.player:setPosition(ev.x + ev.width / 2, ev.y + ev.height / 2)
                return true
            end
        end
        return false
    end
    Game.world:loadMap("dw/torre_aroy", "sur", "up")
    t:wait(1)
    t:log("torre -> muro_2 existe:", tostring(salirPor("dw/muro_2")))
    t:wait(2)
    t:log("ahora en:", Game.world.map.id)
    t:shot("azotea")
    t:log("muro_2 -> muro_1 existe:", tostring(salirPor("dw/muro_1")))
    t:wait(2)
    t:log("ahora en:", Game.world.map.id)
    t:shot("muro")
    t:log("muro_1 -> muro_2 existe:", tostring(salirPor("dw/muro_2")))
    t:wait(2)
    t:log("ahora en:", Game.world.map.id)
    t:finish()
end

-- ¿Se ven los compañeros que siguen al líder?
function tests.seguidores(t)
    t:wait(0.5)
    PCDM.setParty({ "lucia", "gabriel", "angel" })
    for _, f in ipairs({ "reunion", "trump_hecho" }) do PCDM.setFlag(f, true) end
    Game.world:loadMap("dw/muro_1", "muro", "up")
    t:wait(1)
    local function info(tag)
        local fs = Game.world.followers or {}
        local parts = {}
        for _, f in ipairs(fs) do
            table.insert(parts, string.format("%s(%d,%d,vis=%s)", f.actor and f.actor.id or "?", f.x, f.y, tostring(f.visible)))
        end
        t:log(tag, "jugador", Game.world.player.actor.id, math.floor(Game.world.player.x), math.floor(Game.world.player.y), "| seguidores:", #fs, table.concat(parts, " "))
    end
    info("al cargar:")
    -- andar hacia abajo un rato (como un jugador)
    love.event.push("keypressed", "down", "down", false)
    t:wait(1.2)
    love.event.push("keyreleased", "down", "down")
    t:wait(0.5)
    info("tras andar:")
    t:shot("andando")
    t:finish()
end

-- Escena Gabriel vs Dayron: el grupo se ve, y en el combate solo suena Dayron.ogg
function tests.dayron_escena(t)
    t:wait(0.5)
    local equipo = os.getenv("PCDM_EQUIPO") == "sin_gabriel" and { "lucia", "isra", "angel" } or { "lucia", "gabriel", "angel" }
    PCDM.setParty(equipo)
    for _, f in ipairs({ "reunion", "trump_hecho" }) do PCDM.setFlag(f, true) end
    Game.world:loadMap("dw/muro_2", "sur", "up")
    t:wait(1)
    -- andar hasta la línea del script, como un jugador
    love.event.push("keypressed", "up", "up", false)
    t:wait(function() return Game.world:hasCutscene() end)
    love.event.push("keyreleased", "up", "up")
    t:wait(2.5)
    t:shot("grupo")
    t:auto({ "z" }, 0.12)
    t:wait(function() return Game.world.cutscene and Game.world.cutscene.textbox and
        tostring(Game.world.cutscene.textbox:getText()):find("paso al frente") end)
    t:wait(1.2)
    t:shot("paso_al_frente")
    t:waitBattle(60)
    t:wait(3)
    local wm, bm = Game.world.music, Game.battle and Game.battle.music
    t:log("combate: mapa suena=" .. tostring(wm:isPlaying()), "música combate=" .. tostring(bm and bm:isPlaying()),
        "Dayron.ogg=" .. tostring(Game.battle and Game.battle.encounter.distorter and Game.battle.encounter.distorter.main and Game.battle.encounter.distorter.main:isPlaying()))
    t:shot("combate")
    t:auto(nil)
    t:finish()
end

-- Escena de jefe completa: PCDM_ESCENA=dayron|pablo|vito|motos|abascal, PCDM_FINAL=matar|perdonar
local ESCENAS = {
    dayron = { map = "dw/muro_2", marker = "sur", cs = "dw_muro.dayron", flags = { "reunion", "trump_hecho" }, party = { "lucia", "gabriel", "angel" } },
    pablo = { map = "dw/cortijo_2", marker = "spawn", cs = "dw_cortijo.pablo", flags = {}, party = { "lucia", "yerover", "angel" } },
    vito = { map = "dw/bosque_1", marker = "spawn", cs = "dw_bosque.vito", flags = {}, party = { "gabriel", "isra", "alejandro" } },
    motos = { map = "dw/plato_2", marker = "spawn", cs = "dw_plato.motos", flags = { "xibin_unido" }, party = { "carmen", "xibin", "julio" } },
    abascal = { map = "dw/cortijo_1", marker = "spawn", cs = "dw_cortijo.abascal", flags = {}, party = { "lucia", "yerover", "angel" } },
}
function tests.escena_jefe(t)
    t:wait(0.5)
    local e = ESCENAS[os.getenv("PCDM_ESCENA") or "dayron"]
    local final = os.getenv("PCDM_FINAL") or "matar"
    if os.getenv("PCDM_EQUIPO") == "sin_gabriel" then e.party = { "lucia", "isra", "angel" } end
    PCDM.setParty(e.party)
    for _, f in ipairs(e.flags) do PCDM.setFlag(f, true) end
    Game.world:loadMap(e.map, e.marker, "up")
    for _, ch in ipairs(Game.world.stage:getObjects(ChaserEnemy)) do ch:remove() end
    t:wait(1)
    Game.world:startCutscene(e.cs)
    t:auto({ "z" }, 0.12)
    t:waitBattle(80)
    t:auto(nil)
    t:wait(2)
    for _, en in ipairs(Game.battle.enemies) do
        if final == "perdonar" then en:spare() else en:hurt(en.health + 99, Game.battle.party[1]) end
    end
    t:auto({ "z" }, 0.15)
    t:waitNoBattle(60)
    t:wait(0.6)
    t:shot("tras_combate")
    t:wait(function() return not Game.world:hasCutscene() end)
    t:auto(nil)
    t:wait(1)
    t:shot("final")
    local fs = {}
    for _, f in ipairs(Game.world.followers) do table.insert(fs, f.actor.id .. "@" .. math.floor(f.x) .. "," .. math.floor(f.y)) end
    t:log("resultado:", final, "| jugador", math.floor(Game.world.player.x) .. "," .. math.floor(Game.world.player.y),
        "| seguidores:", table.concat(fs, " "), "| equipo:", table.concat((function() local r = {} for _, c in ipairs(Game.party) do table.insert(r, c.id) end return r end)(), ","))
    t:finish()
end

-- Comprueba que la música de Drive se encuentra, se invierte y suena
function tests.musica(t)
    t:wait(0.5)
    for _, sec in ipairs({ "aroy", "jefe_gabriel", "jefe_motos", "llanuras" }) do
        t:log("seccion", sec, "->", tostring(PCDM.findMusic(sec)))
    end
    local src = PCDM.makeReversedSlowedSource("jefe_motos")
    t:log("motos invertida:", src and ("ok " .. string.format("%.1f", src:getDuration()) .. "s") or "FALLO")
    PCDM.playMusic("aroy")
    t:wait(0.5)
    local m = Game.world.music
    t:log("aroy suena:", tostring(m.current), m.source and tostring(m.source:isPlaying()) or "sin source")
    PCDM.playReversedSlowed(m, "jefe_motos")
    t:wait(0.5)
    t:log("motos suena:", tostring(m.current), m.source and (tostring(m.source:isPlaying()) .. " pitch " .. m.source:getPitch()) or "sin source")
    local d = DayronDistorter()
    Game.stage:addChild(d)
    t:wait(1)
    t:log("Dayron.ogg:", d.main and ("ok, suena " .. tostring(d.main:isPlaying())) or "FALLO", "fuentes:", #d.sources)
    d:remove()
    Game:encounter("sg_gabriel", true)
    t:waitBattle(5)
    t:wait(1)
    t:log("musica combate gabriel:", tostring(Game.battle and Game.battle.music and Game.battle.music.current))
    t:finish()
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
