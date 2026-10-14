-- EL PATIO (punto de vista de GABRIEL)
local G = "gabriel_lw"
local T = PCDM.thought

local DAYRON_LW = {
    intro = "* ¡Dayron se pone en medio![wait:5]\n* Huele a colonia de Mercadona.",
    music = "combate_light",
    enemy = {
        name = "Dayron",
        sprite = { "chars/dayron/light/walk/down_1", "chars/dayron/light/walk/down_2", "chars/dayron/light/walk/down_3", "chars/dayron/light/walk/down_4" },
        scale = 4, hp = 60, atk = 3, def = 1, hit_damage = 13, money = 4,
        check = "* Fife heterobásico.[wait:5] Archienemigo de\n  Gabriel.[wait:5] Quiere que Lucía sea \"normal\".",
        flavor = { "* Dayron se ajusta las gafas.", "* Dayron reparte stickers con su cara.", "* Dayron habla de \"valores\".",
            "* Dayron saca pecho.[wait:5] No hay mucho pecho." },
        low_text = "* A Dayron se le empañan las gafas.",
        spareable_text = "* Dayron se ha quedado sin argumentos.",
        dialogue = { "Las chicas normales\nno van con cola.", "Retramonguer.", "Esto lo hago por\nel bien de Lucía.",
            "Valores de toda\nla vida, bro.", "¿Susie? ¿La lagarta?" },
        acts = {
            { name = "Defender a Lucía", mercy = 35, text = { "* Gabriel se pone delante de Lucía.", "* \"Lucía es como le da la gana ser.[wait:5]\n  ¿Te enteras, fife?\"" } },
            { name = "Hablar de Susie", mercy = 20, text = { "* Gabriel habla de Susie durante 20 minutos.", "* Dayron no entiende nada.[wait:5] Bosteza." } },
            { name = "Llamarle fife", mercy = 30, text = { "* \"Eres un fife heterobásico, Dayron.\"", "* Dayron se ofende muchísimo.[wait:5]\n* No sabe qué significa \"fife\"." } },
            { name = "Rude Buster", mercy = 15, text = { "* Gabriel hace el gesto del Rude Buster.", "* No pasa nada.[wait:5] Estamos en el Light World.[wait:5]\n* Qué vergüenza." } },
        },
        waves = { "stickers", "palabras", "lluvia" },
        bullet_words = { "NORMAL", "VALORES", "TRADICION", "FURRO", "RETRA", "UNA CHICA" },
        bullet_sprites = { "sticker" },
        spare_text = { "* Gabriel deja que Dayron se vaya.", "* \"Esto no se ha acabado, retramonguer.\"" },
        defeat_text = { "* Dayron se retira a ajustarse las gafas." },
    },
    player = nil,
}

local SILLA_LW = {
    intro = "* El alma de la silla flota delante de ti.\n* Llora serrín.",
    music = "combate_light",
    enemy = {
        name = "Alma de Silla",
        sprite = { "enemies/silla/idle_1", "enemies/silla/idle_2" },
        scale = 3, hp = 30, atk = 2, def = 0, hit_damage = 10, money = 1,
        check = "* La recién liberada alma de una silla.\n* Solo quería que alguien se sentara.",
        flavor = { "* El Alma de Silla cruje.", "* Huele a pupitre y a tragedia.", "* El Alma de Silla te mira con un respaldo\n  muy triste." },
        dialogue = { "¿Por qué me\nrompió...?", "Cric...", "Yo era una buena\nsilla..." },
        acts = {
            { name = "Consolar", mercy = 50, text = { "* Gabriel le da una palmadita a la silla.", "* \"Ya está, ya está.[wait:5] No eras tú.\"" } },
            { name = "Sentarse", mercy = 60, text = { "* Gabriel se sienta con cuidado.", "* El alma llora de felicidad.[wait:5]\n* ¡Por fin alguien la usa!" } },
        },
        waves = { "lluvia", "lateral" },
        bullet_sprites = { "pata_silla" },
        spare_text = { "* El Alma de Silla se va volando...", "* ...hacia la ventana del aula 2ºB." },
        defeat_text = { "* El Alma de Silla se va volando, dolida." },
    },
}

