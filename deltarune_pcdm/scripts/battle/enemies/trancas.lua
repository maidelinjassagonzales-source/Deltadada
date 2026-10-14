-- Trancas (hormiga de El Hormiguero). Vienen a vengar a Pablo Motos.
local enemy, super = Class(PCDMEnemy, "trancas")

function enemy:init()
    super.init(self, "trancas")
    self:setup({
        name = "Trancas", hp = 900, atk = 6, def = 1, money = 60, lethal = true, power = 1.1,
        sprites = { "hormiga" },
        words = { "¡PABLO!", "¡VENGANZA!", "¡EXPERIMENTO!" },
        waves = { "lateral", "palabras" },
        dialogue = { "¡¡PABLOOO!!", "¿Quién es quién?", "¡Experimento\nmortal!", "¡Somos dos!" },
        check = "Una de las hormigas de El Hormiguero.\n* Nadie sabe si es Trancas o Barrancas.",
        text = { "* Las hormigas se pelean por quién habla.", "* Una hormiga hace un chiste malo.", "* La otra se ríe por contrato." },
        low = "* A la hormiga le tiemblan las antenas.",
        death = { "¡Pablo...!" },
        acts = {
            { "Adivinar el nombre", { mercy = 30, text = "* \"¡Tú eres Trancas!\"\n* La hormiga se emociona: ¡nadie acierta nunca!" } },
            { "Echar insecticida", { mercy = 10, tired = true, text = "* Era ambientador.[wait:5] La hormiga se marea y se\n  queda [color:blue]CANSADA[color:reset]." } },
        },
    })
end

return enemy
