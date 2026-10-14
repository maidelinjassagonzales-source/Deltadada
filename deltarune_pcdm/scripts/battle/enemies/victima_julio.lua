-- Julio en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_julio")

function enemy:init()
    super.init(self, "julio_boss")
    self:setup({
        name = "Julio", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Chu... chu...",
            "Thomas no haría\nesto...",
            "¿Por qué, Lucía?",
            "Tengo miedo."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Julio no quiere pelear.", "* Julio te mira a los ojos.", "* Julio está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Julio te suplica que pares." } })
end

return enemy
