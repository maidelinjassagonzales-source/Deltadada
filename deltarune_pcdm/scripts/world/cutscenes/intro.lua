-- PRÓLOGO: Aroy.exe, el creador del universo.
return {
    aroy = function(c)
        Game.world.player.visible = false
        PCDM.setParty({ "lucia" })
        c:wait(1.2)
        local A = function(lines, face) PCDM.aroy(c, lines, face, { keep_music = true, top = false }) end
        A({ "¿ESTÁS AHÍ?" }, "neutral")
        c:wait(0.6)
        A({ "...[wait:10]Vale.[wait:5] Sí que estás.[wait:5]\nMe estás mirando a través de la pantalla." }, "smug")
        A({ "Soy AROY.EXE.[wait:5]\nEl creador de este universo.",
            "El Michael Jordan de los videojuegos.[wait:5]\nEl GOAT.[wait:5] El puto amo." }, "grin")
        A({ "Este juego lo he hecho YO.[wait:5]\nCon la BECA MEC.",
            "Mil y pico euros del Ministerio\nde Educación, chaval.[wait:5]\nBien invertidos." }, "smug")
        A({ "Aquí mando yo.[wait:5]\nY tú vas a hacer EXACTAMENTE lo que\nyo diga." }, "neutral")
        A({ "...[wait:5]Oye, ¿tú has visto el vídeo\nese del perro que hace skate?",
            "Es buenísimo, el perro va así,\nfiuuu, y luego hace un kickflip y...",
            "...[wait:10]No.[wait:5] Céntrate, Aroy.[wait:5]\nEl TDAH, tío.[wait:5] El TDAH." }, "happy")
        A({ "La historia va así:[wait:5] los buenos\nganan,[wait:5] Lucía sigue siendo una furra\nfeliz,[wait:5] y todo el mundo me aplaude.",
            "Y si ves a un tal DAYRON intentando\ncambiar el guion...[wait:10]\nNi puto caso.[wait:5] ¿Entendido?" }, "angry")
        local ch = c:choicer({ "Vale", "No" })
        if ch == 2 then
            Assets.playSound("pcdm_glitch")
            A({ "¿PERDONA?[wait:5]\n¿TÚ A MÍ ME VAS A DECIR QUE NO?" }, "shout")
            A({ "Era una pregunta retórica.[wait:5]\nVuelve a contestar." }, "angry")
            c:choicer({ "Vale", "Vale" })
            PCDM.setFlag("dijo_no_a_aroy", true)
        end
        PCDM.goodBoy(c, "Eso es.[wait:5] GOOD BOY.")
        A({ "Venga.[wait:5] Empezamos.[wait:5]\nY que no se te olvide quién manda aquí." }, "grin")
        c:wait(c:fadeOut(1))
        Game.world.music:stop()
        local card = PCDMTitleCard("DELTARUNE PCDM", "Capítulo 1:  ¡SAL DEL ARMARIO!", 3.5, { 1, 0.5, 0.85 })
        Game.stage:addChild(card)
        Assets.playSound("dtrans_flip", 0.7)
        c:wait(function() return card.done end)
        c:gotoCutscene("lw_pablo.inicio")
    end,
}
