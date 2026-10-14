-- NETANYAHU. Aparece para vengar a Trump. Bando malo.
local enemy, super = Class(PCDMEnemy, "netanyahu")

function enemy:init()
    super.init(self, "netanyahu_boss")
    self:setup({
        name = "Netanyahu", hp = 2000, atk = 8, def = 3, money = 220, bad_id = "netanyahu", power = 1.35,
        sprites = { "foco", "billete" },
        words = { "¡VENGANZA!", "MI DONALD", "¡TRAIDORES!", "LA HAYA NO", "VETO" },
        word_color = { 0.5, 0.75, 1 },
        waves = { "apuntado", "anillo", "palabras" },
        dialogue = { "¿Quién ha tocado\na mi Donald?", "Esto tendrá\nconsecuencias.", "No me habléis\nde La Haya.", "Veto.\nVeto.\nVeto." },
        check = "Viene a vengar a Trump.[wait:5]\n* Tiene una orden de arresto de la Corte\n  Penal Internacional.[wait:5] No le hace gracia.",
        text = { "* Netanyahu mira el móvil.[wait:5] Le llama La Haya.", "* Netanyahu cuelga.", "* Netanyahu dice que todo esto es culpa tuya." },
        low = "* Netanyahu empieza a sudar.",
        spareable = "* Netanyahu se va.[wait:5] Dice que volverá.",
        death = { "Esto no ha\nterminado..." },
        acts = {
            { "Llamar a La Haya", { mercy = 35, text = { "* Marcas el número de la Corte Penal\n  Internacional.", "* Netanyahu se pone MUY nervioso." } } },
            { "Hablar de paz", { mercy = 20, text = "* Le hablas de paz.\n* Netanyahu no conoce la palabra." } },
            { "Ignorarle", { mercy = 20, tired = true, text = "* Le ignoras completamente.\n* Se queda [color:blue]CANSADO[color:reset] de gritar." } },
        },
    })
end

return enemy
