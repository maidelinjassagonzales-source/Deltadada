-- AULA 2ºB: aquí no se sabe de qué bando es cada uno... salvo por los pensamientos entre paréntesis.
local L = "lucia_lw"
local T = PCDM.thought

local function pos(tx, ty) return tx * 40 + 20, ty * 40 + 36 end

local PABLO_LW = {
    intro = "* ¡Pablo te corta el paso![wait:5]\n* Tiene el móvil en la mano.[wait:5] Peligro.",
    music = "combate_light",
    enemy = {
        name = "Pablo",
        sprite = { "chars/pablo/light/walk/down_1", "chars/pablo/light/walk/down_2", "chars/pablo/light/walk/down_3", "chars/pablo/light/walk/down_4" },
        scale = 4, hp = 50, atk = 3, def = 0, hit_damage = 14, money = 3,
        check = "* Sigue a 847 cuentas. 846 son bots.\n* Le gusta Lucía. A Lucía NO le gusta él.",
        flavor = {
            "* Pablo te enseña su Instagram.",
            "* Huele a Axe y a desesperación.",
            "* Pablo está escribiéndote algo...\n* ...y lo borra.",
            "* Pablo comprueba si Valeria le ha\n  contestado.[wait:5] No.",
        },
        low_text = "* A Pablo le tiembla el labio.",
        spareable_text = "* Pablo ya no sabe qué decir.",
        dialogue = { "Dame tu insta.", "¿Por qué no me\ncontestas?", "Con esa cola pareces\nun peluche de feria.",
            "Las chicas de Insta\nsí me hacen caso.", "Te sigo y me\nsigues, ¿no?" },
        acts = {
            { name = "Ignorar", mercy = 35, text = { "* Ignoras a Pablo.", "* Pablo no está acostumbrado a que le\n  ignoren.[wait:10]\n* ...Bueno, sí.[wait:5] Está MUY acostumbrado." } },
            { name = "Llamar a Yerover", mercy = 40, text = { "* ¡Yerover!", "* Yerover se levanta de golpe:[wait:5]\n  \"¡HEY![wait:5] ¡COME ON!\"", "* Pablo da un pasito atrás." } },
            { name = "Consentimiento", mercy = 35, text = { "* Le explicas lo que es el consentimiento.", "* Pablo saca una libreta.[wait:5]\n* No apunta nada." } },
            { name = "Bloquear", mercy = 50, text = { "* Le bloqueas en todas las redes sociales.", "* Pablo siente un vacío enorme en su feed." } },
        },
        waves = { "palabras", "lluvia" },
        bullet_words = { "hola", "q tal", "porfa", "respondeme", "dame tu insta", "0,99", "??", "holaaa" },
        bullet_sprites = { "billete", "corazon" },
        spare_text = { "* Perdonas a Pablo.", "* Pablo se queda mirando el móvil.[wait:5]\n* Nadie le ha contestado." },
        defeat_text = { "* Pablo se va a una esquina a llorar.[wait:10]\n* Bueno.[wait:5] A mirar el móvil.[wait:5] Llorando." },
    },
}

local function student(id, lines)
    return function(c)
        for _, l in ipairs(lines) do
            c:text(l[1], l[2], l[3] or (id .. "_lw"))
        end
    end
end

