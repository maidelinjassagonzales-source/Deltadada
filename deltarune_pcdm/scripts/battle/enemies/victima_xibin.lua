-- Xibin en la ruta FURRYGRAVE: no quiere pelear. Solo cae con FurryShock.
local enemy, super = Class(PCDMEnemy, "victima_xibin")

function enemy:init()
    super.init(self, "xibin_boss")
    self:setup({
        name = "Xibin", hp = 140, atk = 2, def = 0, money = 0, lethal = true, power = 0.6,
        waves = { "suave" },
        dialogue = {
            "Diría que te\nperdono...",
            "...y lo digo.",
            "El aura...\nse apaga..."
        },
        check = "Tu amigo.[wait:5] Ya no te reconoce.",
        text = { "* Xibin no quiere pelear.", "* Xibin te mira a los ojos.", "* Xibin está temblando." },
        disable_mercy = true,
    })
    self.only_furry = true
    self:act("Hablar", { text = { "* Intentas hablar.", "* Xibin te suplica que pares." } })
end

return enemy
