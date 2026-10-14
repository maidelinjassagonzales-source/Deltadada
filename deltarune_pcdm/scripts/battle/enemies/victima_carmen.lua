-- Carmen en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_carmen")

function enemy:init()
    super.init(self, "carmen_boss")
    self:setup({
        name = "Carmen", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Las cartas lo\ndijeron...",
            "La Muerte.\nPara nosotros.",
            "Lucía, por favor."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Carmen no quiere pelear.", "* Carmen te mira a los ojos.", "* Carmen está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Carmen te suplica que pares." } })
end

return enemy
