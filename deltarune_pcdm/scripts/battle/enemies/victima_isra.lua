-- Isra en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_isra")

function enemy:init()
    super.init(self, "isra_boss")
    self:setup({
        name = "Isra", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "¡El Capitán Israel\nno te pegará!",
            "Lucía... hic...",
            "Vuelve con\nnosotros.",
            "No puedo pegarte."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Isra no quiere pelear.", "* Isra te mira a los ojos.", "* Isra está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Isra te suplica que pares." } })
end

return enemy
