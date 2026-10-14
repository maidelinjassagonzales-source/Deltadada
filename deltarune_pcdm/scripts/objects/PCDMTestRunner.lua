-- Ejecutor de pruebas automáticas (solo se activa con la variable de entorno PCDM_TEST).
-- No afecta al juego normal. Sirve para comprobar que todos los mapas, combates y escenas cargan.
local PCDMTestRunner, super = Class(Object)

function PCDMTestRunner:init(name)
    super.init(self, 0, 0)
    self.layer = 99999
    self.persistent = true
    self.test_name = name
    self.shots = 0
    self.auto_keys = nil
    self.auto_timer = 0
    self.release = {}
    local ok, tests = pcall(function() return modRequire("scripts.tests") end)
    if not ok then
        print("[PCDMTEST] ERROR: no se pudo cargar scripts/tests.lua: " .. tostring(tests))
        love.event.quit(1)
        return
    end
    local fn = tests[name]
    if not fn then
        print("[PCDMTEST] ERROR: test desconocido " .. tostring(name))
        love.event.quit(1)
        return
    end
    self.co = coroutine.create(function() fn(self) end)
    self.wait_time = 0
    self.wait_fn = nil
    print("[PCDMTEST] inicio " .. name)
end

-- helpers --------------------------------------------------------------
function PCDMTestRunner:wait(t)
    if type(t) == "function" then
        self.wait_fn = t
    else
        self.wait_time = t or 0
    end
    coroutine.yield()
end

function PCDMTestRunner:press(key)
    love.event.push("keypressed", key, key, false)
    table.insert(self.release, { key = key, t = 0.05 })
end

function PCDMTestRunner:auto(keys, interval)
    self.auto_keys = keys
    self.auto_interval = interval or 0.12
end

function PCDMTestRunner:shot(name)
    self.shots = self.shots + 1
    local fname = string.format("pcdm_shots/%s_%02d_%s.png", self.test_name, self.shots, name or "shot")
    love.filesystem.createDirectory("pcdm_shots")
    love.graphics.captureScreenshot(function(img)
        img:encode("png", fname)
        print("[PCDMTEST] captura " .. fname)
    end)
    self:wait(0.1)
end

function PCDMTestRunner:log(...)
    local t = {}
    for _, v in ipairs({ ... }) do table.insert(t, tostring(v)) end
    print("[PCDMTEST] " .. table.concat(t, " "))
end

function PCDMTestRunner:waitNoCutscene(timeout)
    local t = 0
    self:wait(function()
        t = t + DT
        return (not Game.world.cutscene and not Game.battle) or t > (timeout or 30)
    end)
    return t <= (timeout or 30)
end

function PCDMTestRunner:waitBattle(timeout)
    local t = 0
    self:wait(function()
        t = t + DT
        return Game.battle ~= nil or t > (timeout or 30)
    end)
    return Game.battle ~= nil
end

function PCDMTestRunner:waitNoBattle(timeout)
    local t = 0
    self:wait(function()
        t = t + DT
        return Game.battle == nil or t > (timeout or 60)
    end)
    return Game.battle == nil
end

function PCDMTestRunner:finish(ok)
    print("[PCDMTEST] fin " .. self.test_name .. " " .. (ok == false and "FALLO" or "OK"))
    io.stdout:flush()
    love.event.quit(ok == false and 1 or 0)
end

-- bucle ----------------------------------------------------------------
function PCDMTestRunner:update()
    super.update(self)
    for i = #self.release, 1, -1 do
        local r = self.release[i]
        r.t = r.t - DT
        if r.t <= 0 then
            love.event.push("keyreleased", r.key, r.key)
            table.remove(self.release, i)
        end
    end
    if self.auto_keys then
        self.auto_timer = self.auto_timer + DT
        if self.auto_timer >= self.auto_interval then
            self.auto_timer = 0
            local k = self.auto_keys[love.math.random(1, #self.auto_keys)]
            self:press(k)
        end
    end
    if not self.co or coroutine.status(self.co) == "dead" then return end
    if self.wait_fn then
        if self.wait_fn() then self.wait_fn = nil else return end
    end
    if self.wait_time > 0 then
        self.wait_time = self.wait_time - DT
        return
    end
    local ok, err = coroutine.resume(self.co)
    if not ok then
        print("[PCDMTEST] ERROR en test: " .. tostring(err))
        print(debug.traceback(self.co))
        io.stdout:flush()
        love.event.quit(1)
    elseif coroutine.status(self.co) == "dead" then
        self:finish(true)
    end
end

return PCDMTestRunner
