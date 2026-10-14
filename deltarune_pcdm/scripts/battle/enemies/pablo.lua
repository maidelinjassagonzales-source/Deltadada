-- PABLO, el Rey del Armario. Incel. Bando malo.
local enemy, super = Class(PCDMEnemy, "pablo")

function enemy:init()
    super.init(self, "pablo_boss")
    self:setup({
        name = "Pablo", hp = 1700, atk = 7, def = 2, money = 160, bad_id = "pablo", power = 1.25,
        sprites = { "billete", "corazon" },
        words = { "hola guapa", "q tal", "porfa", "respondeme", "dame tu insta", "0,99", "ATRÉVETE", "TE, TE", "SAL DEL CLÓSET", "holaaa" },
        word_color = { 0.55, 0.85, 1 },
        waves = { "palabras", "lluvia", "stickers" },
        dialogue = { "Hola guapa.\nQ tal.", "¿Por qué no me\ncontesta nadie?", "Ángel, atrévete.\nTe, te.", "Las cuentas de\nInsta son reales.\nLo sé.", "Soy el REY\nDEL ARMARIO." },
        check = "El Rey del Armario.[wait:5] Sigue a 846 bots.\n* Acosa a Lucía.[wait:5] Le insiste a Ángel.[wait:5]\n* No tiene NADA de vergüenza.",
        text = { "* Pablo revisa si le han contestado.[wait:5] No.", "* Pablo hace una story de su trono.", "* Huele a Axe y a sótano.", "* Pablo te manda una solicitud de amistad." },
        low = "* A Pablo le tiembla el móvil en la mano.",
        spareable = "* Pablo se ha quedado sin argumentos.[wait:5] Y sin batería.",
        death = { "Valeria...\ncontesta..." },
        acts = {
            { "Bloquear", { mercy = 30, text = { "* Le bloqueas en todas las redes.", "* Pablo siente un vacío muy grande." } } },
            { "Explicar los bots", { mercy = 30, tired = true, text = { "* Le explicas que @valeria_hot_2009 es un\n  bot ruso.", "* Pablo se derrumba.[wait:5] Se queda [color:blue]CANSADO[color:reset]." } } },
            { "Rechazo elegante", { mercy = 45, text = { "* Ángel se pone delante:[wait:5] \"No es no, cariño.\"", "* Pablo, por primera vez, lo entiende.[wait:5] Un poco." } }, nil, { "angel" } },
        },
    })
end

return enemy
