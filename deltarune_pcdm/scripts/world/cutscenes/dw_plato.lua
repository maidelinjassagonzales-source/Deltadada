-- PLATÓ DEL HORMIGUERO. Grupo C: Carmen, David y Julio (y Xibin).
local C, D, J, X = "carmen", "david", "julio", "xibin"
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
        c:text("* Las cartas lo dijeron.[wait:5] La Torre.[wait:5]\n* Caída.[wait:10] ...Pero no dijeron que me\n  saldrían orejas de gato.", "surprised", C)
        c:text("* Carmen, cariño, estás preciosa.[wait:5]\n* Muy...[wait:5] gata.[wait:5] Como amigo te lo digo.", "blush", D)
        c:text("* Soy tu novia, David.", "neutral", C)
        c:text("* ¡Sí![wait:5] ¡Novia![wait:5] Eso.[wait:5] Bisexualmente.", "scared", D)
        c:text("* Chicos...[wait:10] chicos, mirad.", "surprised", J)
        c:text("* (A Julio le ha salido una chimenea en la\n  cabeza.[wait:5] Echa humo cuando respira.)")
        c:shakeCamera(4)
        Assets.playSound("pcdm_chuchu")
        c:text("* ¡¡SOY UN TREN!![wait:5] ¡¡SOY UN FURRO TREN!!\n* ¡¡THOMAS, ESTOY CONTIGO!!", "happy", J)
        c:text("* ¡CHU CHUUUUUUU!", "grin", J)
        c:text(T("Por fin.[wait:5] Por fin soy lo que siempre\nfui por dentro.[wait:10] Una locomotora."), "crying", J)
    end,
    xibin = function(c)
        if PCDM.flag("xibin_unido") then return end
        c:text("* ¡Bienvenidos a MODAS SHANGHÁI TV![wait:5]\n* El canal número uno del Dark World.", "grin", X)
        c:text("* ¿¡XIBIN!?[wait:5] ¿Qué haces aquí?", "surprised", C)
        c:text("* Caí en el plató.[wait:5] Me pusieron un micro.\n* A los diez minutos ya era el presentador.\n* A los veinte, el dueño de la cadena.", "smug", X)
        c:text("* Diría que es increíble.[wait:10]\n* Pero no lo digo, porque es lo normal.", "closed", X)
        c:text("* ¿Te vienes con nosotros, Xibin?", "happy", J)
        c:text("* Por supuesto.[wait:5] Todo el mundo me quiere.\n* Los buenos, los malos, los Darkners...", "smug", X)
        c:text("* Pero solo caben tres en un combate.[wait:5]\n* Son las normas de Deltarune.", "neutral", C)
        c:text("* Yo me quedo ayudando a Yolanda Díaz con el\n  plató.[wait:5] Tengo que...[wait:5] pensar en cosas.", "blush", D)
        c:text(T("Cosas muy bisexuales.[wait:10]\nSí."), "scared", D)
        PCDM.setParty({ "carmen", "julio", "xibin" })
        local x = c:getCharacter("xibin")
        if x then x:remove() end
        PCDM.setFlag("xibin_unido", true)
        local p = Game.world.player
        c:loadMap("dw/plato_1", p.x, p.y, "down")
        c:text("* (¡Xibin se ha unido al grupo!)")
    end,
    yolanda = function(c)
        c:text("* ¡Hola, cariño![wait:5] Soy Yolanda Díaz.[wait:5]\n* Vengo a SUMAR.", "smile", "yolanda")
        if not PCDM.flag("yolanda_curado") then
            c:text("* Voy a sumaros salud a todos.[wait:5] Y\n  derechos laborales.[wait:5] Y vacaciones.", "happy", "yolanda")
            for _, chara in ipairs(Game.party) do
                chara:setHealth(chara:getStat("health"))
            end
            Assets.playSound("power")
            c:text("* (¡El equipo se ha curado del todo!)")
            PCDM.setFlag("yolanda_curado", true)
        else
            c:text("* Recordad:[wait:5] la jornada laboral en el\n  Dark World es de 37,5 horas.[wait:5] Ni una más.", "smile", "yolanda")
        end
        if PCDM.hasMember("carmen") then
            c:text("* ¿David está contigo?", "neutral", C)
            c:text("* Está por ahí, cariño.[wait:5] Pensativo.[wait:5]\n* Muy pensativo.", "smile", "yolanda")
        end
    end,
    panavi = function(c)
        c:text("* ¡Épale, chamo![wait:5] ¡Qué fino ese tren!", "happy", "panavi")
        c:text("* ¡Soy el Pana Vi, mi pana![wait:5] Aquí estoy\n  resolviendo, tú sabes.", "grin", "panavi")
        if PCDM.hasMember("julio") then
            c:text("* ¡Pana![wait:5] ¡Tú también eres de allá!", "happy", J)
            c:text("* ¡Claro, mi hermano![wait:5] Toma, para el\n  camino, chamo.", "grin", "panavi")
            if not PCDM.flag("panavi_arepas") then
                Game.inventory:addItem("arepa")
                Game.inventory:addItem("arepa")
                Assets.playSound("item")
                c:text("* (Has recibido 2 [color:yellow]Arepas[color:reset].)")
                PCDM.setFlag("panavi_arepas", true)
            end
        end
    end,
    motos = function(c)
        local motos = c:getCharacter("motos")
        if not motos then return end
        c:text("* ¡¡BIENVENIDOS A EL HORMIGUEROOOO!!", "grin", "motos")
        c:text("* Hoy tenemos a unos invitados MUY\n  especiales:[wait:5] ¡una bruja, un tren y\n  el chino de las tiendas!", "grin", "motos")
        c:text("* Empresario.[wait:5] Visionario.[wait:5] Aurafarmer.", "annoyed", X)
        c:text("* ¿Puedo tocarte las orejitas?[wait:10]\n* ¿Y la cola?[wait:10] ¿Y...?", "smug", "motos")
        c:text("* ¡NO!", "angry", C)
        c:text("* Hoy no viene a promocionar ninguna peli,\n  pero viene a PELEAR.[wait:5] ¡TRANCAS!\n* ¡BARRANCAS![wait:5] ¡MÚSICA!", "shout", "motos")
        c:text("* (La música del plató empieza a sonar...\n  ...al revés.[wait:5] Y lentísima.)")
        local r = Boss.fight(c, "motos", "motos", "motos")
        PCDM.setFlag("motos_hecho", true)
        if r == "killed" then
            c:text("* Pablo Motos se ha deshecho como un\n  decorado de cartón.")
            Boss.reward(c, "motos")
            c:text("* ...Se oyen unas vocecitas detrás del\n  escenario:[wait:5] \"¡Pablo!\"[wait:5] \"¡PABLOOO!\"")
            c:text("* Diría que eso ha sonado a venganza.[wait:10]\n* Pero no lo digo...[wait:10] porque lo es.", "surprised", X)
            PCDM.setFlag("hormigas_vienen", true)
            PCDM.goodBoy(c)
        elseif r == "spared" then
            c:text("* Pablo Motos se va a los anuncios.[wait:5]\n* \"Volvemos después de la publicidad\".")
            c:text("* Nunca vuelve.")
        end
    end,
    salida = function(c)
        c:text("* Al fondo del plató hay una puerta que\n  pone \"SALIDA (Reconquista)\".")
        local ch = c:choicer({ "Seguir", "Quedarse" })
        if ch ~= 1 then
            local p = Game.world.player
            c:wait(c:walkTo(p, p.x - 40, p.y, 0.3, "left"))
            return
        end
        PCDM.setFlag("grupoC_hecho", true)
        c:text("* Mientras tanto, Lucía, Yerover y Ángel\n  llegan a un cortijo muy, muy raro...")
        PCDM.switchPOV(c, { "lucia", "yerover", "angel" }, "dw/cortijo_1", "caida", "LUCÍA", "Cortijo de la Reconquista")
        c:gotoCutscene("dw_cortijo.llegada")
    end,
}
