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
    papa_francisco          = { "determination" },
    tienda                  = { "mod_menu" },
    final_neutral           = { "AUDIO_DARKNESS" },
    final_verdadero         = { "determination" },
    final_furrygrave        = { "AUDIO_DRONE" },
    ruta_furrygrave         = { "AUDIO_DRONE" },
    momento_incomodo        = { "none" },
}

function PCDM.findMusic(section)
    if not section then return nil end
    local prefix = section .. "/"
    local best
    for id, _ in pairs(Assets.data.music or {}) do
        if id:sub(1, #prefix) == prefix then
            if not best or id < best then best = id end
        end
    end
    if best then return best end
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
function PCDM.switchPOV(cutscene, ids, map, marker, title, subtitle)
    cutscene:fadeOut(0.5)
    if title then
        PCDM.povCard(cutscene, title, subtitle)
    end
    PCDM.setParty(ids)
    Game.temp_followers = {}
    cutscene:loadMap(map, marker or "spawn", "down")
    cutscene:fadeIn(0.5)
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
