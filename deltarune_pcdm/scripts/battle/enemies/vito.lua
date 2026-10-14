-- VITO QUILES (Darkner de micrófono). Bando malo.
local enemy, super = Class(PCDMEnemy, "vito")

function enemy:init()
    super.init(self, "vito_boss")
    self:setup({
        name = "Vito Quiles", hp = 1300, atk = 6, def = 1, money = 120, bad_id = "vito", power = 1.15,
        sprites = { "microfono" },
        words = { "¿CONDENA?", "¡CONTESTE!", "CENSURA", "PERIODISMO", "¡DICTADURA!", "¿USTED CONDENA?" },
        word_color = { 1, 0.85, 0.3 },
        waves = { "palabras", "apuntado", "lateral" },
        dialogue = { "¿Usted condena\na la furra?", "¡Conteste a la\npregunta!", "Esto es\nperiodismo.", "¡Me están\ncensurando!", "Suscríbete a mi\ncanal." },
        check = "Darkner de micrófono.\n* Hace preguntas a gritos en la puerta de\n  los sitios.[wait:5] Lo llama \"periodismo\".",
        text = { "* Vito Quiles te pone el micro en la cara.", "* Vito Quiles está grabando un directo.", "* Huele a agresión inventada.", "* Vito pregunta si condenas algo.[wait:5]\n* No dice el qué." },
        low = "* A Vito se le ha caído el micro.",
        spareable = "* Vito Quiles no sabe qué preguntar.",
        death = { "¡¡ME HAN\nAGREDIDO!!" },
        acts = {
            { "No contestar", { mercy = 25, text = { "* No contestas a ninguna pregunta.", "* Vito se pone muy nervioso.[wait:5]\n* \"¡¿Por qué no contesta?!\"" } } },
            { "Preguntarle a él", { mercy = 35, text = { "* \"¿Usted condena a Vito Quiles?\"", "* Vito se queda en blanco.[wait:5]\n* Nadie le había preguntado nada a él." } } },
            { "Taparle el micro", { mercy = 20, tired = true, text = "* Le tapas el micro con la mano.\n* Vito se queda [color:blue]CANSADO[color:reset] sin poder gritar." } },
        },
    })
end

return enemy
