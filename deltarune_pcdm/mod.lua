-- DELTARUNE PCDM — Capítulo 1: ¡Sal del Armario!
-- Mod de DELTARUNE + UNDERTALE para Kristal.

function Mod:init()
    Mod.logger = Logger("DELTARUNE PCDM", ConsoleFormats.MAGENTA)

    -- Eventos propios para los mapas
    Game:registerEvent("guagua", function(data)
        return GuaguaStop(data.x, data.y, { data.width, data.height }, data.properties)
    end)
    Game:registerEvent("armario", function(data)
        return ArmarioEvent(data.x, data.y, data.properties)
    end)
    Game:registerEvent("deco", function(data)
        return DecoSprite(data.x, data.y, data.properties)
    end)

    -- Los textos largos se reparten solos en varias cajas
    PCDM.installTextHooks()

    -- Objetos del Light World: el menú de Kristal le pasa TODO el equipo a la curación
    -- (y crasheaba con "attempt to call method 'heal'"). Se cura quien lleva el menú,
    -- y el mensaje sale en castellano.
    Utils.hook(World, "heal", function(orig, world, target, amount, text)
        if type(target) == "table" and not isClass(target) then target = target[1] end
        if type(target) == "string" then target = Game:getPartyMember(target) end
        if not target then return end
        if not Game:isLight() then return orig(world, target, amount, text) end
        local maxed = target:heal(amount)
        local message = maxed and "* Tus PV están al máximo." or ("* Recuperas " .. amount .. " PV.")
        if text then message = text .. "\n" .. message end
        world:showText(message)
    end)

    -- Si alguien habla en mitad de un ataque, el combate se pausa para poder leerlo
    Utils.hook(Battle, "updateWaves", function(orig, battle)
        if PCDM.battle_paused then return end
        return orig(battle)
    end)
    Utils.hook(Battle, "onStateChange", function(orig, battle, old, new, reason)
        if new ~= "DEFENDING" and PCDM.battle_paused then
            PCDM.battle_paused = false
        end
        return orig(battle, old, new, reason)
    end)

    -- Las habitaciones más pequeñas que la pantalla salen centradas, como en DELTARUNE
    local function centerSmall(cam, x, y, bx, by, bw, bh)
        if not bx then bx, by, bw, bh = cam:getBounds() end
        if bw < cam.width / cam.zoom_x then x = bx + bw / 2 end
        if bh < cam.height / cam.zoom_y then y = by + bh / 2 end
        return x, y
    end
    Utils.hook(Camera, "getMinPosition", function(orig, cam, bx, by, bw, bh)
        local x, y = orig(cam, bx, by, bw, bh)
        if not cam.keep_in_bounds then return x, y end
        return centerSmall(cam, x, y, bx, by, bw, bh)
    end)
    Utils.hook(Camera, "getMaxPosition", function(orig, cam, bx, by, bw, bh)
        local x, y = orig(cam, bx, by, bw, bh)
        if not cam.keep_in_bounds then return x, y end
        return centerSmall(cam, x, y, bx, by, bw, bh)
    end)

    -- La música de cada mapa es una "sección": se busca en assets/music/<seccion>/
    Utils.hook(World, "transitionMusic", function(orig, world, next, fade_out)
        if type(next) == "string" and next ~= "" and not Assets.getMusicPath(next) then
            next = PCDM.findMusic(next) or ""
        end
        return orig(world, next, fade_out)
    end)

    if os.getenv("PCDM_TEST") then
        local orig_handler = Kristal.errorHandler
        Kristal.errorHandler = function(msg, level)
            print("[PCDMTEST] ERROR: " .. tostring(type(msg) == "table" and (msg.msg or msg.critical) or msg))
            print(debug.traceback("", 2))
            io.stdout:flush()
            love.event.quit(1)
            return orig_handler(msg, level)
        end
    end

    Mod.logger:info("Cargado " .. self.info.name .. ". Aroy.exe es el puto amo.")
end

function Mod:postInit(new_file)
    if os.getenv("PCDM_TEST") then
        -- en las pruebas automáticas los combates del Light World acaban de un golpe
        PCDM.test_easy = os.getenv("PCDM_TEST_FACIL") ~= "0"
        modRequire("scripts.tests").detector()
        Game.stage:addChild(PCDMTestRunner(os.getenv("PCDM_TEST")))
        return
    end
    if new_file then
        Game.world:startCutscene("intro.aroy")
    end
end

-- Fiestas del Pino: con cada chupito la cámara se tambalea un poco más
function Mod:postUpdate()
    local w = Game.world
    if w and w.camera then
        local m = w.pcdm_mareo or 0
        if m > 0 then
            local t = love.timer.getTime()
            w.camera:setOffset(math.sin(t * 1.7) * m * 3, math.cos(t * 1.3) * m * 2)
            w.pcdm_mareo_on = true
        elseif w.pcdm_mareo_on then
            w.camera:setOffset(0, 0)
            w.pcdm_mareo_on = false
        end
    end
end

-- Nombre de la partida en el menú de guardado
function Mod:getPresenceState()
    return "Jugando a DELTARUNE PCDM"
end
