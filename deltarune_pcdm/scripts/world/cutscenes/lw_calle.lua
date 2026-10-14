-- LA CALLE DEL INSTITUTO
local L = "lucia_lw"

return {
    puerta_lucia = function(c)
        c:text("* Tu casa.[wait:5] Si vuelves a entrar no sales\n  hasta el viernes.[wait:5] Mejor no.")
    end,
    aridai = function(c, ev)
        ev.count = (ev.count or 0) + 1
        local n = ev.count
        if n == 1 then
            c:text("* Ves a alguien asomado a la ventana, con\n  unos cascos gigantes.")
            c:text("* ...¡!", "surprised", "aridai_lw")
            c:text("* Se ha escondido.")
        elseif n == 2 then
            c:text("* Se oye a alguien gritar dentro.")
            c:text("* ¡GG EZ![wait:5] ¡Reportad al Mercy![wait:5]\n* ¡NO ME HA CURADO NI UNA VEZ!", "neutral", "aridai_lw")
        elseif n == 3 then
            c:text("* N-no estoy aquí.[wait:5]\n* Estoy en una ranked de League.", "blush", "aridai_lw")
            c:text("* Si ves a Daniel...[wait:10]\n* ...no le digas nada a nadie.", "blush", "aridai_lw")
            c:text("* ¿Quién es Daniel?", "surprised", L)
            Assets.playSound("doorclose")
            c:text("* La persiana se cierra de golpe.")
            c:text(PCDM.thought("Aridai lleva sin venir a clase desde\nseptiembre.[wait:5] Nadie sabe de qué bando es.\nNi siquiera sale de casa."), "neutral", L)
        else
            c:text("* La persiana está cerrada.[wait:5]\n* Se oye un \"teclea, teclea\" furioso.")
        end
    end,
    candelaria = function(c)
        c:text("* ¡Ay, mi niña![wait:5] ¿Y esa colita?[wait:5]\n* ¡Chacho, qué moderna!", "happy", "candelaria_lw")
        c:text("* Mi nieto también lleva cola.[wait:10]\n* Bueno, coleta.[wait:5] Es casi lo mismo.", "neutral", "candelaria_lw")
        c:text("* Y dile al chiquillo ese de los trenes que\n  se abrigue, que va siempre en camiseta.", "neutral", "candelaria_lw")
    end,
    paco = function(c)
        c:text("* ¡Buenos días, mi niña![wait:5]\n* Soy Paco, el guagüero de la Global.", "happy", "paco_lw")
        c:text("* La guagua al instituto hoy no pasa, que\n  hay huelga de...[wait:5] de algo.[wait:5]\n* Vete andando, que te viene bien.", "neutral", "paco_lw")
        c:text(PCDM.thought("Ojalá algún día las guaguas fueran\ngratis para todo el mundo..."), "neutral", "paco_lw")
    end,
    brayan = function(c)
        c:text("* ¡Quiubo, parce![wait:5] ¿Vio el partido de ayer?", "grin", "brayan_lw")
        c:text("* ¿No?[wait:5] Bueno, igual se lo cuento:\n* golazo de chilena en el último minuto.\n* Bacanísimo.", "happy", "brayan_lw")
        c:text(PCDM.thought("Hoy le escondo otra vez el trencito a\nJulio.[wait:5] Es que es muy chistoso."), "smug", "brayan_lw")
    end,
    julio_npc = function(c)
        c:text("* Chu chu.[wait:5] Chuuu chu.", "happy", "julio_lw")
    end,
    julio = function(c)
        local julio = c:getCharacter("julio_lw")
        local p = Game.world.player
        if not julio then return end
        c:wait(c:walkTo(julio, p.x + 50, p.y, 0.6, "left"))
        c:text("* ¡Lucía![wait:5] ¡LUCÍA![wait:5]\n* ¡Mira lo que me he traído a clase!", "happy", "julio_lw")
        c:text("* (Julio te enseña un tren de juguete azul\n  con una cara sonriente.)")
        c:text("* ¡Es Gordon![wait:5] ¡Y he traído también a\n  Thomas![wait:5] Hoy van a darse un beso\n  en el pupitre.", "grin", "julio_lw")
        c:text("* ...¿Otra vez, Julio?", "smile", L)
        c:text("* Es canon, Lucía.[wait:10]\n* Es CANON.", "neutral", "julio_lw")
        c:text("* Por cierto, que yo soy gay, eh.[wait:5]\n* Muy gay.[wait:5] Gayísimo.", "neutral", "julio_lw")
        c:text("* Lo que pasa es que solo me gustan los\n  chicos trans.[wait:5] Que también son chicos.\n* O sea, que soy gay.[wait:5] ¿Lo pillas?", "blush", "julio_lw")
        c:text("* ...Claro, Julio.[wait:5] Lo pillo.", "smile", L)
        c:text(PCDM.thought("Ojalá hoy Brayan no me esconda a\nGordon.[wait:5] La última vez apareció en el\nmicroondas de la sala de profes."), "sad", "julio_lw")
        c:text("* ¡CHU CHUUU![wait:5] ¡Nos vemos en clase!", "happy", "julio_lw")
        c:wait(c:walkTo(julio, 40 * 40, julio.y, 2.2, "right"))
        julio:remove()
    end,
}
