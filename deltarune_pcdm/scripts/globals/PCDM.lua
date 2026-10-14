-- Librería común de DELTARUNE PCDM.
-- Todo lo que comparten los mapas, cutscenes y combates vive aquí.
local PCDM = {}

---------------------------------------------------------------------------
-- BANDOS
---------------------------------------------------------------------------
-- Jefes del bando malo que cuentan para el FINAL VERDADERO (hay que matarlos a todos).
-- Las hormigas solo salen si matas a Pablo Motos, y Netanyahu solo si matas a Trump.
PCDM.BAD_BOSSES = { "pablo", "angelpedro", "vito", "motos", "hormigas", "abascal", "trump", "netanyahu", "dayron" }
PCDM.GOOD = { "yerover", "angel", "alejandro", "isra", "carmen", "david", "julio", "xibin", "gabriel" }

PCDM.NAMES = {
    pablo = "Pablo", angelpedro = "Angel Pedro", vito = "Vito Quiles", motos = "Pablo Motos",
    hormigas = "las Hormigas", abascal = "Abascal", trump = "Trump", netanyahu = "Netanyahu", dayron = "Dayron",
    yerover = "Yerover", angel = "Ángel", alejandro = "Alejandro", isra = "Isra", carmen = "Carmen",
    david = "David", julio = "Julio", xibin = "Xibin", gabriel = "Gabriel", lucia = "Lucía",
}

---------------------------------------------------------------------------
-- FLAGS
---------------------------------------------------------------------------
function PCDM.flag(name, default)
    return Game:getFlag("pcdm_" .. name, default)
end

function PCDM.setFlag(name, value)
    if value == nil then value = true end
    Game:setFlag("pcdm_" .. name, value)
end

function PCDM.addFlag(name, amount)
    return Game:addFlag("pcdm_" .. name, amount or 1)
end

function PCDM.isKilled(id) return PCDM.flag("killed_" .. id, false) end
function PCDM.isSpared(id) return PCDM.flag("spared_" .. id, false) end
function PCDM.isDone(id) return PCDM.isKilled(id) or PCDM.isSpared(id) end

function PCDM.kill(id)
    if PCDM.isKilled(id) then return end
    PCDM.setFlag("killed_" .. id, true)
    PCDM.setFlag("spared_" .. id, false)
    PCDM.addFlag("kills", 1)
end

function PCDM.spare(id)
    if PCDM.isKilled(id) then return end
    PCDM.setFlag("spared_" .. id, true)
    PCDM.addFlag("spares", 1)
end

function PCDM.killCount()
    local n = 0
    for _, id in ipairs(PCDM.BAD_BOSSES) do
        if PCDM.isKilled(id) then n = n + 1 end
    end
    return n
end

--- ¿Has matado a TODO el bando malo? (condición del final verdadero)
function PCDM.killedAllBad()
    for _, id in ipairs(PCDM.BAD_BOSSES) do
        if not PCDM.isKilled(id) then return false end
    end
    return true
end

function PCDM.route()
    if PCDM.flag("ruta_furrygrave") then return "furrygrave" end
    if PCDM.killedAllBad() then return "verdadero" end
    return "neutral"
end

---------------------------------------------------------------------------
-- RECOMPENSAS POR MATAR AL BANDO MALO (consecuencias positivas)
---------------------------------------------------------------------------
PCDM.KILL_REWARDS = {
    pablo = "alma_incel", angelpedro = "alma_silla", vito = "micro_vito", motos = "alma_hormiguero",
    hormigas = "antenas", abascal = "alma_caballo", trump = "pelo_trump", netanyahu = "alma_bibi",
    dayron = "alma_dayron",
}

--- Sube el LV de todo el equipo (como el LOVE de Undertale, pero aquí es BUENO).
function PCDM.levelUp(amount)
    amount = amount or 1
    for _, chara in pairs(Game.party_data) do
        chara:increaseStat("health", 8 * amount)
        chara:increaseStat("attack", 1 * amount)
        chara:increaseStat("magic", 1 * amount)
        chara.health = chara:getStat("health")
        chara.level = (chara.level or 1) + amount
    end
    PCDM.addFlag("lv", amount)
end

