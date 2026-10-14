-- Ángel en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_angel")

function enemy:init()
    super.init(self, "angel_boss")
    self:setup({
        name = "Ángel", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Cariño, para.",
            "Esta no eres tú.",
            "Zuzu llora...",
            "Te, te... por\nfavor..."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Ángel no quiere pelear.", "* Ángel te mira a los ojos.", "* Ángel está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Ángel te suplica que pares." } })
end

return enemy
