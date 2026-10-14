-- FIESTAS DEL PINO (Teror). Recuerdo de Isra. Hic.
local I = "isra_lw"
local T = PCDM.thought

local function borrachera(n)
    -- la cámara se tambalea según los chupitos
    if Game.world and Game.world.camera then
        Game.world.pcdm_mareo = n
    end
end

return {
    llegada = function(c)
        c:text("* La plaza de Teror está llena de gente.\n* Huele a churros, a ron miel y a feria.")
        c:text("* ¡Las Fiestas del Pino![wait:5] ¡Lo mejor del año!", "happy", I)
        c:text(T("Antes yo era otaku, ¿sabes?[wait:5] Lo dejé.\nAhora tengo vicios más sanos."), "grin", I)
        c:text("* (Puedes beber en el puesto de ron miel.\n  Bajo tu propia responsabilidad.)")
        PCDM.setFlag("chupitos", 0)
    end,
    ventorrillera = function(c)
        c:text("* ¡Mi niño![wait:5] ¿Otro ronmiel?[wait:5]\n* El primero es para el cuerpo, el segundo\n  es para el alma.", "happy", "candelaria_lw")
    end,
    ron = function(c)
        local n = PCDM.flag("chupitos", 0)
        if n >= 5 then
            c:text("* ¡Ya no te pongo más, mi niño!", "angry", "candelaria_lw")
            return
        end
        local ch = c:choicer({ "Pedir un ron miel", "Agua" })
        if ch == 2 then
            c:text("* ¿Agua?[wait:5] ¿En el Pino?[wait:10]\n* Chacho, ¿estás malo?", "surprised", "candelaria_lw")
            return
        end
        n = n + 1
        PCDM.setFlag("chupitos", n)
        Assets.playSound("pcdm_trago")
        borrachera(n)
        local lines = {
            "* Glu, glu.[wait:5] ¡Aaaah![wait:5] Qué rico.",
            "* El segundo entra mejor.[wait:5] Hic.",
            "* Te sientes muy, muy bien.[wait:5]\n* Todo da vueltas.[wait:5] Pero bien.",
            "* ¿Por qué hay dos ventorrilleras?[wait:5]\n* Hic.[wait:5] Hola a las dos.",
            "* ...[wait:10]Algo despierta dentro de ti.",
        }
        c:text(lines[n])
        if n >= 5 then
            c:gotoCutscene("lw_pino.capitan")
        end
    end,
    capitan = function(c)
        local p = Game.world.player
        c:shakeCamera(6)
        Assets.playSound("tensionhorn")
        c:text("* ¡¡SOY EL CAPITÁN ISRAEL!!", "angry", I)
        c:text("* ¡¡PROTECTOR DE LAS CALLES DE TEL AVIV!!\n* ¡¡AZOTE DE LOS VILLANOS!!\n* ¡¡HIC!!", "grin", I)
        c:text("* Isra, cariño, estamos en Teror.", "smile", "angel_lw")
        c:text("* ¡¡Y TERROR VAN A SENTIR LOS MALOS!!", "angry", I)
        c:text("* Eso ha sido un chiste muy malo.", "smug", "alejandro_lw")
        c:text("* Diría que está borracho.[wait:10]\n* Pero no lo digo, porque es OBVIO.", "smug", "xibin_lw")
        c:text("* ¡El Capitán Israel protegerá a Lucía de\n  todos los fachas del mundo![wait:5]\n* ¡¡LO JURO POR LA VIRGEN DEL PI--", "angry", I)
        c:wait(0.3)
        c:setSprite(p, "fallen")
        Assets.playSound("bump")
        c:shakeCamera(4)
        c:text("* Isra se ha desmayado.[wait:10]\n* Otra vez.")
        c:text("* ¡Chu chu![wait:5] ¡Ambulancia!", "surprised", "julio_lw")
        Game.world.pcdm_mareo = 0
        PCDM.aroy(c, { "Bueno.[wait:5] Ya sabéis por qué Isra está así.",
            "Ahora volvemos al presente.[wait:5]\nAl día siguiente de lo del armario.",
            "Que ya va siendo hora de que empiece el\nDark World, joder.[wait:5] Que me aburro." }, "smug")
        PCDM.setFlag("dia2", true)
        PCDM.setFlag("armario_abierto", false)
        PCDM.switchPOV(c, { "lucia" }, "lw/aula", "spawn", "LUCÍA", "Al día siguiente...", "up")
        c:gotoCutscene("lw_aula.dia2")
    end,
    churros = function(c)
        c:text("* Churros con chocolate.[wait:5] Los mejores del\n  mundo.[wait:5] No tienes dinero.[wait:5] Te lo has\n  gastado en ron.")
    end,
    basilica = function(c)
        c:text("* La Basílica del Pino.[wait:5] Hay una cola\n  enorme de romeros.")
        c:text(T("Perdón, Virgencita.[wait:5] Hoy me porto\nmal.[wait:5] Mañana también."), "closed", I)
    end,
    verbena = function(c)
        c:text("* En el escenario hay una orquesta tocando\n  reguetón con timple.[wait:5]\n* Es horrible.[wait:5] Es precioso.")
    end,
    angel = function(c)
        c:text("* ¡Isra, no bebas tanto, cariño!", "smile", "angel_lw")
        c:text("* Que luego te pones a hablar de Tel Aviv y\n  nadie te entiende.", "smug", "angel_lw")
    end,
    alejandro = function(c)
        c:text("* La orquesta debería tocar Tally Hall.\n* \"Ruler of Everything\" con timple.\n* Imagínatelo.", "smug", "alejandro_lw")
    end,
    julio = function(c)
        c:text("* ¡Hay un trenecito turístico![wait:5] ¡¡Me voy a\n  montar diez veces!!", "happy", "julio_lw")
    end,
    xibin = function(c)
        c:text("* Isra.[wait:5] Compra una camiseta de \"Yo\n  sobreviví al Pino\".[wait:5] Solo 3 euros.\n* Modas Shanghái.", "smug", "xibin_lw")
        c:text("* No tengo dinero.[wait:5] Me lo he gastado en ron.", "sad", I)
        c:text("* Diría que eso es un problema.[wait:10]\n* Pero no lo digo, porque es TU problema.", "closed", "xibin_lw")
    end,
    brayan = function(c)
        c:text("* ¡Parce, esta fiesta está muy bacana!\n* ¡Pero el ron es fuertísimo, ojo!", "grin", "brayan_lw")
    end,
}
