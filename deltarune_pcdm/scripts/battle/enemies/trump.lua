-- DONALD TRUMP (Darkner de gorra). Bando malo. Si muere, aparece Netanyahu.
local enemy, super = Class(PCDMEnemy, "trump")

function enemy:init()
    super.init(self, "trump_boss")
    self:setup({
        name = "Trump", hp = 2200, atk = 8, def = 3, money = 250, bad_id = "trump", power = 1.35,
        sprites = { "ladrillo", "hamburguesa", "billete" },
        words = { "FAKE NEWS", "TREMENDOUS", "COVFEFE", "ARANCEL", "MAGA", "BIGLY", "LOSER" },
        word_color = { 1, 0.5, 0.2 },
        waves = { "muro", "lluvia", "palabras" },
        dialogue = { "¡FAKE NEWS!", "Nadie sabe más de\nmuros que yo.", "Tremendo.\nTremendísimo.", "Arancel del\n200% para ti.", "¡Bibi, mírame!" },
        check = "Darkner de gorra roja.[wait:5] Naranja.[wait:5]\n* Construye muros.[wait:5] Se los paga otro.",
        text = { "* Trump habla de sí mismo en tercera persona.", "* Trump pone un arancel a tu cola.", "* Huele a hamburguesa recalentada y a\n  autobronceador.", "* Trump dice que este combate es el mejor\n  combate de la historia." },
        low = "* El tupé de Trump empieza a despegarse.",
        spareable = "* Trump se ha cansado.[wait:5] Se va a jugar al golf.",
        death = { "¡¡BIBI!!\n¡¡AYUDA!!" },
        acts = {
            { "Llamarle LOSER", { mercy = 30, text = { "* \"Eres un LOSER, Donald.\"", "* Trump se pone naranja de rabia.[wait:5]\n* Todavía más naranja." } } },
            { "Hablar en español", { mercy = 25, text = "* Le hablas en español.\n* Trump busca un traductor.[wait:5] No hay." } },
            { "Ponerle un arancel", { mercy = 25, tired = true, text = "* Le pones un arancel a él.\n* No sabe reaccionar.[wait:5] Se queda [color:blue]CANSADO[color:reset]." } },
        },
    })
end

return enemy
