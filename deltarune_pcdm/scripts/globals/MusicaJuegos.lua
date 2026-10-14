-- MÚSICA DE DELTARUNE Y UNDERTALE, sacada de los juegos que tengas instalados.
-- El mod no trae esas canciones: al arrancar busca tus instalaciones (Steam y otras
-- rutas típicas, o las que pongas en rutas_juegos.txt), y cuando una parte del juego
-- necesita música copia esa canción a la carpeta de partidas guardadas y la usa.
-- Si no encuentra los juegos, suena la música original del mod.
local MusicaJuegos = {}

-- Qué canción va en cada momento (en orden de preferencia).
-- "=nombre" = el archivo se tiene que llamar exactamente así; sin "=", vale si lo contiene.
MusicaJuegos.MAPA = {
    intro            = { "=AUDIO_ANOTHERHIM", "mus_st_him", "=AUDIO_DRONE" },                     -- Aroy.exe, como Gaster
    casa_pablo       = { "mus_mysteriousroom", "mus_creepy", "creepychase", "mus_dogshrine" },  -- el cuarto de Pablo da yuyu
    casa_lucia       = { "=mus_home", "=home", "mus_house1" },                                   -- Home
    calle            = { "=town", "=mus_town", "mus_snowy" },                                    -- Hometown
    instituto        = { "=mus_school", "=school", "=town" },
    aula             = { "=mus_school", "=school", "mus_dogsong" },
    patio            = { "mus_snowy", "=town", "=mus_school" },
    casa_andres      = { "creepychase", "=mus_ruins", "basement", "=AUDIO_DARKNESS" },
    fiestas_pino     = { "dogcheck", "=mus_dogsong", "mus_temshop", "mus_dance_of_dog" },
    combate_light    = { "=mus_battle1", "=mus_battle2" },                                       -- Enemy Approaching
    caida            = { "=AUDIO_DRONE", "=AUDIO_DARKNESS" },
    llanuras         = { "=field_of_hopes", "field_of_hopes" },                                  -- Field of Hopes and Dreams
    bosque           = { "=forest", "scarlet_forest", "=mus_waterfall" },                         -- Scarlet Forest
    plato            = { "tv_world", "tvworld", "tv_time", "mus_mettatonbattle", "mus_mettaton", "cybercity", "=cyber" },
    cortijo          = { "=card_castle", "castle_funk", "=castle" },                              -- Card Castle
    muro             = { "=mus_hotel", "queen_mansion", "=mansion", "=mus_core" },                -- un hotel de lujo, muy Trump
    torre_aroy       = { "=AUDIO_ANOTHERHIM", "=mus_core", "mus_st_him" },
    combate          = { "=battle", "rude_buster", "rudebuster" },                                -- Rude Buster
    jefe             = { "=vs_susie", "=vs_lancer" },
    jefe_vito        = { "=vs_lancer", "=lancer", "=vs_susie" },
    jefe_angelpedro  = { "=mus_papyrusboss", "papyrusboss", "bonetrousle", "=vs_lancer" },        -- Bonetrousle
    jefe_abascal     = { "rouxls_battle", "rouxls", "=vs_lancer", "=vs_susie" },
    jefe_pablo       = { "=kingboss", "chaos_king", "king_boss", "=vs_susie" },                   -- el REY del armario: Chaos King
    jefe_trump       = { "spamton_battle", "spamton_neo", "big_shot", "mus_mettaton_ex" },        -- [BIG SHOT]
    jefe_netanyahu   = { "=mus_undynefast", "=mus_undyneboss", "spear_of_justice" },              -- Spear of Justice
    jefe_aroy        = { "mus_f_finale_1", "mus_f_finale", "=mus_flowey", "mus_zz_megalovania" },  -- Your Best Nightmare
    jefe_andres      = { "=mus_x_undyne", "=joker", "=mus_vsasgore", "=kingboss" },               -- Battle Against a True Hero
    papa_francisco   = { "hopesanddreams", "hopes_and_dreams", "savetheworld", "save_the_world", "=mus_reunited" },
    tienda           = { "=hip_shop", "=mus_shop", "=shop" },
    final_neutral    = { "mus_fallendown2", "fallendown", "=AUDIO_STORY", "=legend" },
    final_verdadero  = { "=mus_reunited", "=legend", "mus_respite" },
    final_furrygrave = { "=AUDIO_ANOTHERHIM", "mus_anothermedium", "mus_toomuch" },
    ruta_furrygrave  = { "snowgrave", "mus_toomuch", "=AUDIO_DRONE" },
}

MusicaJuegos.files = {}      -- nombre en minúsculas -> ruta completa
MusicaJuegos.found = {}      -- carpetas de juegos encontradas
MusicaJuegos.cache = {}      -- sección -> id de música ya registrado (o false)

