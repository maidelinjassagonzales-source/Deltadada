-- HABITACIÓN DE LUCÍA
local L = "lucia_lw"

return {
    despertar = function(c)
        local p = Game.world.player
        p.visible = true
        c:setSprite(p, "fallen")
        c:wait(0.8)
        c:text("* Es lunes.[wait:10]\n* Otra vez.")
        c:resetSprite(p)
        c:look(p, "down")
        c:text("* ¡Buenos días, mundo![wait:5]\n* ¡Buenos días, Mandarina!", "happy", L)
        Assets.playSound("phone", 0.6)
        c:text("* Tu móvil vibra.[wait:5] Son mensajes de Yerover.")
        c:text("* [color:ffd23f]Yerover[color:reset]: buenos días bebé :3")
        c:text("* [color:ffd23f]Yerover[color:reset]: hoy en el recreo te enseño\n  el combo nuevo de Terry")
        c:text("* [color:ffd23f]Yerover[color:reset]: ARE YOU OKAY????\n  BUSTER WOLF!!!!!")
        c:text(PCDM.thought("Le quiero muchísimo.[wait:5]\nPero no entiendo nada de lo que dice."), "smile", L)
        c:text("* (Usa las flechas para moverte y Z para hablar e investigar.)")
        PCDM.setFlag("lucia_despierta", true)
    end,
    espejo = function(c)
        c:text("* Te miras al espejo.")
        c:text("* ...", "neutral", L)
        c:text(PCDM.thought("Hay días en que el espejo me devuelve a\nalguien que no soy yo."), "sad", L)
        c:text(PCDM.thought("Algún día.[wait:10]\nAlgún día me veré como me siento."), "sad", L)
        c:text(PCDM.thought("...[wait:5]Bueno.[wait:5] Al menos el pelo hoy\nestá genial."), "smile", L)
    end,
    cama = function(c)
        c:text("* Tu cama.[wait:5] Hay un peluche de zorro y\n  una almohada con un personaje de anime.")
        c:text("* ¡No juzgues a Senpai-kun![wait:5]\n* ¡Es muy importante para mí!", "blush", L)
    end,
    armario = function(c)
        c:text("* Tu armario.[wait:5] Hay sudaderas moradas, una\n  cola de zorro de repuesto y un binder.")
        c:text(PCDM.thought("Hoy llevo la cola puesta.[wait:5]\nObviamente."), "happy", L)
    end,
    mandarina = function(c)
        c:text("* Tu cabeza de fursuit.[wait:5] Se llama Mandarina.\n* Es un zorro naranja precioso.")
        c:text("* Hoy no puedo llevarte a clase, Mandarina.\n* La última vez la profe te confiscó dos\n  semanas.", "sad", L)
        c:text("* Mandarina te mira con sus ojos de felpa.[wait:5]\n* Lo entiende.")
    end,
    pc = function(c)
        c:text("* Tu ordenador.[wait:5] Tienes 34 pestañas abiertas.")
        c:text("* 30 son de fanart.[wait:5] 3 son de una wiki\n  de anime.[wait:5] 1 son deberes que no has hecho.")
        c:text("* ¡Los haré en el recreo!", "smile", L)
    end,
    poster = function(c)
        local opts = {
            "* Un póster de un anime que nadie de tu clase\n  ha visto.[wait:5] Es una OBRA MAESTRA.",
            "* Un póster de un zorro con armadura.\n  Lo dibujó un artista de Twitter con 200\n  seguidores.[wait:5] Le pagaste 40 euros.",
            "* Un póster de una convención furra.\n  Fuiste el año pasado.[wait:5] Fue el mejor día\n  de tu vida.",
        }
        c:text(opts[love.math.random(1, #opts)])
    end,
    estanteria = function(c)
        c:text("* Mangas, figuras y un libro de matemáticas\n  que no has abierto desde septiembre.")
    end,
    no_salir = function(c)
        c:text("* Todavía no.")
    end,
}
