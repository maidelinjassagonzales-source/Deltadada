-- EL MURO DE TRUMP. Todos se reúnen.
local L, Y, AN, G = "lucia", "yerover", "angel", "gabriel"
local T = PCDM.thought

local function refreshParty()
    for _, id in ipairs(PCDM.GOOD) do
        PCDM.setFlag("en_equipo_" .. id, PCDM.hasMember(id))
    end
end

local AMIGOS = {
    yerover = "* ¡Bebé![wait:5] Si me necesitas, aquí estoy.[wait:5]\n* ARE YOU OKAY?",
    isra = "* El Capitán Israel está listo.[wait:5] Más o\n  menos.[wait:5] Hic.",
    alejandro = "* ¿Sabías que en Deltarune también hay un\n  muro?[wait:5] Bueno, no.[wait:5] Pero podría.",
    carmen = "* Las cartas dicen que el final está cerca.\n* Y que alguien de clase nos la va a liar.",
    david = "* He compuesto una canción sobre este\n  muro.[wait:5] Se llama \"Muro\".[wait:5] Es muy indie.",
    julio = "* ¡Chu chu![wait:5] ¡Si me llevas, atropello el\n  muro!",
    xibin = "* Diría que tengo miedo.[wait:10]\n* Pero no lo digo, porque tengo aura.",
    angel = "* Cariño, Trump es lo peor.[wait:5] Vamos a por él.",
    gabriel = "* Si Dayron está por aquí...[wait:5] es mío.",
}

