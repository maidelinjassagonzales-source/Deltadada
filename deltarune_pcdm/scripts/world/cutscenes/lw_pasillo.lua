-- PASILLO DEL INSTITUTO
local L = "lucia_lw"

return {
    profe = function(c)
        if PCDM.flag("pasillo_tarot") then
            c:text("* Lucía, a clase.[wait:5] Y quítate esa cola,\n  que esto es un instituto, no una\n  convención.", "annoyed", "profe_lw")
            c:text("* Es parte de mi identidad, profe.", "neutral", L)
            c:text("* Y la falta de asistencia es parte de tu\n  expediente.[wait:5] Para dentro.", "neutral", "profe_lw")
        else
            c:text("* Buenos días, Lucía.[wait:5] Llegas tarde,\n  como siempre.", "neutral", "profe_lw")
        end
    end,
    carmen = function(c)
        c:text("* Lucía.[wait:5] Las cartas dicen que hoy va a\n  pasar algo MUY raro.", "neutral", "carmen_lw")
        c:text("* Y que vas a necesitar ayuda.[wait:5]\n* Y que Xibin se muere en tres años.", "smug", "carmen_lw")
        c:text(PCDM.thought("Esta noche me toca bruja de guardia.[wait:5]\nLa luna está en Escorpio.[wait:5] Malo."), "closed", "carmen_lw")
    end,
    xibin = function(c)
        c:text("* Lucía.[wait:5] El que tiene cola, tiene\n  propósito.", "smug", "xibin_lw")
        c:text("* Por cierto: Modas Shanghái, calle Triana,\n  número 12.[wait:5] Este finde, 2x1 en\n  calcetines de anime.", "neutral", "xibin_lw")
        c:text(PCDM.thought("Todos me quieren.[wait:5] Hasta los que se\nodian entre ellos.[wait:5] Esa es la clave del\naura."), "closed", "xibin_lw")
    end,
    david = function(c)
        c:text("* Hola, Lucía.[wait:5] ¿Has escuchado el último\n  disco de Will Wood?", "smile", "david_lw")
        c:text("* ¿No?[wait:10] Normal.[wait:5] No lo ha escuchado\n  nadie.[wait:5] Por eso es bueno.", "neutral", "david_lw")
        c:text("* También estoy jugando a un juego indie\n  que se llama \"Pez Triste: Edición Lluvia\".\n* Tiene 4 reseñas en Steam.", "happy", "david_lw")
    end,
    fernanda = function(c)
        c:text("* ¡Órale, Lucía![wait:5] ¿Ya hiciste la tarea de\n  mate?", "happy", "fernanda_lw")
        c:text("* ¿No?[wait:5] Yo tampoco, güey.[wait:5]\n* Se la copiamos a Alejandro en el recreo.", "grin", "fernanda_lw")
        c:text(PCDM.thought("Un día pondré una taquería en el\ncentro.[wait:5] Tacos al pastor de verdad.[wait:5]\nNo esa cosa de los kebabs."), "smug", "fernanda_lw")
    end,
    maquina = function(c)
        c:text("* Una máquina expendedora.[wait:5]\n* Todo cuesta 2,50.[wait:5] Un robo.")
        if Game.lw_money and Game.lw_money >= 2 then
            local ch = c:choicer({ "Comprar Monster", "No" })
            if ch == 1 then
                Game.lw_money = Game.lw_money - 2
                Game.inventory:addItem("light/monster")
                Assets.playSound("item")
                c:text("* Has comprado un Monster de mango.")
            end
        end
    end,
    taquilla = function(c)
        c:text("* Tu taquilla.[wait:5] Hay pegatinas de anime,\n  una foto con Yerover y un calcetín\n  que no es tuyo.")
    end,
    tarot = function(c)
        local p = Game.world.player
        local carmen = c:getCharacter("carmen_lw")
        local xibin = c:getCharacter("xibin_lw")
        c:text("* Xibin, ven aquí.[wait:5] Que te vuelvo a echar\n  las cartas.", "neutral", "carmen_lw")
        c:text("* Carmen.[wait:5] Me las echaste ayer.", "annoyed", "xibin_lw")
        Assets.playSound("item")
        c:text("* (Carmen saca una carta.)")
        c:text("* ...[wait:10]La Muerte.[wait:5] Como siempre.\n* Te mueres en tres años, Xibin.", "smug", "carmen_lw")
        c:text("* Diría que eso me preocupa.[wait:10]\n* Pero no lo digo, porque no me preocupa.", "smug", "xibin_lw")
        c:text("* Dos años y once meses, ya.", "closed", "carmen_lw")
        c:text("* En tres años Modas Shanghái tendrá doce\n  tiendas y Hoyoverse sacará otro gacha.\n* Moriré rico.", "grin", "xibin_lw")
        c:look(xibin, "left")
        c:text("* Lucía.[wait:5] Bonita cola.", "neutral", "xibin_lw")
        c:text("* ¡Gracias, Xibin!", "happy", L)
        c:wait(0.5)
        c:text("* ...")
        c:text("* ......")
        Game.world.music:pause()
        Assets.playSound("pcdm_grillos")
        c:text("* .........")
        Game.world.music:resume()
        c:shakeCamera(4)
        c:text("* ¡¡¡MOMENTO INCÓMODO!!!", "grin", "xibin_lw")
        c:text("* ¿Por qué gritas eso?", "surprised", L)
        c:text("* Porque lo era.", "smug", "xibin_lw")
        c:text("* David, ven, que te presento.[wait:5]\n* Lucía, este es David.[wait:5] Mi novio.[wait:5]\n* Es bisexual.", "happy", "carmen_lw")
        c:text("* ...[wait:5]Sí.[wait:5] Bisexual.[wait:5] Eso.\n* Bisexual.[wait:5] Muy bisexual.", "blush", "david_lw")
        c:text(PCDM.thought("Bisexualísimo.[wait:5] Cien por cien\nbisexual.[wait:5] Sin duda.[wait:10]\n...Ay, Dios."), "scared", "david_lw")
        c:text(PCDM.thought("Las cartas dicen que hoy Lucía va a\nnecesitar ayuda.[wait:5] Y que alguien en clase\nesconde algo muy, muy oscuro."), "neutral", "carmen_lw")
        PCDM.setFlag("pasillo_tarot", true)
    end,
}