local IS_WIN = love.system.getOS() == "Windows"
local bit = require("bit")

-- --------------------------------------------------------------- listar carpetas
local ffi_ok, ffi = pcall(require, "ffi")
if IS_WIN and ffi_ok then
    pcall(ffi.cdef, [[
        typedef struct { uint32_t lo, hi; } PCDM_FILETIME;
        typedef struct {
            uint32_t dwFileAttributes;
            PCDM_FILETIME ftCreationTime, ftLastAccessTime, ftLastWriteTime;
            uint32_t nFileSizeHigh, nFileSizeLow, dwReserved0, dwReserved1;
            char cFileName[260];
            char cAlternateFileName[14];
        } PCDM_FIND_DATA;
        void* FindFirstFileA(const char* name, PCDM_FIND_DATA* data);
        int FindNextFileA(void* handle, PCDM_FIND_DATA* data);
        int FindClose(void* handle);
    ]])
end

--- Devuelve { {name=, dir=bool}, ... } con lo que hay dentro de una carpeta del disco
local function listDir(dir)
    local out = {}
    if IS_WIN and ffi_ok then
        local ok = pcall(function()
            local data = ffi.new("PCDM_FIND_DATA")
            local h = ffi.C.FindFirstFileA((dir .. "\\*"):gsub("/", "\\"), data)
            if h == nil or ffi.cast("intptr_t", h) == -1 then return end
            repeat
                local name = ffi.string(data.cFileName)
                if name ~= "." and name ~= ".." then
                    table.insert(out, { name = name, dir = bit.band(data.dwFileAttributes, 0x10) ~= 0 })
                end
            until ffi.C.FindNextFileA(h, data) == 0
            ffi.C.FindClose(h)
        end)
        if not ok then return {} end
    else
        local ok, p = pcall(io.popen, 'ls -1p "' .. dir .. '" 2>/dev/null')
        if ok and p then
            for line in p:lines() do
                local isdir = line:sub(-1) == "/"
                table.insert(out, { name = isdir and line:sub(1, -2) or line, dir = isdir })
            end
            p:close()
        end
    end
    return out
end

local function exists(dir)
    return #listDir(dir) > 0
end

--- Busca .ogg dentro de una carpeta de juego (hasta 3 niveles: raíz, mus/, chapterN_windows/mus/)
local function scan(dir, depth)
    for _, e in ipairs(listDir(dir)) do
        local full = dir .. "/" .. e.name
        if e.dir then
            if depth < 3 then scan(full, depth + 1) end
        elseif e.name:lower():match("%.ogg$") then
            local stem = e.name:sub(1, -5):lower()
            -- si se repite (varios capítulos), se queda la primera que aparece
            if not MusicaJuegos.files[stem] then MusicaJuegos.files[stem] = full end
        end
    end
end

-- --------------------------------------------------------------- dónde están los juegos
local function steamLibraries()
    local libs = {}
    local roots
    if IS_WIN then
        roots = { "C:/Program Files (x86)/Steam", "C:/Program Files/Steam", "D:/Steam", "D:/Program Files (x86)/Steam" }
    else
        local home = os.getenv("HOME") or ""
        roots = { home .. "/.steam/steam", home .. "/.local/share/Steam", home .. "/Library/Application Support/Steam" }
    end
    for _, r in ipairs(roots) do
        table.insert(libs, r)
        local f = io.open(r .. "/steamapps/libraryfolders.vdf", "r")
        if f then
            local txt = f:read("*a")
            f:close()
            for path in txt:gmatch('"path"%s+"([^"]+)"') do
                table.insert(libs, (path:gsub("\\\\", "/")))
            end
        end
    end
    return libs
end

local function candidateDirs()
    local dirs = {}
    local function add(d) if d and d ~= "" then table.insert(dirs, (d:gsub("\\", "/"):gsub("/+$", ""))) end end
    -- rutas que pongas tú: rutas_juegos.txt al lado del .exe o en la carpeta de partidas
    local base = love.filesystem.getSourceBaseDirectory and love.filesystem.getSourceBaseDirectory() or nil
    local cfgs = { base and (base .. "/rutas_juegos.txt") }
    if love.filesystem.getSaveDirectory then table.insert(cfgs, love.filesystem.getSaveDirectory() .. "/rutas_juegos.txt") end
    for _, cfg in ipairs(cfgs) do
        local f = cfg and io.open(cfg, "r")
        if f then
            for line in f:lines() do
                line = line:gsub("^%s+", ""):gsub("%s+$", "")
                if line ~= "" and line:sub(1, 1) ~= "#" then add(line) end
            end
            f:close()
        end
    end
    for d in (os.getenv("PCDM_RUTAS_JUEGOS") or ""):gmatch("[^;]+") do add(d) end
    for _, lib in ipairs(steamLibraries()) do
        for _, name in ipairs({ "DELTARUNE", "DELTARUNEdemo", "Undertale", "UNDERTALE" }) do
            add(lib .. "/steamapps/common/" .. name)
        end
    end
    if IS_WIN then
        for _, d in ipairs({ "C:/Program Files (x86)/DELTARUNE", "C:/Program Files (x86)/DELTARUNEdemo",
            "C:/Program Files/DELTARUNE", "C:/Program Files (x86)/UNDERTALE", "C:/Program Files/UNDERTALE",
            "C:/GOG Games/Undertale", "C:/GOG Games/DELTARUNE" }) do add(d) end
    end
    return dirs