local M = {
    reunion = function(c)
        if PCDM.flag("reunion") then return end
        local p = Game.world.player
        c:text("* Delante del muro gigante...[wait:5] hay gente.")
        c:text("* ¡¡LUCÍA!!", "shout", G)
        c:text("* ¡¡GABRIEL!![wait:5] ¡¡CHICOS!!", "happy", L)
        c:text("* ¡Estáis todos bien![wait:5] ¡Isra, Alejandro,\n  Carmen, Julio, Xibin!", "happy", AN)
        c:text("* Bro.[wait:5] Bro, tienes orejas de zorro.[wait:5]\n* Te quedan de puta madre.", "grin", G)
        c:text("* ¡Y tú tienes cuernos de Susie!", "happy", L)
        c:text("* LO SÉ.[wait:5] ES EL MEJOR DÍA DE MI VIDA.", "shout", G)
        c:text("* ¿Y David?", "neutral", L)
        c:text("* Aquí estoy.[wait:5] Tuve una charla muy larga\n  con Yolanda Díaz sobre...[wait:5] mí.", "blush", "david")
        c:text("* ¡Chu chu![wait:5] ¡Mirad mi chimenea!", "happy", "julio")
        c:text("* ¿Dónde está Dayron?[wait:5] Angel Pedro dijo que\n  quería \"hablar con la furra\".", "angry", G)
        c:text("* No le hemos visto.[wait:5] Pero el muro...[wait:5]\n* El muro tiene dueño.", "neutral", "carmen")
        PCDM.aroy(c, { "Detrás de ese muro está el final del Dark\nWorld.",
            "Y delante, el tío más naranja del universo.",
            "(Podéis cambiar el equipo hablando con los\ndemás.[wait:5] Lucía va siempre.[wait:5] Es la\nprota.[wait:5] Lo digo yo.)" }, "grin")
        PCDM.setParty({ "lucia", "gabriel", "angel" })
        refreshParty()
        PCDM.setFlag("reunion", true)
        c:loadMap("dw/muro_1", p.x, p.y, "right")
        if PCDM.flag("hormigas_vienen") and not PCDM.isDone("hormigas") then
            c:gotoCutscene("dw_muro.hormigas")
        end
    end,
    hormigas = function(c)
        c:wait(0.4)
        c:shakeCamera(4)
        c:text("* ¡¡PABLOOOOOO!!")
        c:text("* ¡¡HABÉIS MATADO A PABLO!![wait:5]\n* ¡¡OS VAMOS A HACER UN EXPERIMENTO!!")
        c:text("* ¡Son Trancas y Barrancas![wait:5]\n* ¡Las hormigas de El Hormiguero!", "surprised", L)
        c:text("* ¿Cuál es Trancas y cuál es Barrancas?", "neutral", AN)
        c:text("* Nadie lo sabe, cariño.[wait:5] Nadie lo ha sabido\n  nunca.", "smug", "angel")
        c:startEncounter("hormigas", true)
        if PCDM.isKilled("hormigas") then
            c:text("* Las hormigas se han deshecho en polvo de\n  plató.")
            Boss.reward(c, "hormigas")
            PCDM.goodBoy(c, "Hasta las hormigas.[wait:5] Completito.[wait:5]\nGOOD BOY.")
        else
            c:text("* Las hormigas se van a hacer otro programa.\n* Uno de cocina.")
        end
    end,
    trump = function(c)
        local tr = c:getCharacter("trump")
        if not tr then return end
        c:text("* ¡¡STOP!![wait:5] ¡¡THIS IS MY WALL!!\n* ¡¡EL MURO MÁS GRANDE DEL MUNDO!!", "shout", "trump")
        c:text("* Donald Trump.[wait:5] Darkner de gorra.[wait:5]\n* Más naranja en persona.")
        c:text("* Nadie sabe más de muros que yo.[wait:5]\n* Nadie.[wait:5] Me lo dicen siempre:[wait:5]\n* \"Señor, sabe usted mucho de muros\".", "smug", "trump")
        c:text("* Furros, gitanos, twinks...[wait:5] ¡FUERA![wait:5]\n* ¡Y que el muro lo paguen ellos!", "angry", "trump")
        c:text("* Te voy a poner un arancel del 200% en\n  la cara, naranjito.", "angry", G)
        local r = Boss.fight(c, "trump", "trump", "trump")
        PCDM.setFlag("trump_hecho", true)
        if r == "killed" then
            c:text("* Trump se ha convertido en polvo naranja.")
            c:text("* Su tupé queda flotando en el aire...")
            Boss.reward(c, "trump")
            c:wait(0.6)
            c:shakeCamera(6)
            Assets.playSound("alert")
            local x, y = 15 * 40 + 20, 8 * 40 + 36
            local bibi = c:spawnNPC("netanyahu", x, 2 * 40, { facing = "down" })
            c:wait(c:walkTo(bibi, x, y, 1, "down"))
            c:text("* ¿Quién...[wait:10] quién ha tocado a mi Donald?", "angry", "netanyahu")
            c:text("* ¿¡NETANYAHU!?", "surprised", AN)
            c:text("* Donald era mi mejor amigo.[wait:5] Mi aliado.\n* Mi...[wait:5] Donald.", "shout", "netanyahu")
            c:text("* Esto va a tener consecuencias.[wait:5]\n* Y no me habléis de La Haya.", "angry", "netanyahu")
            c:text("* La Haya te está buscando, cariño.\n* Tienes una orden de arresto.", "smug", AN)
            c:text("* ¡¡HE DICHO QUE NO ME HABLÉIS DE LA HAYA!!", "shout", "netanyahu")
            local r2 = Boss.fight(c, "netanyahu", nil, "netanyahu")
            bibi:remove()
            if r2 == "killed" then
                c:text("* Netanyahu se ha convertido en polvo.")
                Boss.reward(c, "netanyahu")
                PCDM.goodBoy(c)
            else
                c:text("* Netanyahu se va.[wait:5] Dice que esto no ha\n  terminado.[wait:5] Lo dice siempre.")
            end
        elseif r == "spared" then
            c:text("* Trump se sienta encima de su muro a\n  escribir en su red social.")
            c:text("* \"Me han tratado MUY MAL.[wait:5] Muy injusto.\n  TRISTE.\"")
        end
        c:text("* El muro se abre por la mitad...[wait:5]\n* Detrás hay unas escaleras.")
        local p = Game.world.player
        c:loadMap("dw/muro_1", p.x, p.y, p.facing)
    end,
    dayron = function(c)
        local d = c:getCharacter("dayron")
        if not d then return end
        c:text("* Por fin llegáis.", "smug", "dayron")
        c:text("* ¡¡DAYRON!!", "shout", G)
        c:text("* Lucía.[wait:5] Mírate.[wait:5] Orejas.[wait:5] Cola.[wait:5]\n* Esto no es normal.[wait:5] Esto no eres tú.", "neutral", "dayron")
        c:text("* Esto es exactamente quien soy, Dayron.", "angry", L)
        c:text("* Vuelve al Light World conmigo.[wait:5] Quítate todo\n  esto.[wait:5] Sé una chica normal.[wait:5] Por tu bien.", "smug", "dayron")
        c:text(T("...Por mi bien."), "sad", L)
        c:text("* Lucía, no le escuches.", "angry", G)
        c:text("* Gabriel da un paso al frente.")
        c:text("* Chicos.[wait:5] Esto es entre él y yo.", "angry", G)
        c:text("* ¿Tú solo, retramonguer?", "grin", "dayron")
        c:text("* Susie lucharía sola.[wait:10]\n* Así que yo también.", "shout", G)
        PCDM.aroy(c, { "SÍ.[wait:5] SÍ.[wait:5] ESTO.[wait:5] ESTO ES LO QUE YO QUERÍA.",
            "Gabriel contra Dayron.[wait:5] El duelo del siglo.\nDale fuerte, chaval." }, "grin")
        local ids = {}
        for _, chara in ipairs(Game.party) do table.insert(ids, chara.id) end
        PCDM.setParty({ "gabriel" })
        local r = Boss.fight(c, "dayron", "dayron", "dayron")
        PCDM.setParty({ "lucia", "gabriel", (ids[3] ~= "gabriel" and ids[3]) or (ids[2] ~= "gabriel" and ids[2]) or "angel" })
        refreshParty()
        PCDM.setFlag("dayron_hecho", true)
        if r == "killed" then
            c:text("* Dayron cae de rodillas.", "sad")
            c:text("* Yo...[wait:5] solo quería...[wait:5] que todo fuera\n  normal...", "crying", "dayron")
            c:text("* Lo normal es que cada uno sea quien es,\n  bro.", "sad", G)
            c:text("* Dayron se convierte en polvo.[wait:5]\n* Solo queda un sticker con su cara en el\n  suelo.")
            Boss.reward(c, "dayron")
            PCDM.aroy(c, { "...", "Se acabó Dayron.[wait:5] Se acabaron los\ncambios de guion.",
                "GOOD BOY.[wait:5] GOOD BOY, GABRIEL.[wait:5]\nPor fin.[wait:5] Por fin todo va como yo quiero." }, "happy")
        elseif r == "spared" then
            c:text("* ...Vale.[wait:5] Vale, retramonguer.[wait:5] Tú ganas.", "sad", "dayron")
            c:text("* Pero esto no se ha acabado.[wait:5] Algún día\n  Lucía me dará la razón.", "angry", "dayron")
            c:text("* Dayron se va.[wait:5] Deja caer un sticker con\n  su cara.")
            PCDM.aroy(c, { "¿Le has DEJADO IR?[wait:5]\n¿Al que me quiere cambiar el guion?",
                "...Bueno.[wait:5] Tú sabrás." }, "angry")
        end
        local p = Game.world.player
        c:loadMap("dw/muro_2", p.x, p.y, "up")
        c:text("* Al fondo se ve una torre negra que gotea\n  algo rojo.")
    end,
}

for id, line in pairs(AMIGOS) do
    M["amigo_" .. id] = function(c)
        c:text(line, "neutral", id)
        local ch = c:choicer({ "Al equipo", "Nada" })
        if ch == 1 then
            if PCDM.swapMember(c, id) then
                refreshParty()
                local p = Game.world.player
                c:loadMap(Game.world.map.id, p.x, p.y, p.facing)
            end
        end
    end
end

return M
