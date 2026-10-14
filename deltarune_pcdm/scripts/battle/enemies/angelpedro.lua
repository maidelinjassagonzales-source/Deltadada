-- ANGEL PEDRO. Rompe sillas. No entiende nada. Bando malo (por influencia de Dayron).
local enemy, super = Class(PCDMEnemy, "angelpedro")

function enemy:init()
    super.init(self, "angelpedro_boss")
    self:setup({
        name = "Angel Pedro", hp = 1500, atk = 7, def = 2, money = 140, bad_id = "angelpedro", power = 1.2,
        sprites = { "pata_silla", "silla_mini" },
        waves = { "lluvia", "rebote", "carga" },
        dialogue = { "¿Las sillas tienen\nalma?", "Dayron dice que\nhay que liberarlas.", "...", "¿Esto es un\ncombate?", "No entiendo nada.\nPero rompo sillas." },
        check = "Rompe sillas.[wait:5] No entiende muy bien lo que\n  pasa.[wait:5] Dayron le ha comido la cabeza.",
        text = { "* Angel Pedro mira una silla fijamente.", "* Angel Pedro levanta una silla. Y otra.", "* Angel Pedro se pregunta qué hace aquí.", "* Huele a serrín." },
        low = "* Angel Pedro se tambalea como una silla coja.",
        spareable = "* Angel Pedro ya no quiere romper nada.",
        death = { "¿Me he\nliberado...?" },
        acts = {
            { "Explicar despacio", { mercy = 25, text = { "* Le explicas despacito que las sillas no\n  tienen alma.", "* Angel Pedro asiente.[wait:5] No ha entendido nada.[wait:5]\n* Pero asiente." } } },
            { "Darle una silla", { mercy = 20, text = { "* Le das una silla.", "* La rompe.[wait:5] Está muy contento." } } },
            { "Hablar de familia", { mercy = 30, text = { "* Le preguntas por su familia.", "* \"Mis padres me adoptaron.[wait:5] Me eligieron a mí\n  entre todos.[wait:5] Eso mola, ¿no?\"", "* Angel Pedro sonríe de verdad." } } },
            { "Decir que Dayron miente", { mercy = 25, text = "* \"Dayron te está usando, Angel Pedro.\"\n* Angel Pedro duda por primera vez." } },
        },
    })
end

return enemy
