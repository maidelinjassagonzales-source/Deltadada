-- BOSQUE DE TIJERAS. Grupo B: Gabriel, Isra y Alejandro.
local G, I, AL = "gabriel", "isra", "alejandro"
local T = PCDM.thought

return {
    llegada = function(c)
        local p = Game.world.player
        local fol = Game.world.followers
        c:setSprite(p, "fallen")
        for _, f in ipairs(fol) do c:setSprite(f, "fallen") end
        c:wait(1)
        c:resetSprite(p)
        for _, f in ipairs(fol) do c:resetSprite(f) end
        c:text("* ¿Estáis bien?[wait:5] ¿Isra?[wait:5] ¿Alejandro?", "neutral", G)
        c:text("* Tengo resaca hasta en las orejas.[wait:10]\n* ...¿Por qué tengo orejas de oso?", "surprised", I)
        c:text("* Soy...[wait:10] soy un chacal.[wait:5]\n* Soy JakoSherry.[wait:5] SOY JAKOSHERRY DE VERDAD.", "happy", AL)
        c:text("* Bro.[wait:5] Bro.[wait:10] BRO.[wait:5]\n* Tengo cuernos.[wait:5] Y cola de lagarto.[wait:5]\n* ¡¡SOY COMO SUSIE!!", "shout", G)
        c:text("* ¡¡SOY UN PUTO MONSTRUO!![wait:5]\n* ¡¡EL MEJOR DÍA DE MI VIDA!!", "grin", G)
        c:text("* Esto es el Dark World.[wait:5] Esto es Deltarune\n  de verdad.[wait:5] ¿Habrá un Ralsei?", "blush", AL)
        c:text("* Hic.[wait:5] Yo solo quiero agua.", "sad", I)
        c:text("* Venga, vamos a buscar a Lucía.[wait:5]\n* Si Dayron ha caído aquí también...", "angry", G)
        c:text(T("...no pienso dejar que le haga nada."), "angry", G)
    end,
    vito = function(c)
        local vito = c:getCharacter("vito")
        if not vito then return end
        Assets.playSound("alert")
        c:text("* ¡¡ALTO AHÍ!!", "shout", "vito")
        c:wait(c:walkTo(vito, Game.world.player.x + 80, Game.world.player.y, 0.6, "left"))
        c:text("* Vito Quiles, periodista.[wait:5] Bueno,\n  \"periodista\".[wait:5] Darkner de micrófono.", "grin", "vito")
        c:text("* ¿Ustedes condenan a la furra?[wait:5]\n* ¡CONTESTEN![wait:5] ¡¿CONDENAN O NO CONDENAN?!", "shout", "vito")
        c:text("* ¿Qué cojones es esto?", "surprised", G)
        c:text("* ¡Me están censurando![wait:5] ¡Esto es una\n  dictadura!", "shout", "vito")
        c:text("* Nadie te ha dicho nada, tío.", "annoyed", AL)
        local r, npc = Boss.fight(c, "vito", "vito", "vito")
        PCDM.setFlag("vito_hecho", true)
        if r == "killed" then
            c:text("* Vito Quiles se ha convertido en polvo...[wait:5]\n* y en un micrófono huérfano.")
            Boss.reward(c, "vito")
            c:text("* Bro.[wait:5] Ya no hay más preguntas\n  incómodas.", "grin", G)
            PCDM.goodBoy(c)
        elseif r == "spared" then
            Boss.leave(c, npc, 320, 0, 0.9, false)
            c:text("* Vito se va corriendo a grabar un vídeo\n  para TikTok:[wait:5] \"ME HAN AGREDIDO\".")
            c:text("* Nadie te ha agredido, subnormal.", "annoyed", G)
        end
    end,
    angelpedro = function(c)
        local ap = c:getCharacter("angelpedro")
        if not ap then return end
        c:text("* ¡Angel Pedro![wait:5] ¿Tú también has caído?", "surprised", G)
        c:text("* Hola, Gabriel.[wait:5] Tengo cuernos de toro.\n* ¿Eso es normal?", "happy", "angelpedro")
        c:text("* Dayron me ha dicho que aquí hay muchas\n  sillas.[wait:5] Y que hay que liberarlas todas.", "neutral", "angelpedro")
        c:text("* Y que si veo a Gabriel, que le rompa una\n  silla en la cabeza.[wait:5] Para liberarle.", "grin", "angelpedro")
        c:text("* ¿Dónde está Dayron?", "angry", G)
        c:text("* No sé.[wait:5] Me dijo que tenía que \"hablar\n  con la furra\".", "closed", "angelpedro")
        c:text("* Se acabó.[wait:5] Apártate, Angel Pedro.", "angry", G)
        c:text("* ¿Esto es un combate?[wait:5] Vale.[wait:5]\n* No entiendo nada, pero rompo sillas.", "happy", "angelpedro")
        local r, npc = Boss.fight(c, "angelpedro", "angelpedro", "angelpedro")
        PCDM.setFlag("angelpedro_hecho", true)
        if r == "killed" then
            c:text("* Angel Pedro no entendió nada.[wait:10]\n* Ni siquiera esto.")
            Boss.reward(c, "angelpedro")
            c:text("* ...Era un buen chaval, en el fondo.[wait:5]\n* Muy en el fondo.", "sad", I)
            c:text("* Le estaba usando Dayron.[wait:5] Y se ha ido\n  igual.", "sad", AL)
            PCDM.goodBoy(c, "Uno menos del bando malo.[wait:5] GOOD BOY.")
        elseif r == "spared" then
            c:text("* Gracias, Gabriel.[wait:5] Me voy a sentar en\n  una silla.[wait:5] Sin romperla.[wait:5] Por una vez.", "happy", "angelpedro")
            c:text("* Angel Pedro se sienta en una silla.\n* No la rompe.[wait:5] Es un milagro.")
        end
    end,
    salida = function(c)
        c:text("* Más allá del bosque se ve un plató de\n  televisión enorme con luces.")
        local ch = c:choicer({ "Seguir", "Quedarse" })
        if ch ~= 1 then
            local p = Game.world.player
            c:wait(c:walkTo(p, p.x - 40, p.y, 0.3, "left"))
            return
        end
        PCDM.setFlag("grupoB_hecho", true)
        c:text("* Mientras tanto, en un plató de televisión\n  del Dark World...")
        PCDM.switchPOV(c, { "carmen", "david", "julio" }, "dw/plato_1", "caida", "CARMEN", "Plató del Hormiguero")
        c:gotoCutscene("dw_plato.llegada")
    end,
}
