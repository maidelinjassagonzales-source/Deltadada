-- Reproduce "Dayron.ogg" de fondo durante la pelea Gabriel vs Dayron,
-- con eco, reverb y distorsión que van cambiando con el tiempo.
-- Busca el audio en: assets/sounds/Dayron.(ogg|mp3|wav) o assets/music/dayron/*
local DayronDistorter, super = Class(Object)

local EFFECTS_OK = nil

local function findDayronFile()
    if not Mod or not Mod.info then return nil end
    local base = Mod.info.path
    for _, name in ipairs({ "Dayron", "dayron", "DAYRON" }) do
        for _, ext in ipairs({ "ogg", "mp3", "wav", "flac" }) do
            local p = base .. "/assets/sounds/" .. name .. "." .. ext
            if love.filesystem.getInfo(p) then return p end
        end
    end
    local id = PCDM.findMusic("dayron")
    if id and id:sub(1, 7) == "dayron/" then return Assets.getMusicPath(id) end
    return nil
end

function DayronDistorter:init()
    super.init(self, 0, 0)
    self.timer = 0
    self.effect_timer = 0
    self.phase = 0
    self.sources = {}
    local path = findDayronFile()
    if not path then
        Logging.warn("No se encontró Dayron.ogg (ponlo en assets/sounds/Dayron.ogg)")
        return
    end
    local ok, src = pcall(love.audio.newSource, path, "static")
    if not ok then return end
    src:setLooping(true)
    src:setVolume(0.9 * (MASTER_VOLUME or 1))
    self.main = src
    table.insert(self.sources, src)
    -- ¿soporta efectos OpenAL?
    if EFFECTS_OK == nil then
        EFFECTS_OK = pcall(function()
            assert(love.audio.isEffectsSupported and love.audio.isEffectsSupported())
            love.audio.setEffect("pcdm_dayron", { type = "echo", delay = 0.1, tapdelay = 0.1, damping = 0.4, feedback = 0.4, spread = -1 })
        end)
    end
    if EFFECTS_OK then
        pcall(function() src:setEffect("pcdm_dayron") end)
    else
        -- alternativa manual: copias desfasadas que hacen de eco
        for i = 1, 3 do
            local cl = src:clone()
            cl:setVolume(0.45 / i)
            table.insert(self.sources, cl)
        end
    end
    for i, s in ipairs(self.sources) do
        s:play()
        if i > 1 then pcall(function() s:seek(0.12 * (i - 1)) end) end
    end
end

function DayronDistorter:update()
    super.update(self)
    if not self.main then return end
    self.timer = self.timer + DT
    self.effect_timer = self.effect_timer + DT
    local t = self.timer
    -- tono y volumen que ondulan
    local pitch = 1 + 0.18 * math.sin(t * 0.7) + 0.06 * math.sin(t * 3.1)
    self.main:setPitch(math.max(0.5, pitch))
    self.main:setVolume((0.75 + 0.2 * math.sin(t * 1.3)) * (MASTER_VOLUME or 1))
    if self.effect_timer >= 0.25 then
        self.effect_timer = 0
        if EFFECTS_OK then
            -- cada ~6 segundos cambia de efecto: eco -> reverb -> distorsión -> eco...
            local phase = math.floor(t / 6) % 3
            pcall(function()
                if phase == 0 then
                    love.audio.setEffect("pcdm_dayron", {
                        type = "echo",
                        delay = 0.05 + 0.15 * (0.5 + 0.5 * math.sin(t)),
                        tapdelay = 0.1 + 0.3 * (0.5 + 0.5 * math.cos(t * 0.6)),
                        damping = 0.3, feedback = 0.3 + 0.5 * (0.5 + 0.5 * math.sin(t * 0.4)), spread = math.sin(t),
                    })
                elseif phase == 1 then
                    love.audio.setEffect("pcdm_dayron", {
                        type = "reverb", gain = 0.8, density = 1, diffusion = 1,
                        decaytime = 1 + 8 * (0.5 + 0.5 * math.sin(t * 0.5)),
                    })
                else
                    love.audio.setEffect("pcdm_dayron", {
                        type = "distortion", gain = 0.3, edge = 0.2 + 0.7 * (0.5 + 0.5 * math.sin(t * 2)),
                        lowcut = 2000, center = 1500, bandwidth = 2000,
                    })
                end
            end)
        else
            -- eco manual: cambia el desfase y el tono de las copias
            for i = 2, #self.sources do
                local s = self.sources[i]
                s:setPitch(math.max(0.5, pitch - 0.05 * i * math.sin(t * 0.3)))
            end
        end
    end
    -- baja la música de combate para que se oiga a Dayron
    if Game.battle and Game.battle.music then
        Game.battle.music:setVolume(0.35)
    end
end

function DayronDistorter:stop()
    for _, s in ipairs(self.sources) do
        pcall(function() s:stop() end)
    end
    self.sources = {}
    self.main = nil
    if EFFECTS_OK then
        pcall(function() love.audio.setEffect("pcdm_dayron", false) end)
    end
end

function DayronDistorter:onRemove(parent)
    self:stop()
    super.onRemove(self, parent)
end

return DayronDistorter
