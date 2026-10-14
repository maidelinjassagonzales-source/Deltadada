-- CORTIJO DE LA RECONQUISTA. Grupo A otra vez: Lucía, Yerover y Ángel.
local L, Y, AN = "lucia", "yerover", "angel"
local T = PCDM.thought

return {
    llegada = function(c)
        c:text("* Hemos salido de las llanuras y...[wait:5]\n* ¿esto qué es?[wait:5] ¿Un cortijo?", "surprised", L)
        c:text("* Hay banderas, toros de cartón y un\n  caballo.[wait:5] Huele a mitin.", "neutral", Y)
        c:text("* Huele a facha, cariño.[wait:5] Huele MUCHO a\n  facha.", "angry", AN)
        PCDM.aroy(c, { "Esta zona la he hecho con todo mi cariño.\nY con todo mi asco.",
            "Aquí hay gente MUY mala.[wait:5] Ya sabéis lo\nque tenéis que hacer.[wait:5] O no.[wait:5] Vosotros\nveréis.[wait:5] (Matadlos.)" }, "smug")
    end,
    sanchez = function(c)
        c:text("* Hola.[wait:5] Soy Pedro Sánchez.[wait:5] Presidente.\n* Del Gobierno.[wait:5] Y de este cortijo, por\n  lo visto.", "smug", "sanchez")
        c:text("* Me han intentado echar de todas partes.\n* No me voy a ir.[wait:5] Manual de Resistencia,\n  capítulo uno.", "smile", "sanchez")
        c:text("* Y vosotros tampoco os vais a ir así de\n  hechos polvo.[wait:5] Venid aquí.", "happy", "sanchez")
        for _, chara in ipairs(Game.party) do
            chara:setHealth(chara:getStat("health"))
        end
        Assets.playSound("power")
        c:text("* (¡El equipo se ha curado del todo!)")
        c:text("* ¡Perro Sanxe![wait:5] ¡Te quiero!", "happy", AN)
        c:text("* Lo sé.", "smug", "sanchez")
    end,
    iglesias = function(c)
        c:text("* ¡Bienvenidos a la Taberna Garibaldi del\n  Dark World![wait:5] Soy Pablo Iglesias.", "smile", "iglesias")
        c:text("* Aquí se sirve ron miel, papas arrugadas y\n  conciencia de clase.", "smug", "iglesias")
        PCDM.shop(c, { { "ron_miel", 30 }, { "papas_arrugadas", 90 }, { "barraquito", 80 }, { "gofio", 100 } },
            "iglesias", "neutral", "* Salud, camaradas.")
    end,
    fernanda = function(c)
        c:text("* ¡Órale![wait:5] ¡Lucía![wait:5] ¡Puse mi taquería en\n  el Dark World, güey!", "happy", "fernanda")
        c:text("* Tacos al pastor de verdad.[wait:5] No esas\n  mamadas de kebab.", "grin", "fernanda")
        PCDM.shop(c, { { "taco_fer", 60 }, { "churros", 35 }, { "monster_oscuro", 50 }, { "arepa", 40 } },
            "fernanda", "happy", "* ¡Provecho, banda!")
    end,
    borja = function(c)
        c:text("* ¡Ey![wait:5] Soy Borja Iglesias.[wait:5] El Panda.", "smile", "borja")
        if not PCDM.flag("regalo_borja") then
            c:text("* Me gusta tu cola.[wait:5] Yo me pinto las uñas\n  y a algunos les escuece.[wait:5] Que les escueza.", "happy", "borja")
            c:text("* Toma.[wait:5] Para que nadie te diga cómo tienes\n  que ser.", "grin", "borja")
            Game.inventory:addItem("esmalte_panda")
            Assets.playSound("item")
            c:text("* (Has recibido el [color:yellow]Esmalte del Panda[color:reset].)")
            PCDM.setFlag("regalo_borja", true)
        else
            c:text("* Las uñas pintadas no te hacen menos\n  hombre.[wait:5] Te hacen más guapo.", "smile", "borja")
        end
    end,
    bellerin = function(c)
        c:text("* Soy Héctor Bellerín.[wait:5] Futbolista, vegano y\n  bastante mejor vestido que tú.", "smug", "bellerin")
        if not PCDM.flag("regalo_bellerin") then
            c:text("* Toma.[wait:5] Bufanda sostenible.[wait:5] Algodón\n  orgánico.[wait:5] Abriga y protege.", "smile", "bellerin")
            Game.inventory:addItem("bufanda_bellerin")
            Assets.playSound("item")
            c:text("* (Has recibido la [color:yellow]Bufanda de Bellerín[color:reset].)")
            PCDM.setFlag("regalo_bellerin", true)
        else
            c:text("* La moda también es política.", "neutral", "bellerin")
        end
    end,
    abascal = function(c)
        local ab = c:getCharacter("abascal")
        if not ab then return end
        Assets.playSound("alert")
        c:text("* ¡¡ALTO!![wait:5] ¡¡AQUÍ NO PASA NADIE SIN\n  PASAR POR LA ADUANA!!", "shout", "abascal")
        c:text("* Santiago Abascal.[wait:5] A caballo.[wait:5] Como\n  siempre.[wait:5] El caballo no ha elegido estar\n  aquí.", "neutral")
        c:text("* ¡Una furra, un twink y un gitano![wait:5]\n* ¡Esto es una invasión!", "angry", "abascal")
        c:text("* Cariño, mi familia lleva aquí desde el\n  siglo XV.[wait:5] Antes que la tuya, seguro.", "smug", AN)
        c:text("* ¡RECONQUISTA![wait:5] ¡A POR ELLOS!", "shout", "abascal")
        local r = Boss.fight(c, "abascal", "abascal", "abascal")
        PCDM.setFlag("abascal_hecho", true)
        if r == "killed" then
            c:text("* Abascal se ha deshecho.[wait:5] El caballo,\n  libre al fin, se aleja trotando.")
            Boss.reward(c, "abascal")
            c:text("* ¡Vuela, caballito![wait:5] ¡Eres libre!", "happy", L)
            PCDM.goodBoy(c)
        elseif r == "spared" then
            c:text("* Abascal se baja del caballo.[wait:5] Por primera\n  vez en años, camina.[wait:5] Se cansa\n  muchísimo.")
        end
    end,
    pablo = function(c)
        local pablo = c:getCharacter("pablo")
        if not pablo then return end
        c:text("* Hola, Lucía.[wait:10]\n* Bienvenida a mi REINO.", "grin", "pablo")
        c:text("* ¿¡Pablo!?", "surprised", L)
        c:text("* Me metí en el armario a pensar en mis\n  cosas.[wait:5] Y pensé tanto...[wait:5] que el armario\n  se abrió.", "smug", "pablo")
        c:text("* Ahora soy el REY DEL ARMARIO.[wait:5]\n* Y tengo orejas de rata.[wait:5] Pero eso da igual.", "shout", "pablo")
        c:text("* Aquí todas las chicas me contestan.[wait:5]\n* Bueno, los bots.[wait:5] Pero me contestan.", "blush", "pablo")
        c:text("* Y tú, Ángel...[wait:10] atrévete.[wait:5] Te, te.[wait:5]\n* Aquí nadie nos ve.", "smug", "pablo")
        c:text("* Pablo, cariño, ya te he dicho que no.\n* No es no.[wait:5] En la Light World y en la Dark.", "angry", AN)
        c:text("* ¡¡SI NO ES POR LAS BUENAS, SERÁ POR LAS\n  MALAS!!", "shout", "pablo")
        c:text("* Pues por las malas.[wait:5] HEY, COME ON.", "angry", Y)
        local r = Boss.fight(c, "pablo", "pablo", "pablo")
        PCDM.setFlag("pablo_hecho", true)
        if r == "killed" then
            c:text("* Pablo se ha convertido en polvo.[wait:10]\n* Su móvil cae al suelo.[wait:5] Le llega una\n  notificación.")
            c:text("* [color:5ad1ff]@valeria_hot_2009[color:reset]:\n  Tu suscripción ha caducado.")
            Boss.reward(c, "pablo")
            c:text("* ...Le di mil oportunidades.", "sad", L)
            PCDM.goodBoy(c, "El incel ya no está.[wait:5] GOOD BOY.")
        elseif r == "spared" then
            c:text("* Pablo se sienta en su trono y abre\n  Instagram.[wait:5] Le ha contestado alguien.")
            c:text("* [color:5ad1ff]@soporte_instagram[color:reset]:\n  Tu cuenta ha sido suspendida por spam.")
            c:text("* ...[wait:10]Vaya.", "crying", "pablo")
        end
        c:text("* Ahora que Pablo ya no está en el trono...\n* La Fuente Oscura empieza a temblar.")
        c:text("* Tenemos que encontrar a los demás.\n* ¡Vamos!", "neutral", L)
    end,
    salida = function(c)
        if not PCDM.flag("pablo_hecho") then
            c:text("* El trono del Rey del Armario corta el\n  paso.[wait:5] Habrá que hablar con el rey.")
            local p = Game.world.player
            c:wait(c:walkTo(p, p.x - 40, p.y, 0.3, "left"))
            return
        end
        c:text("* A lo lejos se ve un muro gigante de\n  ladrillos dorados.[wait:5] Pone \"THE WALL\".")
        local ch = c:choicer({ "Seguir", "Quedarse" })
        if ch ~= 1 then
            local p = Game.world.player
            c:wait(c:walkTo(p, p.x - 40, p.y, 0.3, "left"))
            return
        end
        c:wait(c:fadeOut(0.5))
        c:loadMap("dw/muro_1", "oeste", "right")
        c:wait(c:fadeIn(0.5))
    end,
}
