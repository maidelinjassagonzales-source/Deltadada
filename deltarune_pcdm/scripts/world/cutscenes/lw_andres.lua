-- HABITACIÓN DE ANDRÉS. Controlas a Andrés (por exigencias del guion).
local A = "andres_lw"
local T = PCDM.thought

local function check_end(c)
    if PCDM.flag("andres_pc") and PCDM.flag("andres_cajon") and PCDM.flag("andres_movil") and not PCDM.flag("andres_fin") then
        PCDM.setFlag("andres_fin", true)
        c:gotoCutscene("lw_andres.fin")
    end
end

return {
    entrar = function(c)
        PCDM.aroy(c, { "Un momento.[wait:5]\n¿Por qué estás controlando a ESTE?",
            "...[wait:10]Bueno, vale.[wait:5] Es necesario para la trama.",
            "Pero no toques nada raro.[wait:5]\nY sobre todo NO abras el cajón." }, "angry")
        c:text("* (Ahora controlas a Andrés.)")
    end,
    espejo = function(c)
        c:text("* Te miras al espejo.")
        c:text(T("Sonríe.[wait:5] Que no se note nada.[wait:10]\nNunca."), "smile", A)
        c:text(T("Un hombre de verdad no siente esas\ncosas.[wait:5] Un hombre de verdad no..."), "sad", A)
    end,
    poster = function(c)
        c:text("* Un póster en blanco y negro.[wait:5]\n* \"PROVE ME WRONG\".")
        c:text(T("Nadie me ha demostrado que me\nequivoque.[wait:10] Porque nunca me atrevo a\npreguntárselo a nadie."), "neutral", A)
    end,
    cosplay = function(c)
        c:text("* Tu cosplay de Marine Espacial.[wait:5]\n* Hecho con cajas de Zara, cola blanca y\n  cinta americana.")
        c:text(T("Por el Emperador.[wait:5] Con este cosplay\nnadie ve lo que hay debajo."), "smug", A)
    end,
    tijeras = function(c)
        Assets.playSound("pcdm_tijera")
        c:text("* Unas tijeras grandes, con mango rojo.\n* Siempre las llevas encima.")
        c:text(T("Ris, ras.[wait:5] Ris, ras.[wait:10]\nEl sonido me calma.[wait:5] Me ayuda a no\npensar."), "neutral", A)
    end,
    pc = function(c)
        c:text("* ForoPatria.es[wait:5] — Hilo:\n  \"Los furros son el fin de Occidente\"\n  (+18 páginas)")
        c:text(T("Doce mensajes míos en ese hilo.[wait:5]\nTodos con más de cien likes."), "smug", A)
        c:text("* Otra pestaña:[wait:5] un vídeo de Charlie Kirk\n  debatiendo en una universidad.")
        c:text(T("Él sí que tenía las cosas claras."), "neutral", A)
        c:text("* Otra pestaña:[wait:5] World of Warcraft.[wait:5]\n* Tu orco nivel 80 se llama \"Ordenyley\".")
        PCDM.setFlag("andres_pc", true)
        check_end(c)
    end,
    cajon = function(c)
        c:text("* Un cajón cerrado con llave.[wait:5]\n* Llevas la llave colgada del cuello.")
        local ch = c:choicer({ "Abrirlo", "Mejor no" })
        if ch ~= 1 then return end
        Assets.playSound("locker")
        c:text("* Dentro hay un dibujo hecho con mucho\n  cuidado.")
        c:text("* Un lobo negro enorme, con capa roja,\n  armadura y tijeras en vez de garras.")
        c:text(T("LORD TIJERAFANG.[wait:10]\nMi fursona."), "blush", A)
        c:text(T("Nadie puede saberlo.[wait:5] NADIE.[wait:5]\nSi en el foro se enteran..."), "scared", A)
        c:text(T("Tijerafang es perfecto.[wait:5] Es fuerte.\nEs temido.[wait:5] Puede tragarse el alma de\ncualquiera que se le ponga delante."), "smug", A)
        c:text(T("Es lo que yo debería ser.[wait:10]\nEs lo que voy a ser."), "grin", A)
        PCDM.aroy(c, { "TE HE DICHO QUE NO ABRIERAS EL CAJÓN.",
            "...[wait:10]Bueno.[wait:5] Ya está.[wait:5] Ya lo has visto.\nNo se lo digas a nadie." }, "angry")
        PCDM.setFlag("andres_cajon", true)
        check_end(c)
    end,
    movil = function(c)
        Assets.playSound("phone", 0.6)
        c:text("* Tu móvil vibra.[wait:5] Es el grupo de clase.")
        c:text("* [color:ff9ccf]Ángel[color:reset]: chicoss mañana en el recreo\n  hablamos de la fiesta del viernes!!\n  traed orejitas jajaja")
        c:text("* Te quedas mirando su nombre.")
        c:text(T("Ángel..."), "blush", A)
        c:text(T("..."), "sad", A)
        c:text(T("No.[wait:5] NO.[wait:10]\nEso no es verdad.[wait:5] Yo no soy así.\nYo no soy como ellos."), "angry", A)
        Assets.playSound("pcdm_tijera")
        c:text("* (Ris, ras.[wait:5] Ris, ras.)")
        PCDM.setFlag("andres_movil", true)
        check_end(c)
    end,
    fin = function(c)
        local p = Game.world.player
        c:wait(0.6)
        c:look(p, "down")
        c:wait(0.8)
        c:text("* ...", "neutral", A)
        c:text("* ¿Tú quién eres?", "neutral", A)
        c:text("* ¿Por qué me estás mirando?", "angry", A)
        c:text("* ...[wait:10]¿Por qué me estás CONTROLANDO?", "shout", A)
        Game.stage:addChild(PCDMGlitch(1.2))
        PCDM.aroy(c, { "VALE.[wait:5] SUFICIENTE.[wait:5] FUERA DE AQUÍ.",
            "Este personaje NO lo controlas tú.[wait:5]\nNo es de los buenos.",
            "Vamos a otra escena.[wait:5] Una más alegre.\nCon alcohol." }, "shout")
        PCDM.switchPOV(c, { "isra" }, "lw/pino", "spawn", "ISRA", "Hace dos semanas.  Fiestas del Pino, Teror.")
        c:gotoCutscene("lw_pino.llegada")
    end,
}
