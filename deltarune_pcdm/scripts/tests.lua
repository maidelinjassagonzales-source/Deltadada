-- Pruebas automáticas (solo con PCDM_TEST=<nombre>). No afectan al juego.
local tests = {}

function tests.humo(t)
    t:wait(1)
    Game.world:loadMap("pruebas", "spawn", "down")
    PCDM.setParty({ "lucia", "yerover", "angel" })
    Game.world:loadMap("pruebas", "spawn", "down")
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
    Game.world:loadMap("pruebas_lw", "spawn", "down")
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

return tests