return {
    yerover = student("yerover", {
        { "* ¡Lucía![wait:5] ¡Siéntate a mi lado, bebé!", "happy" },
        { "* Ayer hice un combo de 40% con Terry en\n  Smash.[wait:5] Power Wave, Burn Knuckle y...[wait:5]\n  ¡BUSTER WOLF!", "grin" },
        { T("Hoy le compro un Monster de mango.[wait:5]\nSe lo merece."), "blush" },
    }),
    gabriel = student("gabriel", {
        { "* Lucía, ¿has visto el último fanart de\n  Susie?[wait:5] La reina.[wait:5] LA PUTA REINA.", "grin" },
        { "* Soy un retramonguer y a mucha honra.", "smug" },
        { T("Como Dayron le vuelva a decir algo a\nLucía, le suelto un Rude Buster en toda\nla puta cara."), "angry" },
    }),
    isra = function(c)
        c:text("* Isra está dormido encima del pupitre.[wait:5]\n* Huele a ron miel.")
        c:text("* ...las calles de Tel Aviv...[wait:5]\n* ...están a salvo...[wait:10] hic.", "closed", "isra_lw")
        c:text(T("Nunca más.[wait:5] Nunca más bebo.[wait:10]\nHasta el viernes."), "sad", "isra_lw")
    end,
    angel = student("angel", {
        { "* ¡Ay, Lucía, qué cola más mona!", "happy" },
        { "* Yo me he traído las orejas de Zuzu en la\n  mochila.[wait:5] Por si acaso.", "smile" },
        { "* Esta tarde tengo clase en el Obelisco.\n* Ciencia Política.[wait:5] Algún día seré\n  presidente del PCE, cariño.", "smug" },
        { T("Cuando gobierne, habrá becas para\nfursuits.[wait:5] Y para todo el mundo.[wait:5]\nBecas y ayudas, cari."), "blush" },
    }),
    alejandro = function(c)
        c:text("* Alejandro tiene los cascos puestos.[wait:5]\n* Se oye Tally Hall a todo volumen.")
        c:text("* ¿Eh?[wait:5] ¡Ah, Lucía!", "surprised", "alejandro_lw")
        c:text("* ¿Tú shippeas a Kris y a Ralsei?[wait:5]\n* KRALSEI ES CANON.[wait:5] Toby Fox lo sabe.\n* Todos lo sabemos.", "smug", "alejandro_lw")
        c:text(T("Esta noche me conecto como JakoSherry\nen Roblox.[wait:5] Hay un evento a las diez."), "blush", "alejandro_lw")
    end,
    julio = function(c)
        c:text("* Chu chu.[wait:5] Chuuuuu chu.", "happy", "julio_lw")
        c:text("* ¡Julio, deja ya el trencito, parce![wait:5]\n* ¡Que tienes diecisiete años!", "grin", "brayan_lw")
        c:text("* ¡Es Gordon![wait:5] ¡Y tiene sentimientos!", "angry", "julio_lw")
        c:text("* Unos cuantos se ríen.[wait:5] Julio aprieta a\n  Gordon contra el pecho.")
        c:text(T("No pasa nada.[wait:5] Thomas también tuvo\ndías malos.[wait:5] Y siempre llegó a la\nestación."), "sad", "julio_lw")
    end,
    carmen = student("carmen", {
        { "* Las cartas me han dicho que hoy no me\n  siente al lado de Andrés.", "neutral" },
        { "* No me han dicho por qué.[wait:5]\n* Pero la carta era muy fea.", "smug" },
    }),
    david = student("david", {
        { "* Estoy componiendo una canción sobre una\n  chica a la que quiero mucho.", "smile" },
        { "* Es Carmen.[wait:5] Obviamente.[wait:5]\n* Es una canción...[wait:5] muy de amigos.", "blush" },
        { T("Muy bisexual todo.[wait:5] Sí señor."), "scared" },
    }),
    xibin = student("xibin", {
        { "* Lucía.[wait:5] Te digo una cosa.", "smug" },
        { "* Diría que hoy hace frío.[wait:10]\n* Pero no lo digo, porque no lo hace.", "closed" },
        { "* La vida es como un gacha:[wait:5] tiras,\n  tiras y tiras...[wait:5] y el 5 estrellas\n  siempre le sale a otro.", "neutral" },
    }),
    fernanda = student("fernanda", {
        { "* Güey, Pablo te está mirando desde hace\n  diez minutos.[wait:5] Qué miedo, la neta.", "surprised" },
    }),
    brayan = student("brayan", {
        { "* Parce, ¿y esa cola?[wait:5] Bacana, ¿eh?", "grin" },
        { T("Hoy le escondo el trencito a Julio\notra vez.[wait:5] Jajaja."), "smug" },
    }),
    pablo = function(c)
        c:text("* Hola, Lucía.[wait:5] ¿Ya me has aceptado la\n  solicitud?", "smug", "pablo_lw")
        c:text("* No.", "neutral", L)
        c:text("* Bueno.[wait:5] Ya lo harás.", "grin", "pablo_lw")
        c:text(T("Hoy se lo digo a Ángel.[wait:5] Hoy sí."), "neutral", "pablo_lw")
    end,
    dayron = function(c)
        c:text("* Lucía.[wait:5] Lucía, ven un momento.", "neutral", "dayron_lw")
        c:text("* ¿Por qué no te quitas eso de la cola y te\n  vistes normal?[wait:5] Como una chica normal.\n* Te lo digo por tu bien.", "smug", "dayron_lw")
        c:text("* ...No, gracias.", "neutral", L)
        c:text("* Ya verás como algún día me das la razón.", "grin", "dayron_lw")
        c:text(T("Una chica se tiene que comportar como\nuna chica.[wait:5] Es lo natural.[wait:5] Es lo que\nhay.[wait:5] Valores de toda la vida."), "neutral", "dayron_lw")
        c:text("* Dayron, cállate la boca.[wait:5]\n* Nadie te ha preguntado, hetero de manual.", "angry", "gabriel_lw")
    end,
    angelpedro = function(c)
        c:text("* Angel Pedro está mirando fijamente una\n  silla.")
        c:text("* ...Lucía.[wait:5] ¿Las sillas tienen alma?", "neutral", "angelpedro_lw")
        c:text("* Dayron dice que sí.[wait:5] Y que hay que\n  romperlas para liberarlas.", "happy", "angelpedro_lw")
        c:text(T("No sé muy bien qué está pasando.[wait:5]\nPero Dayron parece saberlo.[wait:5]\nDayron siempre parece saberlo."), "closed", "angelpedro_lw")
    end,
    andres = function(c)
        c:text("* Hola, Lucía.[wait:5] Qué bien te queda la\n  cola.[wait:5] De verdad.", "smile", "andres_lw")
        c:text("* Si alguien te molesta, avísame.[wait:5]\n* Para eso están los amigos.", "smile", "andres_lw")
        c:text(T("Sonríe.[wait:5] Sonríe.[wait:10]\nQue no se note nada."), "neutral", "andres_lw")
        c:text("* (Andrés juega con unas tijeras debajo\n  de la mesa.[wait:5] Ris, ras.[wait:5] Ris, ras.)")
    end,
    profe = function(c)
        c:text("* Siéntate ya, Lucía.[wait:5] Tu sitio es el de\n  la segunda fila, al lado de Yerover.", "annoyed", "profe_lw")
    end,
    pupitre_vacio = function(c)
        c:text("* Un pupitre vacío.[wait:5] Alguien ha escrito:\n  \"AROY ES EL PUTO AMO\".[wait:5]\n* La letra se parece sospechosamente a la tuya.")
    end,
    pupitre_aridai = function(c)
        c:text("* El pupitre de Aridai.[wait:5] Está lleno de\n  polvo.[wait:5] Aridai no ha venido ni un día.")
        c:text("* Hay una pegatina de Overwatch y un\n  corazón con una \"D\" dentro.")
    end,
    pizarra = function(c)
        c:text("* Alguien ha dibujado un tren con cara en\n  la pizarra.[wait:5] Pone \"CHU CHU\".[wait:5]\n* Firmado: Julio.")
    end,
    mesa_profe = function(c)
        c:text("* La mesa de la profe.[wait:5] Hay exámenes\n  sin corregir y un café frío desde 2019.")
    end,
    no_salir = function(c)
        if PCDM.flag("dia2") then
            c:text("* No puedes irte ahora.[wait:5]\n* El armario...[wait:5] te está llamando.")
        else
            c:text("* La clase va a empezar.[wait:5] Siéntate en tu\n  sitio, al lado de Yerover.")
        end
    end,

    -- ------------------------------------------------------------------ ESCENA PRINCIPAL
    pablo = function(c)
        local p = Game.world.player
        local pablo = c:getCharacter("pablo_lw")
        local angel = c:getCharacter("angel_lw")
        local profe = c:getCharacter("profe_lw")
        c:look(p, "up")
        c:text("* Bueno, chicos.[wait:5] Voy a por fotocopias.\n* Portaos bien.[wait:5] Y nada de móviles.", "neutral", "profe_lw")
        if profe then
            local x, y = pos(1, 11)
            c:wait(c:walkTo(profe, x, profe.y, 0.8))
            c:wait(c:walkTo(profe, x, y, 0.8))
            Assets.playSound("doorclose")
            profe:remove()
        end
        PCDM.setFlag("profe_fuera", true)
        c:wait(0.5)
        c:text("* En cuanto sale la profe, 32 móviles salen\n  de 32 bolsillos.")
        if pablo then
            c:wait(c:walkTo(pablo, pablo.x + 40, pablo.y, 0.3))
            local x, y = pos(3, 8)
            c:wait(c:walkTo(pablo, pablo.x, y, 0.6))
            c:wait(c:walkTo(pablo, x, y, 0.3, "up"))
        end
        c:look(p, "down")
        c:text("* Ey.[wait:5] Furra.", "smug", "pablo_lw")
        c:text("* ...Hola, Pablo.", "neutral", L)
        c:text("* ¿Cuándo vas a dejar de hacer el ridículo con\n  la colita esa?[wait:5] Que pareces un peluche\n  de feria.", "grin", "pablo_lw")
        c:text("* Me gusta mi cola.", "neutral", L)
        c:text("* ¿Sabes lo que te hace falta?[wait:5] Un novio\n  de verdad.[wait:5] No ese twink.", "smug", "pablo_lw")
        c:text("* ¡OYE!", "angry", "yerover_lw")
        c:text("* Dame tu Instagram, anda.[wait:5] Que te sigo.", "blush", "pablo_lw")
        c:text("* No.", "angry", L)
        c:text("* ¿Cómo que no?[wait:5] A mí nadie me dice que no.\n* ...[wait:10]Bueno.[wait:5] Todo el mundo.[wait:5]\n* ¡PERO TÚ NO!", "shout", "pablo_lw")
        local res = UTBattle.run(c, PABLO_LW)
        PCDM.setFlag("pablo_lw_resultado", res)
        c:wait(0.3)
        c:text("* Bah.[wait:5] Tú te lo pierdes.", "sad", "pablo_lw")
        if pablo and angel then
            c:wait(c:walkTo(pablo, angel.x - 40, angel.y + 40, 0.8, "right"))
        end
        c:text("* Y tú, Ángel.", "neutral", "pablo_lw")
        c:text("* ¿Yo?", "surprised", "angel_lw")
        c:shakeCamera(2)
        c:text("* Atrévete.[wait:10]\n* Te, te.[wait:10]\n* Sal del clóset.", "shout", "pablo_lw")
        c:text("* Que se te nota, tío.[wait:5]\n* Atrévete, te, te.[wait:5] Sal del clóset.", "grin", "pablo_lw")
        c:text("* ...Pablo, cariño.[wait:5] Yo ya estoy fuera del\n  clóset.", "smile", "angel_lw")
        c:text("* Soy bisexual.[wait:5] Lo sabe todo el instituto.\n* Lo sabe mi abuela.[wait:5] Lo sabe hasta el\n  perro de mi abuela.", "smug", "angel_lw")
        c:text("* ¡Pues atrévete CONMIGO![wait:5] ¡Te, te!", "blush", "pablo_lw")
        c:text("* No.", "neutral", "angel_lw")
        c:text("* ...", "sad", "pablo_lw")
        c:text("* ......")
        Game.world.music:pause()
        Assets.playSound("pcdm_grillos")
        c:wait(1.6)
        c:shakeCamera(4)
        c:text("* ¡¡¡MOMENTO INCÓMODO!!!", "grin", "xibin_lw")
        Game.world.music:resume()
        c:text("* ¡¡VALE!![wait:5] ¡¡ME VOY AL ARMARIO!![wait:10]\n* ¡¡A PENSAR EN MIS COSAS!!", "crying", "pablo_lw")
        if pablo then
            local x, y = pos(12, 6)
            c:wait(c:walkTo(pablo, x, y, 1.2, "right"))
            Assets.playSound("dooropen")
            local arm = c:getEvents("armario")[1]
            if arm then arm:setOpen(true) end
            c:wait(0.3)
            pablo:remove()
            Assets.playSound("doorclose")
            if arm then arm:setOpen(false) end
        end
        c:shakeCamera(3)
        c:wait(0.6)
        c:text("* Pablo se ha metido en el armario del\n  material.[wait:5] Y ha cerrado por dentro.")
        c:text("* Ojalá no salga nunca.", "smug", "gabriel_lw")
        c:text("* Técnicamente ahora está DENTRO del\n  armario.[wait:5] Qué irónico.", "smug", "alejandro_lw")
        c:text("* Te, te.", "happy", "angel_lw")
        c:text("* ¿Eso duele?[wait:5] ¿Meterse en un armario?", "surprised", "angelpedro_lw")
        c:text(T("Pablo es un pringado...[wait:10]\nPero en el fondo tiene razón con lo de la\nfurra.[wait:5] Alguien tiene que enderezarla."), "smug", "dayron_lw")
        c:text(T(".........[wait:10]\n.........."), "neutral", "andres_lw")
        PCDM.aroy(c, { "Muy bien, muy bien.[wait:5] Todo según el guion.",
            "Lucía no ha cedido.[wait:5] El incel está en el\narmario.[wait:5] Precioso." }, "grin")
        Assets.playSound("bell", 0.8)
        c:text("* ¡RIIIIIIING![wait:5]\n* El timbre del recreo.")
        PCDM.setFlag("aula_hecho", true)
        PCDM.switchPOV(c, { "gabriel" }, "lw/patio", "spawn", "GABRIEL", "El recreo")
        c:text("* (Ahora controlas a Gabriel.)")
    end,

    -- ------------------------------------------------------------------ DÍA 2
    dia2 = function(c)
        local p = Game.world.player
        c:text("* Pablo no ha salido del armario desde ayer.")
        c:text("* La profe está de baja.[wait:5] Dice que por\n  \"ansiedad\".[wait:5] Lleva 3 bajas este\n  trimestre.")
        local crowd = {
            { "gabriel_lw", 11, 7 }, { "yerover_lw", 10, 6 }, { "angel_lw", 9, 7 }, { "alejandro_lw", 9, 8 },
            { "carmen_lw", 12, 9 }, { "david_lw", 13, 9 }, { "xibin_lw", 14, 8 }, { "julio_lw", 10, 9 },
            { "isra_lw", 8, 9 }, { "dayron_lw", 6, 8 }, { "angelpedro_lw", 5, 8 }, { "andres_lw", 7, 10 },
        }
        for _, cr in ipairs(crowd) do
            local x, y = pos(cr[2], cr[3])
            local npc = c:spawnNPC(cr[1], x, y, { facing = "up" })
            npc:setFacing("up")
        end
        c:wait(0.4)
        c:text("* Lleva ahí metido VEINTICUATRO horas.\n* ¿Qué cojones hace?", "annoyed", "gabriel_lw")
        c:text("* Pablo, cariño, ¿estás bien?[wait:5]\n* ...Te, te.", "smile", "angel_lw")
        c:text("* Sale una luz morada por las rendijas.\n* Eso es como un portal de Deltarune.\n* Igualito.", "surprised", "alejandro_lw")
        c:text("* Bro, ES una Fuente Oscura.[wait:5]\n* Es literalmente una Fuente Oscura.\n* Esto es canon.[wait:5] Esto está pasando.", "shout", "gabriel_lw")
        c:text("* Las cartas lo dijeron.[wait:5] La Torre.\n* Caída.[wait:5] Cambio.", "neutral", "carmen_lw")
        c:text("* Diría que me da miedo.[wait:10]\n* Pero no lo digo, porque me da MUCHO miedo.", "surprised", "xibin_lw")
        c:text("* Hic.[wait:5] Yo veo dos armarios.", "closed", "isra_lw")
        c:text("* Seguro que es cosa de los furros.", "smug", "dayron_lw")
        c:text("* ¿Lo rompo?[wait:5] Es de madera.[wait:5] Como las\n  sillas.", "happy", "angelpedro_lw")
        c:text("* Deberíamos abrirlo.[wait:5] Juntos.[wait:5]\n* ...Lucía, tú primero.", "smile", "andres_lw")
        c:text("* ¿Yo?", "scared", L)
        c:text("* Bebé, si entras tú, entro yo detrás.", "blush", "yerover_lw")
        c:text("* (Acércate al armario.)")
    end,
    armario = function(c, ev)
        if PCDM.flag("dia2") then
            c:text("* Del armario sale una luz morada y un\n  ruido raro.[wait:5] Huele a ozono y a Axe.")
            c:text("* ¿Abrir el armario?")
            local ch = c:choicer({ "Abrir", "Todavía no" })
            if ch ~= 1 then return end
            Assets.playSound("dooropen")
            if ev and ev.setOpen then ev:setOpen(true) end
            c:shakeCamera(6)
            c:text("* ¡¡AAAAAAAAAH!!", "scared", L)
            c:text("* ¡El armario os está absorbiendo a todos!")
            PCDM.aroy(c, { "AHORA SÍ.[wait:5] Empieza lo bueno." }, "grin", { keep_music = true })
            Game.world.music:stop()
            local fall = PCDMFall({ "lucia", "yerover", "angel", "gabriel", "isra", "alejandro", "carmen", "julio", "david", "xibin" }, 5)
            Game.stage:addChild(fall)
            c:wait(function() return fall.done end)
            PCDM.setFlag("dia2", false)
            PCDM.setFlag("armario_abierto", false)
            PCDM.setFlag("en_dark_world", true)
            c:gotoCutscene("dw_llanuras.llegada")
        else
            c:text("* El armario del material.[wait:5]\n* Huele a tiza y a secretos.")
            if PCDM.flag("aula_hecho") then
                c:text("* Desde dentro se oye:[wait:5]\n* \"...valeria contesta porfa...\"")
            end
        end
    end,
}