return {
    lucia = function(c)
        c:text("* Gabriel, gracias por lo de antes.", "smile", "lucia_lw")
        c:text("* Bro, ni las gracias.[wait:5] Para eso estamos.", "grin", G)
    end,
    yerover = function(c)
        c:text("* ¡Gabriel![wait:5] Mira:[wait:5] salto, Power Wave,\n  Burn Knuckle y lo cancelo en Buster Wolf.", "grin", "yerover_lw")
        c:text("* ¡ARE YOU OKAY?![wait:5] ¡¡BUSTER WOLF!!", "happy", "yerover_lw")
        c:text("* Bro, Susie le daría una paliza a Terry.", "smug", G)
        c:text("* Susie no está en Smash.", "neutral", "yerover_lw")
        c:text("* TODAVÍA.", "shout", G)
    end,
    angel = function(c)
        c:text("* Hoy en el Obelisco hemos hablado de la\n  plusvalía.[wait:5] Y de la nacionalización de\n  la banca.", "smug", "angel_lw")
        c:text("* Y de que los árabes son lo más.[wait:5]\n* Bueno, eso lo he dicho yo, pero todos han\n  asentido.", "happy", "angel_lw")
        c:text(T("Zuzu y yo vamos a cambiar el mundo.\nCon becas.[wait:5] Muchas becas."), "blush", "angel_lw")
    end,
    alejandro = function(c)
        c:text("* Ángel, que yo estoy hablando de Kralsei.", "smug", "alejandro_lw")
        c:text("* Gabriel, tú eres de los míos.[wait:5]\n* ¿Kris y Ralsei?[wait:5] ¿Canon o no canon?", "smug", "alejandro_lw")
        c:text("* Bro, yo soy de Susie.[wait:5] Susie y Kris.\n* Susie y quien sea.[wait:5] Susie y yo.", "blush", G)
        c:text("* Hereje.", "angry", "alejandro_lw")
    end,
    isra = function(c)
        c:text("* Isra está tumbado en el banco con unas\n  gafas de sol.[wait:5] Son las 11 de la mañana.")
        c:text("* Gabriel...[wait:5] no grites...[wait:5] hic...\n* Desde las Fiestas del Pino no soy persona.", "closed", "isra_lw")
        c:text("* Bro, eso fue hace dos semanas.", "surprised", G)
        c:text("* Y todavía me duele el alma.", "sad", "isra_lw")
    end,
    julio = function(c)
        c:text("* Brayan me ha vuelto a esconder a Gordon.\n* Esta vez en el cuarto del conserje.", "sad", "julio_lw")
        c:text("* Bro, luego te ayudo a buscarlo.", "neutral", G)
        c:text("* ¡Gracias, Gabriel![wait:5] ¡Chu chu!", "happy", "julio_lw")
    end,
    dayron_npc = function(c)
        c:text("* ¿Qué miras, retramonguer?", "smug", "dayron_lw")
    end,
    angelpedro = function(c)
        c:text("* Las sillas...[wait:5] tienen alma.[wait:5]\n* Me lo ha dicho Dayron.", "neutral", "angelpedro_lw")
    end,
    sillas = function(c)
        c:text("* Una pila de sillas del instituto.[wait:5]\n* Algunas tienen la pata rota.[wait:5] Sospechoso.")
    end,
    dayron = function(c)
        local dayron = c:getCharacter("dayron_lw")
        local lucia = c:getCharacter("lucia_lw")
        local p = Game.world.player
        if dayron and lucia then
            c:wait(c:walkTo(dayron, lucia.x + 40, lucia.y + 40, 0.8, "up"))
        end
        c:text("* Lucía, en serio.[wait:5] Déjate de furros, de\n  animes y de tonterías.", "smug", "dayron_lw")
        c:text("* Las chicas normales no hacen eso.", "neutral", "dayron_lw")
        c:text("* Yo no soy una chica normal, Dayron.", "angry", "lucia_lw")
        c:text(T("Ni siquiera sé si soy una chica."), "sad", "lucia_lw")
        c:text("* Por eso mismo.[wait:5] Yo te ayudo a ser\n  normal.[wait:5] De nada.", "grin", "dayron_lw")
        c:wait(c:walkTo(p, dayron.x + 60, dayron.y, 0.6, "left"))
        c:text("* Dayron.[wait:5] Déjala en paz o te reviento.", "angry", G)
        c:text("* ¿Tú qué, el retramonguer?[wait:5]\n* ¿Vas a defenderla con tus dibujitos de la\n  lagarta morada?", "smug", "dayron_lw")
        c:shakeCamera(4)
        c:text("* SUSIE.[wait:5] NO.[wait:5] ES.[wait:5] UNA.[wait:5] LAGARTA.", "shout", G)
        c:text("* ...[wait:5]Bueno, sí es una lagarta.[wait:10]\n* ¡PERO ES LA REINA!", "angry", G)
        local res = UTBattle.run(c, DAYRON_LW)
        c:text("* Esto no se ha acabado, retramonguer.[wait:5]\n* Ya verás.", "angry", "dayron_lw")
        if dayron then
            c:wait(c:walkTo(dayron, dayron.x, 13 * 40, 1, "down"))
            dayron:remove()
        end
        PCDM.setFlag("patio_dayron", true)
        PCDM.goodBoy(c, "Eso es, Gabriel.[wait:5] Defiende a la\nprotagonista.[wait:5] GOOD BOY.")
        c:text("* ...¿Quién ha dicho eso?", "surprised", G)
        c:text("* Lucía, ¿estás bien?", "neutral", G)
        c:text("* Sí...[wait:5] Gracias, Gabriel.[wait:5] De verdad.", "smile", "lucia_lw")
    end,
    silla = function(c)
        if not PCDM.flag("patio_dayron") or PCDM.flag("patio_silla") then return end
        local ap = c:getCharacter("angelpedro_lw")
        c:text("* Angel Pedro levanta una silla por encima\n  de la cabeza...")
        Assets.playSound("pcdm_silla")
        c:shakeCamera(8)
        c:text("* ¡CRAAAACK!")
        c:text("* La silla se ha roto en mil pedazos.")
        c:text("* ¡La he liberado![wait:5] ¿No?[wait:5] ¿La he liberado?", "happy", "angelpedro_lw")
        c:text("* Algo sale de entre las astillas...[wait:5]\n* ...¿un alma?")
        UTBattle.run(c, SILLA_LW)
        c:text("* Angel Pedro, tú no has liberado nada.\n* Tú has roto una silla del instituto.", "annoyed", G)
        c:text("* ...Ah.", "sad", "angelpedro_lw")
        c:text("* Dayron dice que...", "neutral", "angelpedro_lw")
        c:text("* Bro, Dayron no tiene ni puta idea de nada.", "angry", G)
        c:text(T("Dayron me ha elegido a mí para esto.\nComo mis padres, que me adoptaron.\nA mí siempre me eligen."), "happy", "angelpedro_lw")
        PCDM.setFlag("patio_silla", true)
        if ap then ap:remove() end
        c:wait(0.5)
        c:text("* Gabriel nota algo raro.[wait:5]\n* Por la ventana del aula 2ºB sale una luz\n  morada.")
        c:text("* ¿Qué cojones...?", "surprised", G)
        c:text("* ¿Eso es...[wait:5] lo que creo que es?", "grin", G)
        PCDM.aroy(c, { "Sí.[wait:5] Es lo que crees que es.",
            "Pero no te emociones.[wait:5] Primero tenemos que ver\nqué hace OTRO personaje.",
            "Uno que...[wait:5] bueno.[wait:5] Ya lo verás." }, "smug")
        PCDM.switchPOV(c, { "andres" }, "lw/casa_andres", "spawn", "ANDRÉS", "Esa misma tarde")
        c:gotoCutscene("lw_andres.entrar")
    end,
}
