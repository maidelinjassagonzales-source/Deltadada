-- GABRIEL en la ruta FURRYGRAVE: lucha hasta el final. Solo FURRYGRAVE puede acabar con él.
local enemy, super = Class(PCDMEnemy, "gabriel_sg")

function enemy:init()
    super.init(self, "gabriel_boss")
    self:setup({
        name = "Gabriel", hp = 2200, atk = 9, def = 2, money = 0, lethal = true, power = 1.5,
        sprites = { "estrella", "nota" },
        waves = { "hacha", "anillo", "apuntado" },
        dialogue = { "Susie nunca se\nrendiría.", "Lucía, vuelve.\nPor favor.", "¡¡RUDE BUSTER!!", "No pienso caer.", "Todavía...\nno..." },
        check = "Un retramonguer de verdad.[wait:5]\n* Lucha por sus amigos.[wait:5] No va a caer.",
        text = { "* Gabriel aprieta los dientes.", "* Gabriel no se va a rendir.", "* Gabriel recuerda a todos los que ya no están." },
        low = "* Gabriel apenas se tiene en pie.[wait:5]\n* Pero sigue de pie.",
        disable_mercy = true,
        death = { "Susie...\nnunca...\nse rendiría..." },
    })
    self.min_health = 1
    self.on_refuse = function(e)
        e.dialogue_override = "¡¡NO PIENSO\nCAER!!"
        Game.battle:battleText("* Gabriel se niega a caer.\n* Solo algo MUY poderoso podría acabar con él.")
    end
    self:act("Hablar", { text = { "* \"Ríndete, retramonguer.\"", "* \"Jamás.\"" } })
end

return enemy
