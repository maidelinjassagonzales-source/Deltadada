-- Marine de Cartón (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "marine")

function enemy:init()
    super.init(self, "marine")
    self.name = "Marine de Cartón"
    self.max_health = 460
    self.health = 460
    self.attack = 5
    self.defense = 2
    self.money = 25
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "marine_mini",
        "estrella"
    }
    self.bullet_words = {
        "¡HEREJE!",
        "EMPERADOR",
        "WAAAGH"
    }
    self.waves = {
        "lateral",
        "apuntado",
        "palabras"
    }
    self.dialogue = {
        "¡POR EL\nEMPERADOR!",
        "Esta armadura es\nde cartón de Zara.",
        "¡HEREJE!",
        "La cinta americana\nse despega..."
    }
    self.check = "Un cosplay de Marine Espacial de\nAndrés que ha cobrado vida.\n* Hecho con cajas de Zara y mucha fe."
    self.text = {
        "* El Marine de Cartón hace un saludo.",
        "* Huele a cola blanca.",
        "* Al Marine se le cae una hombrera."
    }
    self.low_health_text = "* El Marine de Cartón se está mojando.\n* El cartón no aguanta."
    self:act("Decir que está guapo", { mercy = 50, text = "* Le dices que el cosplay está muy bien.\n* El Marine se pone rojo bajo el casco." }, nil, nil)
    self:act("Hablar de WoW", { mercy = 30, text = "* Le hablas del World of Warcraft.\n* \"¡Eso es otro juego, HEREJE!\"" }, nil, nil)
    self:act("Quitarle la cinta", { mercy = 30, tired = true, text = "* Le despegas la cinta americana.\n* Se le cae medio cosplay.\n* Se queda [color:blue]CANSADO[color:reset]." }, nil, nil)
end

return enemy
