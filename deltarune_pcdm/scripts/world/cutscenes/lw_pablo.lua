-- CASA DE PABLO: las cuentas de mujeres falsas de Instagram.
local function DM(c, user, msg)
    c:text("* [color:5ad1ff]@" .. user .. "[color:reset]:\n  " .. msg)
end

return {
    inicio = function(c)
        PCDM.setParty({ "lucia" })
        c:loadMap("lw/casa_pablo", "spawn", "up")
        Game.world.player.visible = false
        PCDM.povCard(c, "CASA DE PABLO", "Lunes. 7:42 de la mañana.", 2.4)
        c:wait(c:fadeIn(0.5))
        local P = "pablo_lw"
        c:text("* Pablo lleva despierto desde las cuatro.[wait:5]\n* Por motivos.")
        c:text("* Venga, venga, venga...[wait:5]\n* A ver si hoy contesta alguna.", "neutral", P)
        Assets.playSound("phone", 0.6)
        DM(c, "valeria_hot_2009", "holaa guapo ;)[wait:5] mira mi perfil[wait:5]\n  link en bio")
        c:text("* ...[wait:10]Ya está.[wait:5] Esta sí.[wait:5]\n* Esta es real.[wait:5] Lo noto.", "blush", P)
        c:text("* (Pablo escribe muy rápido.)")
        DM(c, "pablito_alfa_07", "hola valeria.[wait:5] me gustan tus fotos.\n  q tal tu dia.[wait:5] respondeme porfa.")
        DM(c, "pablito_alfa_07", "porfa.[wait:10]\n  hola??[wait:10]\n  holaaa")
        Assets.playSound("phone", 0.6)
        DM(c, "valeria_hot_2009", "Haz clic aqui para ver mi contenido\n  EXCLUSIVO!! Solo 0,99 euros/semana")
        c:text("* ...[wait:10]Pues 0,99 tampoco es tanto.", "neutral", P)
        c:text("* Pablo sigue a 847 cuentas.[wait:5]\n* 846 son bots rusos.[wait:5]\n* La otra es la de Ibai.")
        Assets.playSound("phone", 0.6)
        DM(c, "sofi.lopez.fit", "hola cielo, soy nueva en la ciudad\n  y me siento sola...")
        c:text("* ¡OTRA!", "surprised", P)
        c:text("* Hoy es mi día.[wait:5]\n* Hoy es MI DÍA.", "grin", P)
        c:text(PCDM.thought("Y hoy en clase se lo digo a Ángel.[wait:5]\nHoy sí.[wait:5] Se tiene que atrever.[wait:5]\nTe, te."), "smug", P)
        c:text(PCDM.thought("Y a la furra esa le voy a decir\nlo que pienso.[wait:5] Que alguien se lo\ntiene que decir."), "angry", P)
        c:text("* Pablo no tiene vergüenza.[wait:10]\n* Pablo no tiene NADA de vergüenza.")
        PCDM.aroy(c, { "Vale, vale, VALE.[wait:5]\nYa está bien.[wait:5] Qué asco me da\neste tío.",
            "Cambiamos de escena.[wait:5]\nVamos con la protagonista." }, "angry")
        PCDM.setFlag("lucia_despierta", true)
        PCDM.switchPOV(c, { "lucia" }, "lw/casa_lucia", "spawn", "LUCÍA", "(PCDM)")
        c:gotoCutscene("lw_lucia.despertar")
    end,
}
