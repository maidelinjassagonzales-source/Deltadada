-- Yerover en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_yerover")

function enemy:init()
    super.init(self, "yerover_boss")
    self:setup({
        name = "Yerover", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Bebé, ¿qué haces?",
            "Lucía... vuelve...",
            "ARE YOU... OKAY...?",
            "No quiero pelear\ncontigo."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Yerover no quiere pelear.", "* Yerover te mira a los ojos.", "* Yerover está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Yerover te suplica que pares." } })
end

return enemy
