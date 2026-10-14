-- PABLO MOTOS (Darkner de plató). Bando malo. Su música suena al revés y lenta.
local enemy, super = Class(PCDMEnemy, "motos")

function enemy:init()
    super.init(self, "motos_boss")
    self:setup({
        name = "Pablo Motos", hp = 1600, atk = 7, def = 2, money = 150, bad_id = "motos", power = 1.25,
        sprites = { "hormiga", "foco" },
        words = { "¡APLAUSOS!", "INVITADO", "¿TE PUEDO TOCAR?", "SHARE", "¡TRANCAS!", "¡BARRANCAS!" },
        word_color = { 1, 0.85, 0.3 },
        waves = { "palabras", "lateral", "espiral" },
        dialogue = { "¡Bienvenidos a\nEl Hormiguero!", "¿Puedo tocarte\nla cola?", "¡Trancas!\n¡Barrancas!", "Hoy tenemos un\ninvitado especial:\ntú.", "¿Esto es un\nexperimento?" },
        check = "Presentador Darkner.[wait:5] Toca a sus invitadas\n  sin permiso.[wait:5] Lo llama \"humor\".",
        text = { "* Pablo Motos hace un experimento con un\n  globo.[wait:5] Nadie se ríe.", "* El público aplaude porque se lo indica un\n  cartel.", "* Huele a plató y a cuñado.", "* Las hormigas cuchichean detrás del escenario." },
        low = "* A Pablo Motos se le está despegando el\n  maquillaje.",
        spareable = "* Pablo Motos se va a publicidad.",
        death = { "¡Volvemos\ndespués de\npublicidad...!" },
        acts = {
            { "Negarse", { mercy = 35, text = { "* Cuando intenta tocarte la cola, le dices\n  que NO.", "* Pablo Motos se sorprende.[wait:5]\n* Nadie le había dicho que no en directo." } } },
            { "Aplaudir", { mercy = 15, text = "* Aplaudes por compromiso.\n* El cartel de APLAUSOS parpadea feliz." } },
            { "Cambiar de canal", { mercy = 25, tired = true, text = "* Cambias de canal.\n* El share se hunde.[wait:5] Pablo Motos se queda\n  [color:blue]CANSADO[color:reset]." } },
        },
    })
    -- la tele de El Hormiguero (detrás)
    local tv = Sprite("objects/tele", -20, -20)
    tv:play(0.5, true)
    tv.layer = -1
    tv.alpha = 0.8
    self:addChild(tv)
end

return enemy
