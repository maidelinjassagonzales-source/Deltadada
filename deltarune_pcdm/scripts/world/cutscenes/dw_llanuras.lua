-- LLANURAS DEL ARMARIO (Dark World). Grupo A: Lucía, Yerover y Ángel.
local L, Y, AN = "lucia", "yerover", "angel"
local T = PCDM.thought

return {
    llegada = function(c)
        PCDM.setParty({ "lucia", "yerover", "angel" })
        c:loadMap("dw/llanuras_1", "caida", "down")
        local p = Game.world.player
        local fol = Game.world.followers
        c:setSprite(p, "fallen")
        for _, f in ipairs(fol) do c:setSprite(f, "fallen") end
        c:wait(c:fadeOut(0.01, { color = { 1, 1, 1 } }))
        c:wait(c:fadeIn(1.5, { color = { 1, 1, 1 } }))
        c:wait(1)
        c:text("* ...")
        c:text("* ¿Dónde...[wait:5] estamos...?", "scared", L)
        c:resetSprite(p)
        for _, f in ipairs(fol) do c:resetSprite(f) end
        c:wait(0.5)
        c:text("* Lucía.[wait:10]\n* Tienes orejas.[wait:5] De zorro.[wait:10] DE VERDAD.", "surprised", Y)
        c:text("* ¿¡QUÉ!?", "surprised", L)
        c:shakeCharacter(p, 4)
        c:text("* (Lucía se toca la cabeza.[wait:5] Las orejas\n  se mueven solas.)")
        c:text("* ¡¡SON DE VERDAD!![wait:5] ¡¡Y TENGO COLA DE\n  VERDAD!![wait:5] ¡¡SE MUEVE!!", "happy", L)
        c:text("* ¡Y yo soy una gatita![wait:5] ¡Zuzu existe![wait:5]\n* ¡SOY ZUZU!", "happy", AN)
        c:text("* Yo tengo orejas de gato también.[wait:5]\n* Le pega a Terry, ¿no?[wait:5] Más o menos.", "grin", Y)
        c:text("* Bebé, estás guapísima.", "blush", Y)
        c:text("* ...Gracias.", "blush", L)
        c:text(T("Aquí...[wait:10] me siento yo.[wait:5]\nPor primera vez en mucho tiempo."), "crying", L)
        c:text("* ¿Y los demás?[wait:5] ¿Y Gabriel, Isra, Carmen...?", "neutral", AN)
        c:text("* Habrán caído en otro sitio.[wait:5] En los juegos\n  siempre pasa eso.", "neutral", Y)
        -- la Percha
        local x, y = 14 * 40 + 20, 7 * 40 + 36
        local percha = c:spawnNPC("percha", 21 * 40, y, { facing = "left" })
        c:wait(c:walkTo(percha, x, y, 1.6, "left"))
        c:text("* ¡HÉROES![wait:5] ¡Por fin habéis llegado!", "happy", "percha")
        c:text("* ¿Y tú qué eres?[wait:5] ¿Una percha?", "surprised", Y)
        c:text("* ¡Soy el Príncipe Percha![wait:5] Guardián de las\n  Llanuras del Armario.[wait:5] Sostengo ropa y\n  esperanzas.", "happy", "percha")
        c:text("* Cuenta la profecía que, cuando alguien se\n  encierra demasiado tiempo en un armario...", "neutral", "percha")
        c:text("* ...se abre una Fuente Oscura.[wait:5]\n* Y el mundo se llena de cosas que nadie se\n  atreve a sacar.", "neutral", "percha")
        c:text("* Y que tres héroes la cerrarán:[wait:10]\n* una zorra con un corazón enorme,", "neutral", "percha")
        c:text("* un gato que grita \"BUSTER WOLF\",[wait:10]\n* y una gata gitana de un metro ochenta y\n  siete.", "neutral", "percha")
        c:text("* ¡¡SOMOS NOSOTROS!!", "happy", AN)
        c:text("* Bro, la profecía es MUY específica.", "surprised", Y)
        c:text("* Las profecías del Dark World las escribe\n  alguien muy raro.[wait:5] Alguien que llora sangre.", "sad", "percha")
        PCDM.aroy(c, { "Bienvenidos a MI Dark World.",
            "Aquí todo el mundo tiene orejitas y cola.\n¿Por qué?[wait:10] PORQUE LO DIGO YO.",
            "Y Percha, no me llames \"alguien raro\",\nque te desmonto." }, "grin")
        c:text("* ...[wait:5]Perdón, Señor.", "sad", "percha")
        c:text("* Antes de seguir, os enseño a luchar.[wait:5]\n* En el Dark World cada uno tiene una MAGIA\n  diferente.", "neutral", "percha")
        c:text("* La magia gasta TP.[wait:5] El TP se gana\n  esquivando ataques por los pelos y\n  defendiéndose.", "neutral", "percha")
        c:text("* Lucía tiene FurryShock...[wait:5] y una técnica\n  prohibida.[wait:10] FURRYGRAVE.[wait:5]\n* Úsala con cabeza.", "surprised", "percha")
        c:text("* Y si no queréis pelear, podéis ACTUAR y\n  PERDONAR.[wait:5] Como en los juegos de Toby\n  Fox.", "happy", "percha")
        c:text("* ¡Mirad![wait:5] ¡Ahí vienen!", "surprised", "percha")
        c:startEncounter("garra_abanico", true)
        c:text("* ¡Muy bien![wait:5] Ya sabéis lo básico.", "happy", "percha")
        c:text("* Os esperaré por aquí.[wait:5] Hablad conmigo\n  si necesitáis consejos.", "neutral", "percha")
        percha:remove()
        PCDM.setFlag("llanuras_intro", true)
        c:loadMap("dw/llanuras_1", p.x, p.y, "down")
    end,
    percha = function(c)
        local tips = {
            "* Los enemigos importantes son más duros.\n* No esperéis tumbarlos en un turno.",
            "* Si un enemigo tiene el nombre en\n  [color:yellow]amarillo[color:reset], podéis PERDONARLO.",
            "* Los del bando malo...[wait:5] si los derrotáis\n  a golpes, no se escapan.[wait:5] Mueren.[wait:5]\n* Y eso os hará más fuertes.",
            "* Dicen que en este mundo hay guaguas\n  GRATIS.[wait:5] Algo de un tal Mamdani.",
            "* En un rincón de estas llanuras brilla\n  algo dorado.[wait:5] Yo que vosotros no lo\n  tocaba.",
        }
        c:text(tips[love.math.random(1, #tips)], "neutral", "percha")
    end,
    mamdani = function(c)
        if not PCDM.flag("guaguas_activas") then
            c:text("* ¡Hola![wait:5] Soy Zohran Mamdani.[wait:5] Alcalde de\n  Nueva York y, al parecer, del transporte\n  público del Dark World.", "smile", "mamdani")
            c:text("* Aquí las Guaguas Global son GRATIS.\n* Para todo el mundo.[wait:5] Furros incluidos.", "happy", "mamdani")
            c:text("* ¿¡GRATIS!?[wait:5] ¡Paco el guagüero estaría\n  orgulloso!", "happy", L)
            c:text("* ¡Becas, ayudas y guaguas gratis![wait:5]\n* ¡Te quiero, Zohran!", "blush", AN)
            c:text("* Cuando hayáis pasado por otras paradas,\n  podréis volver a ellas en un momento.\n* Solo tenéis que subiros.", "grin", "mamdani")
            PCDM.setFlag("guaguas_activas", true)
            PCDM.setFlag("parada_llanuras", true)
            Assets.playSound("pcdm_bocina")
            c:text("* (¡Se han desbloqueado las [color:5ad1ff]Guaguas Global[color:reset]!)")
        else
            c:text("* El transporte público es un derecho.\n* Y lo de las colas furras, también.", "smile", "mamdani")
        end
    end,
    salida = function(c)
        c:text("* Más adelante se ve un bosque lleno de\n  tijeras gigantes.")
        local ch = c:choicer({ "Seguir", "Quedarse" })
        if ch ~= 1 then
            local p = Game.world.player
            c:wait(c:walkTo(p, p.x - 40, p.y, 0.3, "left"))
            return
        end
        PCDM.setFlag("grupoA_llanuras_hecho", true)
        c:text("* Mientras tanto, en otra parte del Dark\n  World...")
        PCDM.switchPOV(c, { "gabriel", "isra", "alejandro" }, "dw/bosque_1", "caida", "GABRIEL", "Bosque de Tijeras")
        c:gotoCutscene("dw_bosque.llegada")
    end,
}
