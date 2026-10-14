-- TORRE DE AROY.EXE: el final.
local L, G, AN = "lucia", "gabriel", "angel"
local T = PCDM.thought

return {
    final = function(c)
        if PCDM.flag("torre_vista") then return end
        PCDM.setFlag("torre_vista", true)
        local p = Game.world.player
        c:text("* La Torre de Aroy.exe.[wait:5] Las paredes lloran\n  algo rojo y espeso.[wait:5] Hiperrealista.")
        PCDM.aroy(c, { "Bienvenidos a mi casa.", "Bueno.[wait:5] Vamos a ver qué habéis hecho en\nmi Dark World." }, "neutral")
        local n = PCDM.killCount()
        if PCDM.killedAllBad() then
            PCDM.aroy(c, { "...", "Todos.[wait:5] TODOS los del bando malo.[wait:5]\nMuertos.",
                "Esto es...[wait:10] precioso.[wait:5] Es exactamente lo que\nyo quería.[wait:5] Sois los mejores. GOOD B--" }, "happy")
            Assets.playSound("pcdm_aplauso")
            c:wait(1.2)
            c:text("* Gracias.")
            c:text("* ¿Quién ha dicho eso?", "surprised", L)
            local x, y = 9 * 40 + 20, 4 * 40 + 36
            local an = c:spawnNPC("andres", x, 2 * 40, { facing = "down" })
            c:wait(c:walkTo(an, x, y, 1.5, "down"))
            c:text("* ¿¡ANDRÉS!?", "surprised", AN)
            c:text("* Hola, chicos.[wait:5] Qué bien os veo.[wait:5]\n* Con vuestras orejitas.[wait:5] Vuestras colitas.", "smile", "andres")
            c:text("* Os he estado siguiendo todo el rato.[wait:5]\n* Desde el primer día.", "smug", "andres")
            c:text("* Cada vez que matabais a alguien...[wait:10]\n* su alma venía a MÍ.", "grin", "andres")
            Assets.playSound("pcdm_tijera")
            c:shakeCamera(4)
            c:text("* La de Pablo.[wait:5] La de Angel Pedro.[wait:5] La de\n  Vito, Motos, Abascal, Trump, Netanyahu...\n* Hasta las hormigas.", "grin", "andres")
            c:text("* Y la de Dayron.[wait:10] Gracias, Gabriel.[wait:5]\n* Me has hecho el trabajo sucio.", "smug", "andres")
            c:text("* ¿Qué...[wait:5] qué eres, Andrés?", "scared", L)
            c:text("* Soy lo que siempre quise ser.", "neutral", "andres")
            Assets.playSound("snowgrave", 0.5, 0.6)
            c:shakeCamera(10)
            an:setActor("tijerafang")
            an:setSprite("idle")
            c:text("* ¡¡LORD TIJERAFANG!!", "shout", "andres")
            c:text("* ¡Su fursona puede absorber almas!\n* ¡Por eso Aroy no le controlaba!", "surprised", G)
            PCDM.aroy(c, { "¿¡QUÉ!?[wait:5] ¿¡TÚ!?[wait:5]\n¡Esto NO estaba en el guion!",
                "¡Yo no he escrito esto![wait:5] ¡¡FUERA DE MI JUEGO!!" }, "shout")
            c:text("* Tu guion se ha acabado, Aroy.[wait:5]\n* Ahora el guion lo escribo YO.", "grin", "andres")
            c:text("* Voy a destruir a todo el que no sea\n  normal.[wait:5] Furros.[wait:5] Gays.[wait:5] Trans.\n* Todos.", "angry", "andres")
            c:text("* Andrés, cariño...[wait:10] ¿estás bien?", "sad", AN)
            c:text("* ¡¡NO ME MIRES ASÍ, ÁNGEL!!", "shout", "andres")
            c:text(T("¿Por qué me ha gritado a mí...?"), "surprised", AN)
            c:text("* ¡Chicos![wait:5] ¡A por él!", "angry", L)
            c:startEncounter("andres", true, an)
            an:remove()
            c:gotoCutscene("finales.verdadero")
        else
            PCDM.aroy(c, { "Has matado a " .. n .. " de " .. #PCDM.BAD_BOSSES .. ".",
                "...[wait:10]¿Ya está?[wait:5] ¿Así?[wait:5]\n¿Les has PERDONADO?",
                "Bueno.[wait:5] No es lo que yo quería.[wait:5] Pero vale.\nEs vuestra historia.[wait:5] Más o menos." }, "angry")
            c:text("* Para cerrar la Fuente Oscura...[wait:5]\n* alguien tiene que cerrar el armario desde\n  dentro.", "neutral", "percha")
            c:text("* Lo cierro yo.", "neutral", L)
            c:text("* ...Pero si lo cierro...[wait:10]\n* volvemos a casa.[wait:5] Sin orejas.[wait:5] Sin cola.", "sad", L)
            c:text("* Bebé...", "sad", "yerover")
            c:text("* Vamos, Lucía.[wait:5] Juntos.", "sad", G)
            c:gotoCutscene("finales.neutral")
        end
    end,
}
