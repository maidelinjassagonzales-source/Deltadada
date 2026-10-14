-- RUTA FURRYGRAVE (la ruta "snowgrave" de este mod).
-- Controlas a DAYRON. Convences a Lucía de dejar de ser furra. Y luego...
local D, L = "dayron", "lucia"
local T = PCDM.thought

local function milaEsGod(c)
    c:choicer({ "MILA ES GOD" }, { color = { 0.7, 0.7, 0.75 }, highlight = { 1, 1, 1 } })
end

local function victimScene(c, encounter, ids, pleas)
    for _, pl in ipairs(pleas) do
        c:text(pl[1], pl[2], pl[3])
    end
    c:startEncounter(encounter, true)
    for _, id in ipairs(ids) do
        PCDM.setFlag("sg_muerto_" .. id, true)
    end
    c:text("* ...")
    milaEsGod(c)
end

local function badScene(c, encounter, ids, lines)
    for _, l in ipairs(lines) do c:text(l[1], l[2], l[3]) end
    c:startEncounter(encounter, true)
    for _, id in ipairs(ids) do PCDM.kill(id) end
    c:text("* El bando malo también estorba.")
    milaEsGod(c)
end

return {
    -- El sticker dorado escondido en las Llanuras del Armario
    sticker = function(c, ev)
        c:text("* Un sticker dorado con la cara de Dayron.\n* Brilla de una forma muy rara.")
        local ch = c:choicer({ "Pegártelo en la frente", "Dejarlo" })
        if ch ~= 1 then return end
        PCDM.aroy(c, { "Eh.[wait:5] EH.[wait:10]\nNi se te ocurra.", "Ese sticker cambia el guion.[wait:5]\nDéjalo donde estaba." }, "angry")
        ch = c:choicer({ "Pegártelo en la frente", "Dejarlo" })
        if ch ~= 1 then
            PCDM.goodBoy(c, "Eso.[wait:5] Muy bien.[wait:5] GOOD BOY.")
            return
        end
        PCDM.aroy(c, { "TE LO ESTOY DICIENDO EN SERIO.",
            "Si te pones eso, dejas de controlar a\nLucía.[wait:5] Controlarás a DAYRON.[wait:5]\nY no hay vuelta atrás." }, "shout")
        c:text("* ¿Seguro?[wait:10] No hay vuelta atrás.")
        ch = c:choicer({ "Pegártelo", "No" })
        if ch ~= 1 then
            PCDM.goodBoy(c, "Uf.[wait:5] Qué susto.[wait:5] GOOD BOY.")
            return
        end
        Assets.playSound("pcdm_glitch")
        Game.stage:addChild(PCDMGlitch(2))
        c:shakeCamera(10)
        PCDM.aroy(c, { "NO.[wait:5] NO NO NO NO NO." }, "shout")
        PCDM.setFlag("sticker_cogido", true)
        PCDM.setFlag("ruta_furrygrave", true)
        if ev then ev:remove() end
        Game.world.music:stop()
        PCDM.switchPOV(c, { "dayron" }, "dw/sg_camino", "spawn", "DAYRON", "Los valores de toda la vida.", "right")
        c:gotoCutscene("furrygrave.convencer")
    end,

    convencer = function(c)
        local p = Game.world.player
        local x, y = p.x + 160, p.y
        local lu = c:spawnNPC("lucia", x, y, { facing = "left" })
        c:text("* Las llanuras están muy silenciosas.[wait:5]\n* Demasiado silenciosas.")
        c:text("* Lucía está sola.[wait:5] Yerover y Ángel han ido\n  a buscar agua.")
        c:text("* ¿Dayron?[wait:5] ¿Qué haces aquí?", "surprised", L)
        c:text("* Lucía.[wait:5] Escúchame un momento.", "neutral", D)
        local args = {
            { "Esto no es real", "* Esto no es real, Lucía.[wait:5] Las orejas, la cola...\n* Cuando volvamos, se acabó.[wait:5] Mejor dejarlo ya." },
            { "La gente se ríe", "* La gente se ríe de ti.[wait:5] En clase, en el grupo...\n* Yo solo quiero que no te hagan daño." },
            { "Sé normal", "* Sé normal, Lucía.[wait:5] Como las demás.\n* Así nadie te va a señalar nunca más." },
        }
        local ans = {
            "* ...[wait:10]Pero aquí me siento yo.",
            "* ...¿Se ríen de mí?",
            "* ...[wait:10]Normal.",
        }
        for i, a in ipairs(args) do
            local ch = c:choicer({ a[1] })
            c:text(a[2], "neutral", D)
            c:text(ans[i], i == 3 and "crying" or "sad", L)
        end
        PCDM.aroy(c, { "LUCÍA, NO LE ESCUCHES.[wait:5] ¡NO LE ESCUCHES!" }, "shout")
        c:text("* ...[wait:20]Vale.", "crying", L)
        c:text("* (Lucía se pone una gorra para esconder las\n  orejas.[wait:5] Mete la cola dentro del pantalón.)")
        local lucia = Game:getPartyMember("lucia")
        lucia:setActor("lucia_sg")
        lu:remove()
        PCDM.setParty({ "dayron", "lucia" })
        PCDM.reloadMap(c, "right")
        c:text("* Así mejor.[wait:5] Ahora eres una chica normal.", "grin", D)
        c:text("* ...", "sad", L)
        c:text("* Venga.[wait:5] Vamos a sacar a todos de aquí.[wait:5]\n* Les guste o no.", "smug", D)
        c:text("* (Lucía se ha unido al equipo.[wait:5]\n  Ya no sonríe.)")
    end,

    tramo1 = function(c)
        victimScene(c, "sg_yerover", { "yerover" }, {
            { "* ¡Bebé![wait:5] ¡Te estaba buscando!", "happy", "yerover" },
            { "* ...¿Y esa gorra?[wait:5] ¿Y por qué vas con Dayron?", "surprised", "yerover" },
            { "* Quítate de en medio, twink.", "smug", D },
        })
    end,
    tramo2 = function(c)
        badScene(c, "sg_malos1", { "pablo", "angelpedro" }, {
            { "* ¡Dayron![wait:5] ¡Tío![wait:5] ¿Por fin has enderezado a\n  la furra?", "grin", "pablo" },
            { "* ¿Rompemos sillas juntos?", "happy", "angelpedro" },
            { "* Estorbáis.", "neutral", D },
        })
    end,
    tramo3 = function(c)
        victimScene(c, "sg_angel_alejandro", { "angel", "alejandro" }, {
            { "* ¡Lucía![wait:5] Cariño, ¿qué te ha hecho?", "sad", "angel" },
            { "* Lucía...[wait:5] esto no es Kralsei.[wait:5] Esto es...\n  esto está mal.", "sad", "alejandro" },
        })
    end,
    tramo4 = function(c)
        badScene(c, "sg_malos2", { "vito", "motos", "abascal" }, {
            { "* ¡Dayron![wait:5] ¿Condena usted a la furra?", "grin", "vito" },
            { "* ¡Un invitado especial!", "grin", "motos" },
            { "* ¡Por fin un hombre de verdad!", "smug", "abascal" },
            { "* Callaos.", "neutral", D },
        })
    end,
    tramo5 = function(c)
        victimScene(c, "sg_isra_julio", { "isra", "julio" }, {
            { "* ¡El Capitán Israel no va a dejar que te la\n  lleves, Dayron!", "angry", "isra" },
            { "* Lucía...[wait:5] chu...[wait:5] chu...", "crying", "julio" },
        })
    end,
    tramo6 = function(c)
        badScene(c, "sg_malos3", { "trump", "netanyahu", "hormigas" }, {
            { "* ¡Gran trabajo, Dayron![wait:5] ¡Tremendo!", "smug", "trump" },
            { "* Muy bien hecho, chico.", "smug", "netanyahu" },
            { "* (Detrás de ellos, dos hormigas te miran.)" },
            { "* No necesito aplausos.", "neutral", D },
        })
    end,
    fin_camino = function(c)
        victimScene(c, "sg_carmen_david_xibin", { "carmen", "david", "xibin" }, {
            { "* Las cartas lo dijeron.[wait:5] La Muerte.[wait:5]\n* Pero no era para Xibin.", "sad", "carmen" },
            { "* Lucía, por favor...", "scared", "david" },
            { "* Diría que tengo miedo.[wait:20]\n* Y lo digo.", "sad", "xibin" },
        })
        c:text("* Solo queda uno.", "smug", D)
        PCDM.switchPOV(c, { "dayron", "lucia" }, "dw/sg_cumbre", "spawn", "LA CUMBRE", nil, "up")
    end,

    gabriel = function(c)
        local g = c:getCharacter("gabriel")
        c:text("* Lucía.", "angry", "gabriel")
        c:text("* Lo he visto todo.[wait:5] Yerover.[wait:5] Ángel.\n* Alejandro.[wait:5] Isra.[wait:5] Julio.[wait:5] Carmen.\n* David.[wait:5] Xibin.", "sad", "gabriel")
        c:text("* ...", "crying", L)
        c:text("* Dayron.[wait:5] No sé qué le has dicho.\n* Pero no pienso dejar que te la lleves.", "angry", "gabriel")
        c:text("* Apártate, retramonguer.", "smug", D)
        c:text("* Susie nunca se rendiría.[wait:10]\n* Así que yo tampoco.", "shout", "gabriel")
        c:text("* Ni aunque me cueste la vida.", "angry", "gabriel")
        c:startEncounter("sg_gabriel", true, g)
        if g then g:remove() end
        c:text("* Gabriel está en el suelo.")
        c:text("* Lucía...[wait:10] la Susie de verdad...[wait:10]\n* ...nunca se rendiría...", "sad", "gabriel")
        c:text("* Y yo...[wait:20] tampoco...[wait:20] me he...", "sad", "gabriel")
        c:text("* ...")
        c:text("* Gabriel ha muerto como un héroe.[wait:10]\n* Luchando hasta el final.")
        PCDM.setFlag("sg_muerto_gabriel", true)
        c:wait(1)
        milaEsGod(c)
        c:gotoCutscene("furrygrave.aroy")
    end,

    aroy = function(c)
        Game.stage:addChild(PCDMGlitch(2.5))
        Assets.playSound("pcdm_glitch")
        c:shakeCamera(12)
        PCDM.aroy(c, { "¿QUÉ COÑO HAS HECHO?",
            "¡¡MI HISTORIA!![wait:5] ¡¡MIS PERSONAJES!![wait:5]\n¡¡LUCÍA YA NO ES FURRA!!",
            "Tenía que haberte borrado el primer día.\nTe lo dije.[wait:5] TE LO DIJE.",
            "¿Sabes qué?[wait:5] Todas las almas del bando malo\nque has matado...[wait:10] me las he quedado yo.",
            "Y con ellas voy a BORRARTE." }, "shout")
        PCDM.switchPOV(c, { "dayron", "lucia" }, "dw/sg_vacio", "spawn", nil)
        c:startEncounter("aroy_omega", true)
        c:text("* La pantalla de Aroy.exe se apaga.")
        c:text("* Las almas del bando malo te miran.[wait:5]\n* Y luego se van flotando hacia algún sitio.")
        c:gotoCutscene("finales.furrygrave")
    end,
}
