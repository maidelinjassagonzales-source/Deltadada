-- Alejandro en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_alejandro")

function enemy:init()
    super.init(self, "alejandro_boss")
    self:setup({
        name = "Alejandro", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Esto no es canon.",
            "Lucía, despierta.",
            "Kris nunca haría\nesto...",
            "Por favor..."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Alejandro no quiere pelear.", "* Alejandro te mira a los ojos.", "* Alejandro está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Alejandro te suplica que pares." } })
end

return enemy
