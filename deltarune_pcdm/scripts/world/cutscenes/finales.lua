-- FINALES: neutral, verdadero y FURRYGRAVE. Créditos.
local T = PCDM.thought

local function backToClass(c)
    Game.world.music:stop()
    local fall = PCDMFall({ "lucia", "gabriel", "angel", "yerover", "isra", "alejandro" }, 3)
    Game.stage:addChild(fall)
    c:wait(function() return fall.done end)
    PCDM.setParty({ "lucia" })
    PCDM.setFlag("final", true)
    PCDM.setFlag("dia2", false)
    c:loadMap("lw/aula", "asiento", "down")
    c:wait(c:fadeIn(1))
end

local function spawnClass(c, list)
    local npcs = {}
    for _, e in ipairs(list) do
        local npc = c:spawnNPC(e[1] .. "_lw", e[2] * 40 + 20, e[3] * 40 + 36, { facing = e[4] or "up" })
        npc:setFacing(e[4] or "up")
        npcs[e[1]] = npc
    end
    return npcs
end

local function credits(c, title, color)
    local cr = PCDMCredits(title, color)
    Game.stage:addChild(cr)
    c:wait(function() return cr.done end)
    Game:returnToMenu()
end

return {
    neutral = function(c)
        backToClass(c)
        spawnClass(c, {
            { "yerover", 3, 7, "right" }, { "gabriel", 6, 7 }, { "angel", 9, 7 }, { "alejandro", 11, 7 }, { "julio", 13, 7 },
            { "isra", 2, 9 }, { "carmen", 4, 9 }, { "david", 6, 9 }, { "xibin", 9, 9 },
            { "andres", 9, 11 },
        })
        local L = "lucia_lw"
        c:text("* Estáis otra vez en el aula 2ºB.[wait:5]\n* El armario está cerrado.[wait:5] Es solo un armario.")
        c:text("* Lucía se toca la cabeza.[wait:10]\n* Ya no hay orejas.")
        c:text("* ...", "sad", L)
        c:text(T("Allí...[wait:5] me sentía yo."), "crying", L)
        c:text("* Bebé...[wait:5] yo también echo de menos tus\n  orejitas.", "sad", "yerover_lw")
        c:text("* Allí era un monstruo.[wait:5] Como Susie.[wait:5]\n* Aquí soy...[wait:5] solo Gabriel.", "sad", "gabriel_lw")
        c:text("* Zuzu se ha quedado allí, cariño.", "crying", "angel_lw")
        c:text("* JakoSherry también.", "sad", "alejandro_lw")
        c:text("* Ya no soy un tren.[wait:10] Chu...[wait:5] chu.", "crying", "julio_lw")
        c:text("* Diría que estoy triste.[wait:10]\n* ...Y lo digo.[wait:5] Porque lo estoy.", "sad", "xibin_lw")
        c:text("* (Al fondo de la clase, Andrés sonríe.)")
        c:text(T("Qué pena.[wait:10] Qué pena que no fuerais\nhasta el final."), "smile", "andres_lw")
        PCDM.aroy(c, { "Meh.", "Final neutral.[wait:5] Se podía hacer mejor.",
            "Los malos siguen ahí fuera.[wait:5] Y los buenos están\ntristes.[wait:5] Enhorabuena.",
            "La próxima vez, hazme caso." }, "angry")
        credits(c, "FINAL NEUTRAL", { 0.7, 0.7, 0.8 })
    end,
    verdadero = function(c)
        -- tras derrotar a Tijerafang
        c:text("* Lord Tijerafang se deshace.[wait:5] Solo queda\n  Andrés, de rodillas en el suelo.")
        c:text("* ...", "sad", "andres")
        c:text("* Te, te.[wait:10] Venga.[wait:5] Levántate.", "smile", "angel")
        c:text("* ...¿Por qué me ayudas?", "crying", "andres")
        c:text("* Porque nadie debería tener que esconderse\n  en un armario, cariño.[wait:10]\n* Ni siquiera tú.", "smile", "angel")
        c:text(T("..."), "crying", "andres")
        c:text("* Las almas que robó ya están en el infierno\n  gracias al Papa.[wait:5] Que en paz descanse.\n* Otra vez.", "neutral", "percha")
        c:text("* Lo cierro yo.", "happy", "lucia")
        backToClass(c)
        spawnClass(c, {
            { "yerover", 3, 7, "right" }, { "gabriel", 6, 7 }, { "angel", 9, 7 }, { "alejandro", 11, 7 }, { "julio", 13, 7 },
            { "isra", 2, 9 }, { "carmen", 4, 9 }, { "david", 6, 9 }, { "xibin", 9, 9 },
            { "pablo", 2, 11 }, { "dayron", 4, 11 }, { "angelpedro", 6, 11 }, { "andres", 9, 11 },
        })
        local L = "lucia_lw"
        c:text("* Estáis otra vez en el aula 2ºB.")
        c:text("* Pablo, Dayron y Angel Pedro están en sus\n  sitios.[wait:5] Volvieron del Dark World...[wait:10]\n* ...sin alma.")
        c:text("* Hola, chicos.[wait:5] He borrado Instagram.\n* Y he pedido perdón a todas las chicas a las\n  que molesté.[wait:5] Y a Ángel.", "smile", "pablo_lw")
        c:text("* Lucía, perdona por lo de la cola.[wait:5]\n* Cada uno es como es.[wait:5] Me he hecho una\n  fursona.[wait:5] Es un golden retriever.", "happy", "dayron_lw")
        c:text("* Hoy no he roto ninguna silla.", "happy", "angelpedro_lw")
        c:text("* Sin alma son majísimos, cariño.", "smug", "angel_lw")
        c:text("* En las noticias:[wait:5] \"Trump pide perdón por\n  primera vez en su vida.[wait:5] Los expertos\n  están desconcertados.\"", "neutral", "xibin_lw")
        c:text("* Lucía se toca la cabeza.[wait:5] Ya no hay\n  orejas...")
        c:text("* Pero se siente distinto.")
        c:text("* Chicos...[wait:10] tengo que deciros una cosa.", "neutral", L)
        c:text("* A partir de ahora...[wait:10] ¿podéis hablar de\n  mí en masculino?", "blush", L)
        c:text("* ...")
        c:text("* Claro, bro.", "grin", "gabriel_lw")
        c:text("* Claro, bebé.[wait:5] Te quiero igual.[wait:5]\n* Te quiero MÁS.", "blush", "yerover_lw")
        c:text("* ¡Ay, cariño, qué ilusión![wait:5] ¡Becas para tu\n  transición!", "happy", "angel_lw")
        c:text("* Las cartas ya lo sabían.", "smug", "carmen_lw")
        c:text("* Diría que me alegro.[wait:10]\n* Y lo digo.[wait:5] Porque me alegro mucho.", "smile", "xibin_lw")
        c:text("* ¡CHU CHU POR LUCÍA!", "happy", "julio_lw")
        c:text("* (Y en la última fila, Andrés mira a Ángel.\n  Ya no se esconde tanto.)")
        c:text(T("...Quizá algún día."), "blush", "andres_lw")
        PCDM.aroy(c, { "...", "GOOD BOY.", "El mejor final.[wait:5] El final verdadero.[wait:5]\nExactamente como yo lo quería.",
            "Bueno, lo de Andrés no.[wait:5] Pero lo demás sí.",
            "Gracias por jugar a mi juego.[wait:5] Hecho con la\nbeca MEC.[wait:5] Soy el puto amo." }, "happy")
        local gb = PCDMGoodBoy()
        Game.stage:addChild(gb)
        credits(c, "FINAL VERDADERO", { 1, 0.85, 0.3 })
    end,
    furrygrave = function(c)
        c:text("* ...")
        Assets.playSound("pcdm_aplauso")
        c:wait(3)
        local an = c:spawnNPC("andres", 8 * 40 + 20, 3 * 40 + 36, { facing = "down" })
        c:text("* Bravo.[wait:10] Bravo, Dayron.", "smile", "andres")
        c:text("* ¿¡Andrés!?", "surprised", "dayron")
        c:text("* Llevo todo el juego esperando esto.", "smug", "andres")
        c:text("* Tú hiciste el trabajo sucio.[wait:5] Lucía ya no\n  es furra.[wait:5] Gabriel está muerto.[wait:5]\n* Aroy ya no manda.", "grin", "andres")
        c:text("* Y todas esas almas...", "grin", "andres")
        Assets.playSound("snowgrave", 0.5, 0.5)
        an:setActor("tijerafang")
        an:setSprite("idle")
        c:shakeCamera(8)
        c:text("* ...son MÍAS.", "shout", "andres")
        c:text("* Este fue mi plan desde el principio.", "smile", "andres")
        c:text("* ...", "sad", "lucia")
        c:wait(c:fadeOut(2))
        credits(c, "FINAL FURRYGRAVE", { 0.6, 0.6, 0.65 })
    end,
}