--- Texto de recompensa tras matar a un jefe malo. Devuelve la lista de líneas.
function PCDM.killRewardText(id)
    local lines = {}
    PCDM.levelUp(1)
    table.insert(lines, "* Tu LV ha aumentado.[wait:5]\n* Todo el equipo se siente MÁS FUERTE.")
    local item = PCDM.KILL_REWARDS[id]
    if item and Game.inventory and Game.inventory.addItem then
        local ok = Game.inventory:addItem(item)
        if ok then
            local data = Registry.getItem(item)
            local nm = data and data().name or item
            table.insert(lines, "* Has conseguido [color:yellow]" .. nm .. "[color:reset].")
        end
    end
    return lines
end

---------------------------------------------------------------------------
-- MÚSICA POR CARPETAS
--   assets/music/<seccion>/<loquesea>.(ogg|mp3|wav)
--   Cada parte del juego busca su carpeta. Si está vacía, usa la alternativa.
---------------------------------------------------------------------------
PCDM.MUSIC_FALLBACK = {
    -- sección              = { alternativas... (se prueban en orden) }
    aroy                    = { "AUDIO_DRONE" },
    intro                   = { "AUDIO_DRONE" },
    casa_pablo              = { "AUDIO_DARKNESS" },
    casa_lucia              = { "mod_menu" },
    calle                   = { "mod_menu" },
    instituto               = { "mod_menu" },
    aula                    = { "mod_menu" },
    patio                   = { "mod_menu" },
    casa_andres             = { "AUDIO_DARKNESS" },
    fiestas_pino            = { "mod_menu" },
    combate_light           = { "battle" },
    caida                   = { "AUDIO_DRONE" },
    llanuras                = { "AUDIO_DARKNESS" },
    bosque                  = { "AUDIO_DARKNESS" },
    plato                   = { "AUDIO_DARKNESS" },
    cortijo                 = { "AUDIO_DARKNESS" },
    muro                    = { "AUDIO_DARKNESS" },
    torre_aroy              = { "AUDIO_DRONE" },
    combate                 = { "battle" },
    jefe                    = { "battle" },
    jefe_motos              = { "battle" },
    jefe_gabriel            = { "battle" },
    jefe_dayron             = { "battle" },
    jefe_aroy               = { "battle" },
    jefe_andres             = { "battle" },
    jefe_vito               = { "jefe", "battle" },
    jefe_angelpedro         = { "jefe", "battle" },
    jefe_abascal            = { "jefe", "battle" },
    jefe_pablo              = { "jefe", "battle" },
    jefe_trump              = { "jefe", "battle" },
    jefe_netanyahu          = { "jefe", "battle" },
    papa_francisco          = { "determination" },
    tienda                  = { "mod_menu" },
    final_neutral           = { "AUDIO_DARKNESS" },
    final_verdadero         = { "determination" },
    final_furrygrave        = { "AUDIO_DRONE" },
    ruta_furrygrave         = { "AUDIO_DRONE" },
    momento_incomodo        = { "none" },
}