end

function MusicaJuegos.init()
    MusicaJuegos.files, MusicaJuegos.found, MusicaJuegos.cache, MusicaJuegos.chosen = {}, {}, {}, {}
    if os.getenv("PCDM_SIN_JUEGOS") then return end
    local seen = {}
    for _, d in ipairs(candidateDirs()) do
        local key = d:lower()
        if not seen[key] then
            seen[key] = true
            if exists(d) then
                local before = 0
                for _ in pairs(MusicaJuegos.files) do before = before + 1 end
                scan(d, 0)
                local after = 0
                for _ in pairs(MusicaJuegos.files) do after = after + 1 end
                if after > before then table.insert(MusicaJuegos.found, d) end
            end
        end
    end
    MusicaJuegos.plan()
    local n = 0
    for _ in pairs(MusicaJuegos.files) do n = n + 1 end
    if Mod and Mod.logger then
        Mod.logger:info("Música de juegos instalados: " .. n .. " canciones en " .. #MusicaJuegos.found .. " carpetas")
    end
end

-- Orden en que se reparten las canciones (lo primero se queda con su favorita)
MusicaJuegos.ORDEN = {
    "intro", "combate", "combate_light", "llanuras", "bosque", "cortijo", "muro", "plato", "torre_aroy", "caida",
    "jefe_pablo", "jefe_trump", "jefe_netanyahu", "jefe_angelpedro", "jefe_andres", "jefe_aroy", "jefe_vito",
    "jefe_abascal", "jefe", "papa_francisco", "final_verdadero", "final_neutral", "final_furrygrave",
    "ruta_furrygrave", "casa_lucia", "calle", "instituto", "aula", "patio", "casa_pablo", "casa_andres",
    "fiestas_pino", "tienda",
}

local function matches(c)
    local exact = c:sub(1, 1) == "="
    local want = (exact and c:sub(2) or c):lower()
    local out = {}
    if MusicaJuegos.files[want] then table.insert(out, want) end
    if not exact then
        local extra = {}
        for stem in pairs(MusicaJuegos.files) do
            if stem ~= want and stem:find(want, 1, true) then table.insert(extra, stem) end
        end
        table.sort(extra)
        for _, st in ipairs(extra) do table.insert(out, st) end
    end
    return out
end

--- Reparte las canciones: cada sección se queda con la mejor que no use ya otra sección;
--- si todas sus candidatas están cogidas, repite.
function MusicaJuegos.plan()
    MusicaJuegos.chosen = {}
    local used = {}
    for _, section in ipairs(MusicaJuegos.ORDEN) do
        local first, free
        for _, c in ipairs(MusicaJuegos.MAPA[section] or {}) do
            for _, stem in ipairs(matches(c)) do
                first = first or stem
                if not used[stem] then free = stem break end
            end
            if free then break end
        end
        local pick = free or first
        if pick then
            used[pick] = true
            MusicaJuegos.chosen[section] = pick
        end
    end
end

--- Elige el archivo para una sección (o nil)
function MusicaJuegos.pick(section)
    if not MusicaJuegos.chosen then MusicaJuegos.plan() end
    local stem = MusicaJuegos.chosen[section]
    if stem then return stem, MusicaJuegos.files[stem] end
    return nil
end

--- Id de música (registrado en Kristal) con la canción del juego para esa sección, o nil
function MusicaJuegos.music(section)
    if MusicaJuegos.cache[section] ~= nil then return MusicaJuegos.cache[section] or nil end
    local stem, path = MusicaJuegos.pick(section)
    local id = false
    if stem then
        local dest = "pcdm_musica/" .. stem .. ".ogg"
        local ok = love.filesystem.getInfo(dest) ~= nil
        if not ok then
            ok = pcall(function()
                local f = assert(io.open(path, "rb"))
                local data = f:read("*a")
                f:close()
                love.filesystem.createDirectory("pcdm_musica")
                assert(love.filesystem.write(dest, data))
            end)
        end
        if ok then
            id = "juego/" .. stem
            Assets.data.music[id] = dest
        end
    end
    MusicaJuegos.cache[section] = id
    return id or nil
end

return MusicaJuegos
