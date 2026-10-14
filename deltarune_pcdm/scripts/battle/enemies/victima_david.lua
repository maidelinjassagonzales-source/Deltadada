-- David en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_david")

function enemy:init()
    super.init(self, "david_boss")
    self:setup({
        name = "David", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Lucía...\npor favor...",
            "Tengo que decirle\nalgo a Carmen...",
            "No me hagas\nesto."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* David no quiere pelear.", "* David te mira a los ojos.", "* David está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* David te suplica que pares." } })
end

return enemy