-- Orden de preferencia para cada sección:
--  1) canciones tuyas en assets/music/<sección>/ (las de Drive)
--  2) la canción de DELTARUNE/UNDERTALE que toca en ese momento, si tienes los juegos
--  3) la música original del mod (pcdm_<sección>.ogg)
--  4) la música que trae Kristal
function PCDM.findMusic(section)
    if not section then return nil end
    local prefix = section .. "/"
    local own, generated
    for id, _ in pairs(Assets.data.music or {}) do
        if id:sub(1, #prefix) == prefix then
            if id:sub(#prefix + 1, #prefix + 5) == "pcdm_" then
                generated = generated or id
            elseif not own or id < own then
                own = id
            end
        end
    end
    if own then return own end
    if MusicaJuegos and MusicaJuegos.music then
        local game = MusicaJuegos.music(section)
        if game then return game end
    end
    if generated then return generated end
    if Assets.getMusicPath(section) then return section end
    for _, fb in ipairs(PCDM.MUSIC_FALLBACK[section] or {}) do
        if fb == "none" then return nil end
        local f = PCDM.findMusic(fb ~= section and fb or nil)
        if f then return f end
    end
    return nil
end

--- Devuelve el id de música para una sección (para usar en encounter.music)
function PCDM.musicId(section)
    return PCDM.findMusic(section)
end

--- Reproduce la música de una sección en el mundo.
function PCDM.playMusic(section, volume, pitch)
    if not Game.world or not Game.world.music then return end
    if section == "jefe_motos" then
        return PCDM.playReversedSlowed(Game.world.music, section)
    end
    local id = PCDM.findMusic(section)
    if id then
        Game.world.music:play(id, volume or 1, pitch or 1)
    else
        Game.world.music:stop()
    end
end

PCDM._reversed_cache = {}

--- Música de Pablo Motos: se invierte y se ralentiza (slowed) en tiempo real
--- a partir del mp3 que pongas en assets/music/jefe_motos/.
function PCDM.makeReversedSlowedSource(section)
    local id = PCDM.findMusic(section)
    if not id then return nil end
    if PCDM._reversed_cache[id] then return PCDM._reversed_cache[id]:clone() end
    local path = Assets.getMusicPath(id)
    local ok, src = pcall(function()
        local sd = love.sound.newSoundData(path)
        -- si el archivo ya viene invertido (nombre con "revert"), no lo tocamos
        if not id:lower():find("revert") then
            local ffi = require("ffi")
            local ch = sd:getChannelCount()
            local n = sd:getSampleCount()
            local bits = sd:getBitDepth()
            local ptr = ffi.cast(bits == 16 and "int16_t*" or "uint8_t*", sd:getFFIPointer())
            local i, j = 0, n - 1
            while i < j do
                for c = 0, ch - 1 do
                    local a, b = i * ch + c, j * ch + c
                    ptr[a], ptr[b] = ptr[b], ptr[a]
                end
                i, j = i + 1, j - 1
            end
        end
        return love.audio.newSource(sd)
    end)
    if not ok or not src then
        Logging.warn("No se pudo invertir la música: " .. tostring(src))
        return nil
    end
    PCDM._reversed_cache[id] = src
    return src:clone()
end

--- Mete una Source como si fuera la música actual del objeto Music de Kristal.
function PCDM.playSourceAsMusic(music, source, name, pitch, volume)
    if not music or not source then return false end
    if music.source then music.source:stop() end
    music.current = name
    music.volume = volume or 1
    music.pitch = pitch or 1
    music.source = source
    source:setLooping(true)
    source:setVolume(music:getVolume())
    source:setPitch(music:getPitch())
    source:play()
    music.started = true
    return true
end

function PCDM.playReversedSlowed(music, section)
    local src = PCDM.makeReversedSlowedSource(section or "jefe_motos")
    if src then
        return PCDM.playSourceAsMusic(music, src, "pcdm_reversed_" .. (section or "jefe_motos"), 0.82, 1)
    end
    local fb = PCDM.findMusic("jefe") or "battle"
    music:play(fb, 1, 0.82)
    return false
end

---------------------------------------------------------------------------
-- TEXTO
---------------------------------------------------------------------------
--- Pensamiento entre paréntesis (deja intuir de qué bando es cada uno)
function PCDM.thought(text)
    return "[color:9aa0c8](" .. text .. ")[color:reset]"
end

--- Diálogo de Aroy.exe: rojo, temblando, con su música de fondo.
--- cutscene: WorldCutscene o BattleCutscene. lines: string o lista. face: expresión.
function PCDM.aroy(cutscene, lines, face, options)
    options = options or {}
    if type(lines) == "string" then lines = { lines } end
    local music = Game:getActiveMusic()
    local prev, prev_pos, prev_vol
    if music and not options.keep_music then
        prev = music.current
        prev_pos = music.source and music.source:tell() or 0
        prev_vol = music.volume
        local id = PCDM.findMusic("aroy")
        if id then music:play(id, 1) else music:stop() end
    end
    local glitch = PCDMGlitch(options.glitch_time or 0.6)
    Game.stage:addChild(glitch)
    Assets.playSound("pcdm_glitch", 0.7)
    for _, line in ipairs(lines) do
        local txt = "[color:ff3a3a][shake:1]" .. line
        cutscene:text(txt, face or "neutral", "aroy", { top = options.top })
    end
    if music and not options.keep_music then
        if prev and prev ~= music.current then
            if prev:sub(1, 14) == "pcdm_reversed_" then
                PCDM.playReversedSlowed(music, prev:sub(15))
            else
                music:play(prev, prev_vol)
                if music.source and prev_pos then pcall(function() music.source:seek(prev_pos) end) end
            end
        elseif not prev then
            music:stop()
        end
    end
end

--- "GOOD BOY": Aroy felicita al jugador cuando hace lo que él quiere.
function PCDM.goodBoy(cutscene, extra)
    local gb = PCDMGoodBoy()
    Game.stage:addChild(gb)
    Assets.playSound("pcdm_uwu", 0.6)
    PCDM.aroy(cutscene, { extra or "Así me gusta.[wait:10] GOOD BOY.", }, "grin", { keep_music = true })
    PCDM.addFlag("good_boys", 1)
end

--- Pantalla de título de cambio de punto de vista.
function PCDM.povCard(cutscene, title, subtitle, time)
    local card = PCDMTitleCard(title, subtitle, time or 2.2)
    Game.stage:addChild(card)
    cutscene:wait(function() return card.done end)
end

--- Cambia el grupo jugable (solo personajes del bando bueno... salvo excepciones de guion)
function PCDM.setParty(ids)
    local list = {}
    for _, id in ipairs(ids) do
        local c = Game:getPartyMember(id)
        if c then table.insert(list, c) end
    end
    Game.party = list
end

--- Cambio de POV completo: tarjeta + equipo + mapa
function PCDM.switchPOV(cutscene, ids, map, marker, title, subtitle, facing)
    cutscene:wait(cutscene:fadeOut(0.5))
    if title then
        PCDM.povCard(cutscene, title, subtitle)
    end
    PCDM.setParty(ids)
    Game.temp_followers = {}
    cutscene:loadMap(map, marker or "spawn", facing or "down")
    cutscene:wait(cutscene:fadeIn(0.5))
end

--- Recarga el mapa actual en el mismo sitio (para que aparezcan/desaparezcan cosas)
--- y coloca a los compañeros en fila detrás del líder, a la vista.
function PCDM.reloadMap(c, facing)
    local p = Game.world.player
    local f = facing or p.facing
    c:loadMap(Game.world.map.id, p.x, p.y, f)
    c:alignFollowers(f)
    c:attachFollowersImmediate()
end

--- Hace que los seguidores del mapa coincidan con Game.party sin recargar el mapa:
--- quien sale del equipo se queda quieto en su sitio, quien entra aparece donde está
--- su "doble" (stand_ins[id], p. ej. un NPC) y todos vuelven andando detrás del líder.
function PCDM.syncFollowers(c, stand_ins)
    local world = Game.world
    local leaving = false
    local want = {}
    for i = 2, #Game.party do want[Game.party[i].id] = i end
    for i = #world.followers, 1, -1 do
        local f = world.followers[i]
        local id = f.party or (f.actor and f.actor.id)
        if not want[id] then
            -- sale del equipo: se va andando (hacia abajo) en vez de desaparecer de golpe
            world:removeFollower(f)
            local npc = c:spawnNPC(f.actor.id, f.x, f.y, { facing = "down" })
            f:remove()
            Boss.leave(c, npc, 0, 220, 1.2, false)
            leaving = true
        end
    end
    for i = 2, #Game.party do
        local id = Game.party[i].id
        local found = false
        for _, f in ipairs(world.followers) do
            if (f.party or f.actor.id) == id then found = true end
        end
        if not found then
            local src = stand_ins and stand_ins[id]
            local fx, fy = world.player.x, world.player.y + 30
            if src and src.parent then fx, fy = src.x, src.y end
            world:spawnFollower(Game.party[i]:getActor(), { party = id, x = fx, y = fy })
            if src and src.parent and not src:includes(Follower) then src:remove() end
        end
    end
    table.sort(world.followers, function(a, b)
        return (want[a.party or a.actor.id] or 99) < (want[b.party or b.actor.id] or 99)
    end)
    for _, f in ipairs(world.followers) do f:updateIndex() end
    c:wait(c:attachFollowers())
    if leaving then c:wait(0.8) end
end

--- Pantalla negra con texto (narración entre escenas)
function PCDM.card(cutscene, title, subtitle, time)
    cutscene:wait(cutscene:fadeOut(0.4))
    PCDM.povCard(cutscene, title, subtitle, time)
end

---------------------------------------------------------------------------
-- PAUSA DE COMBATE PARA LEER DIÁLOGOS
-- Si alguien habla en mitad de un ataque, todo se congela hasta que se lee.
---------------------------------------------------------------------------
PCDM.battle_paused = false

function PCDM.pauseBattle(paused)
    PCDM.battle_paused = paused
    if not Game.battle then return end
    for _, wave in ipairs(Game.battle.waves or {}) do
        wave.active = not paused
    end
    for _, child in ipairs(Game.battle.children) do
        if child:includes(Bullet) then
            child.active = not paused
        end
    end
    if Game.battle.soul then
        Game.battle.soul.active = not paused
    end
end

--- Interrupción a mitad de oleada: pausa, muestra el texto y continúa.
--- Se usa desde una Wave: PCDM.interject(self, {"línea", ...}, "aroy", "angry")
function PCDM.interject(wave, lines, actor, face)
    if type(lines) == "string" then lines = { lines } end
    PCDM.pauseBattle(true)
    local box = PCDMInterjection(lines, actor, face, function()
        PCDM.pauseBattle(false)
    end)
    Game.battle:addChild(box)
    return box
end

---------------------------------------------------------------------------
-- EQUIPO
---------------------------------------------------------------------------
--- Rellena un PartyMember a partir de una tabla (todos tienen ACTUAR y MAGIA).
function PCDM.setupParty(self, t)
    self.name = t.name
    self:setActor(t.id)
    self:setLightActor(t.id .. "_lw")
    self.level = 1
    self.title = t.title or "Héroe"
    self.soul_priority = t.soul_priority or 1
    self.soul_color = t.soul_color or { 1, 0, 0 }
    self.has_act = true
    self.has_spells = true
    self.has_xact = false
    for _, sp in ipairs(t.spells or {}) do
        self:addSpell(sp)
    end
    self.health = t.hp
    self.stats = { health = t.hp, attack = t.atk, defense = t.def, magic = t.mag }
    self.max_stats = { health = t.hp + 300 }
    self.lw_health = t.lw_hp or 20
    self.lw_stats = { health = t.lw_hp or 20, attack = 10, defense = 10 }
    self.weapon_icon = "ui/menu/equip/sword"
    self.color = t.color
    self.dmg_color = t.dmg_color
    self.attack_bar_color = t.color
    self.menu_icon = "party/" .. t.id .. "/head"
    self.head_icons = "party/" .. t.id .. "/icon"
    self.name_sprite = "party/" .. t.id .. "/name"
    self.attack_sprite = t.attack_sprite or "effects/attack/cut"
    self.attack_sound = t.attack_sound or "laz_c"
    self.attack_pitch = t.attack_pitch or 1
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"
    self.gameover_message = t.gameover
    self.flags = {}
end

--- Cambiar a un miembro del equipo por otro (en la reunión del Muro).
function PCDM.swapMember(c, new_id)
    if PCDM.hasMember(new_id) then
        c:text("* Ya está en el equipo.")
        return false
    end
    local names = {}
    for i, chara in ipairs(Game.party) do
        if i > 1 then table.insert(names, chara:getName()) end
    end
    table.insert(names, "Cancelar")
    c:text("* ¿A quién sustituye " .. PCDM.NAMES[new_id] .. "?[wait:5]\n* (Lucía siempre va en el equipo.)")
    local ch = c:choicer(names)
    if ch >= #names then return false end
    local ids = {}
    for _, chara in ipairs(Game.party) do table.insert(ids, chara.id) end
    ids[ch + 1] = new_id
    PCDM.setParty(ids)
    Assets.playSound("equip")
    c:text("* ¡" .. PCDM.NAMES[new_id] .. " se ha unido al equipo!")
    return true
end

---------------------------------------------------------------------------
-- TIENDAS (sencillas, con elecciones)
---------------------------------------------------------------------------
--- items: { {id, precio}, ... }. who/face: retrato del tendero.
function PCDM.shop(c, items, who, face, bye)
    local cur = Game:getConfig("darkCurrencyShort") or "E$"
    while true do
        local names = {}
        for i = 1, math.min(3, #items) do
            local data = Registry.getItem(items[i][1])
            local nm = data and data().name or items[i][1]
            table.insert(names, nm .. " " .. items[i][2])
        end
        table.insert(names, "Salir")
        c:text("* Tienes " .. (Game.money or 0) .. " " .. cur .. ".[wait:5] ¿Qué te pongo?", face or "neutral", who)
        local ch = c:choicer(names)
        if ch > #names - 1 then break end
        local it = items[ch]
        if (Game.money or 0) < it[2] then
            c:text("* No te llega, cariño.", face or "neutral", who)
        elseif not Game.inventory:addItem(it[1]) then
            c:text("* No te cabe nada más.", face or "neutral", who)
        else
            Game.money = Game.money - it[2]
            Assets.playSound("locker")
            c:text("* ¡Gracias por tu compra!", "happy", who)
        end
        if #items > 3 then
            -- rota la lista para enseñar los demás productos
            table.insert(items, table.remove(items, 1))
        end
    end
    if bye then c:text(bye, face or "neutral", who) end
end

---------------------------------------------------------------------------
-- PAGINADOR DE TEXTO: reparte textos largos en varias cajas de 3 líneas
---------------------------------------------------------------------------
local function ulen(s)
    local n = 0
    for _ in s:gmatch("[^\128-\191]") do n = n + 1 end
    return n
end

--- Divide un texto en tokens: comandos [..] (ancho 0), palabras y saltos de línea.
local function tokenize(line)
    local tokens = {}
    local i = 1
    local len = #line
    local word = ""
    local function flush()
        if word ~= "" then table.insert(tokens, { t = "w", v = word }); word = "" end
    end
    while i <= len do
        local ch = line:sub(i, i)
        if ch == "[" then
            local j = line:find("]", i, true)
            if j then
                flush()
                table.insert(tokens, { t = "c", v = line:sub(i, j) })
                i = j + 1
            else
                word = word .. ch
                i = i + 1
            end
        elseif ch == " " then
            flush()
            table.insert(tokens, { t = "s" })
            i = i + 1
        else
            word = word .. ch
            i = i + 1
        end
    end
    flush()
    return tokens
end

--- ¿Empieza el texto (sin contar comandos [..]) por "* "?
local function startsStar(s)
    -- el motor solo mira las letras que se escriben: los comandos [..] no cuentan
    local v = s:gsub("%[[^%]]*%]", ""):gsub("^%s+", "")
    return v:sub(1, 2) == "* "
end

-- Parte un texto en líneas imitando al motor de Kristal:
--  * si el texto empieza por "* ", TODAS las líneas siguientes que no empiecen por "*"
--    salen sangradas 2 caracteres automáticamente (así que solo caben width - 2);
--  * los espacios de sangría escritos a mano se quitan (si no, se sangra dos veces).
-- Devuelve una lista de { text, cont } (cont = línea que continúa un párrafo "* ").
local function wrapModel(text, width)
    local lines = {}
    local in_star = false
    for hard in (text .. "\n"):gmatch("(.-)\n") do
        local stripped = hard:gsub("^%s+", "")
        local star = startsStar(stripped)
        local cont = (not star) and in_star
        if star then in_star = true end
        local cur, cur_len = "", 0
        local limit = cont and width - 2 or width
        local pending_space = false
        for _, tk in ipairs(tokenize(stripped)) do
            if tk.t == "c" then
                cur = cur .. tk.v
            elseif tk.t == "s" then
                pending_space = true
            else
                local wl = ulen(tk.v)
                local add = (pending_space and cur_len > 0) and 1 or 0
                if cur_len > 0 and cur_len + add + wl > limit then
                    table.insert(lines, { text = cur, cont = cont })
                    -- lo que sigue en esta línea ya es continuación
                    cont = in_star
                    limit = cont and width - 2 or width
                    cur, cur_len = tk.v, wl
                else
                    cur = cur .. (add == 1 and " " or "") .. tk.v
                    cur_len = cur_len + add + wl
                end
                pending_space = false
            end
        end
        table.insert(lines, { text = cur, cont = cont })
    end
    return lines
end

-- Junta líneas en una caja. Si la caja empieza por "* ", el motor sangra solo;
-- si empieza a mitad de párrafo, la sangría se pone a mano.
local function renderPage(lines, from, to, style)
    local auto = startsStar(lines[from].text)
    local out = {}
    for k = from, to do
        local l = lines[k]
        table.insert(out, (l.cont and not auto) and ("  " .. l.text) or l.text)
    end
    return style .. table.concat(out, "\n")
end

--- Reparte un texto en cajas de max_lines líneas. Siempre devuelve una lista de páginas.
function PCDM.paginate(text, width, max_lines)
    width = width or 26
    max_lines = max_lines or 3
    local lines = wrapModel(text, width)
    if #lines > max_lines then
        -- No cabe: los saltos manuales dentro de un párrafo pasan a ser espacios
        local paras = {}
        for seg in (text .. "\n"):gmatch("(.-)\n") do
            local stripped = seg:gsub("^%s+", "")
            if #paras == 0 or startsStar(stripped) then
                table.insert(paras, stripped)
            else
                paras[#paras] = paras[#paras] .. " " .. stripped
            end
        end
        lines = wrapModel(table.concat(paras, "\n"), width)
    end
    local pages = {}
    local style = ""
    for i = 1, #lines, max_lines do
        local page = renderPage(lines, i, math.min(#lines, i + max_lines - 1), i > 1 and style or "")
        table.insert(pages, page)
        -- el color/temblor activo pasa a la caja siguiente
        local last_color, last_shake
        for c in page:gmatch("%[color:[^%]]*%]") do last_color = c end
        for c in page:gmatch("%[shake:[^%]]*%]") do last_shake = c end
        if last_color then style = (last_color == "[color:reset]") and "" or last_color end
        if last_shake then style = style .. last_shake end
    end
    return pages
end

-- Caracteres que caben por línea (fuente main_mono: 16 px por letra)
--   diálogo: 427 px con retrato (26) / 543 px sin retrato (33)
--   combate: 494 px con retrato (30) / 610 px sin retrato (38); se deja algo de margen
-- Mensajes que Kristal escribe en inglés -> castellano (patrones de Lua, en orden)
PCDM.TRADUCCIONES = {
    { "^%* You won!\n%* Got (%d+) EXP and (%d+) ([^\n]-)%.$", "* ¡Has ganado!\n* Obtienes %1 EXP y %2 %3." },
    { "^%* You won!\n%* Got (%d+) ([^\n]-)%.\n%* ([^\n]-) became stronger%.$", "* ¡Has ganado!\n* Obtienes %1 %2.\n* %3 se ha hecho más fuerte." },
    { "^%* You won!", "* ¡Has ganado!" },
    { "%* Your SOUL shined its power on\n(.-)!", "* ¡Tu ALMA brilló con fuerza\nsobre %1!" },
    { "^%* (.-) spared (.-)!\n%* But its name wasn't %[color:yellow%]YELLOW%[color:reset%]%.%.%.",
        "* %1 perdonó a %2.\n* ...Pero su nombre no estaba en [color:yellow]AMARILLO[color:reset]..." },
    { "^%* (.-) spared (.-)!$", "* ¡%1 perdonó a %2!" },
    { "%* %(Try using (.-)'s %[color:blue%](.-)%[color:reset%]!%)", "* (¡Prueba [color:blue]%2[color:reset] de %1!)" },
    { "%* %(Try using %[color:blue%]ACTs%[color:reset%]!%)", "* (¡Prueba a [color:blue]ACTUAR[color:reset]!)" },
    { "^%* (.-) used the (.-)!$", "* ¡%1 usó: %2!" },
    { "^%* (.-) cast (.-)!$", "* ¡%1 usó %2!" },
    { "%* %(The chest is empty%.%)", "* (El cofre está vacío.)" },
    { "%* %(You opened the treasure\nchest%.%)", "* (Abres el cofre.)" },
    { "%* %(Inside was (.-)%.%)", "* (Dentro había %1.)" },
    { "%* %((.-) was added to your (.-)%.%)", "* (%1 se guarda en tus %2.)" },
    { "%* %(You have too many (.-) to take (.-)%.%)", "* (Llevas demasiados %1 para coger %2.)" },
    { "%* Your HP was maxed out%.", "* Tus PV están al máximo." },
    { "%* You recovered (%d+) HP!", "* Recuperas %1 PV." },
    { "^%* You equipped the (.-)%.$", "* Te equipas: %1." },
    { "^%* You bid a quiet farewell to the (.-)%.$", "* Te despides en silencio de: %1." },
    { "^%* You put the (.-) on the ground and gave it a little pat%.$", "* Dejas %1 en el suelo y le das una palmadita." },
    { "^%* You threw the (.-) on the ground like the piece of trash it is%.$", "* Tiras %1 al suelo como la basura que es." },
    { "^%* You abandoned the (.-)%.$", "* Abandonas: %1." },
    { "^%* The (.-) was thrown away%.$", "* Has tirado: %1." },
    { "%* %(You felt tense%.%)", "* (Sientes tensión.)" },
    { "%* %(%.%.%. try using it in battle%.%)", "* (...pruébalo en combate.)" },
    { "^%* A skirmish breaks out!$", "* ¡Empieza la pelea!" },
    { "%[color:yellow%]KEY ITEMs%[color:reset%]", "[color:yellow]OBJETOS CLAVE[color:reset]" },
    { "%[color:yellow%]LIGHT ITEMs%[color:reset%]", "[color:yellow]OBJETOS[color:reset]" },
    { "%[color:yellow%]ITEMs%[color:reset%]", "[color:yellow]OBJETOS[color:reset]" },
    { "%[color:yellow%]WEAPONs%[color:reset%]", "[color:yellow]ARMAS[color:reset]" },
    { "%[color:yellow%]ARMORs%[color:reset%]", "[color:yellow]PROTECCIONES[color:reset]" },
}

--- Traduce los mensajes en inglés del motor (texto o lista de textos).
function PCDM.translate(text)
    if type(text) == "table" then
        local out = {}
        for i, t in ipairs(text) do out[i] = PCDM.translate(t) end
        return out
    end
    if type(text) ~= "string" or not text:find("[A-Za-z]") then return text end
    for _, tr in ipairs(PCDM.TRADUCCIONES) do
        text = text:gsub(tr[1], tr[2])
    end
    return text
end

local function fitText(text, has_face, battle)
    text = PCDM.translate(text)
    if type(text) ~= "string" then return text end
    local width = has_face and 26 or 33
    if battle then width = has_face and 29 or 36 end
    local pages = PCDM.paginate(text, width, 3)
    return #pages == 1 and pages[1] or pages
end
PCDM.fitText = fitText

--- Lista de páginas para un texto o una lista de textos (siempre devuelve tabla).
function PCDM.pages(text, width, max_lines)
    local out = {}
    for _, t in ipairs(type(text) == "table" and text or { text }) do
        local p = type(t) == "string" and PCDM.paginate(t, width, max_lines or 3)
        for _, page in ipairs(p or { t }) do table.insert(out, page) end
    end
    return out
end

--- Mete saltos de línea para que un bocadillo no se salga de la pantalla.
function PCDM.wrap(text, width)
    if type(text) ~= "string" then return text end
    local out = {}
    for _, l in ipairs(wrapModel(text, width or 22)) do table.insert(out, l.text) end
    return table.concat(out, "\n")
end

function PCDM.installTextHooks()
    Utils.hook(WorldCutscene, "text", function(orig, self, text, portrait, actor, options)
        local has_face = type(portrait) == "string"
        return orig(self, fitText(text, has_face, false), portrait, actor, options)
    end)
    Utils.hook(BattleCutscene, "text", function(orig, self, text, portrait, actor, options)
        local has_face = type(portrait) == "string"
        return orig(self, fitText(text, has_face, true), portrait, actor, options)
    end)
    -- textos de ACTUAR / magia / objetos: se pueden avanzar, así que se paginan
    Utils.hook(Battle, "battleText", function(orig, self, text, post_func)
        if type(text) == "string" or type(text) == "table" then
            text = PCDM.pages(PCDM.translate(text), 36, 3)
            if #text == 1 then text = text[1] end
        end
        return orig(self, text, post_func)
    end)
    -- el texto de ambiente del turno no se avanza: si no cabe, se queda la primera caja
    Utils.hook(Battle, "setEncounterText", function(orig, self, options, instant)
        if type(options) == "table" and type(options.text) == "string" then
            options.text = PCDM.paginate(PCDM.translate(options.text), options.portrait and 29 or 36, 3)[1]
        end
        return orig(self, options, instant)
    end)
    -- bocadillos de los enemigos: se ajustan solos de ancho
    Utils.hook(Battler, "spawnSpeechBubble", function(orig, self, text, options)
        if type(text) == "table" then
            local t = {}
            for i, l in ipairs(text) do t[i] = PCDM.wrap(l, 22) end
            text = t
        else
            text = PCDM.wrap(text, 22)
        end
        return orig(self, text, options)
    end)
end

---------------------------------------------------------------------------
-- UTILIDADES
---------------------------------------------------------------------------
function PCDM.hasMember(id)
    for _, c in ipairs(Game.party) do
        if c.id == id then return true end
    end
    return false
end

function PCDM.leaderId()
    return Game.party[1] and Game.party[1].id or "lucia"
end

local UPPER = { ["á"] = "Á", ["é"] = "É", ["í"] = "Í", ["ó"] = "Ó", ["ú"] = "Ú", ["ñ"] = "Ñ", ["ü"] = "Ü" }
--- Mayúsculas que respetan las tildes
function PCDM.upper(s)
    s = s:upper()
    for k, v in pairs(UPPER) do s = s:gsub(k, v) end
    return s
end

function PCDM.choose(t)
    return t[love.math.random(1, #t)]
end

return PCDM
