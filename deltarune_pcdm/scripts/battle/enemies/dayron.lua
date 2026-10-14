-- DAYRON. Archienemigo de Gabriel y de Aroy.exe. Duelo con Gabriel (con Dayron.ogg distorsionado de fondo).
local enemy, super = Class(PCDMEnemy, "dayron")

function enemy:init()
    super.init(self, "dayron_boss")
    self:setup({
        name = "Dayron", hp = 1000, atk = 6, def = 2, money = 200, bad_id = "dayron", power = 1.2,
        sprites = { "sticker" },
        words = { "NORMAL", "VALORES", "TRADICIÓN", "UNA CHICA NORMAL", "FURRO", "RETRAMONGUER", "LO NATURAL" },
        word_color = { 1, 0.4, 0.4 },
        waves = { "stickers", "palabras", "rebote" },
        dialogue = { "Retramonguer.", "Lo hago por el\nbien de Lucía.", "¿Susie?\n¿La lagarta?", "Valores de toda\nla vida, bro.", "Una chica tiene\nque ser una chica." },
        check = "Fife heterobásico.[wait:5] Quiere que Lucía deje de\n  ser furra y sea \"normal\".[wait:5]\n* Aroy.exe le odia porque le cambia el guion.",
        text = { "* Dayron se ajusta las gafas.", "* Dayron reparte stickers de su propia cara.", "* Huele a colonia de Mercadona.", "* Dayron habla de \"lo natural\"." },
        low = "* A Dayron se le empañan las gafas.",
        spareable = "* Dayron se ha quedado sin argumentos.",
        death = { "Solo quería...\nque fuera normal..." },
        acts = {
            { "Defender a Lucía", { mercy = 25, text = { "* \"Lucía es quien le da la gana ser.\n  ¿Te enteras, fife?\"", "* Dayron duda." } } },
            { "Hablar de Susie", { mercy = 15, text = "* Gabriel habla de Susie durante 20 minutos.\n* Dayron bosteza.[wait:5] Pierde concentración." } },
            { "Llamarle fife", { mercy = 20, text = "* \"Eres un fife heterobásico.\"\n* Dayron se ofende.[wait:5] Sigue sin saber qué es." } },
        },
    })
end

return enemy
