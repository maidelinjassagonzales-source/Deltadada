-- Dibujo Sospechoso (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "dibujo")

function enemy:init()
    super.init(self, "dibujo")
    self.name = "Dibujo Sospechoso"
    self.max_health = 360
    self.health = 360
    self.attack = 4
    self.defense = 0
    self.money = 22
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "huella",
        "corazon_arcoiris"
    }
    self.bullet_words = {
        "UWU",
        "OWO",
        "*blush*",
        "PERO QUÉ",
        "3 AM",
        "NO MIRES"
    }
    self.waves = {
        "lluvia",
        "palabras"
    }
    self.dialogue = {
        "No me mires...",
        "Soy ARTE.",
        "Me dibujaron a las\n3 de la mañana.",
        "*se tapa con\nla censura*"
    }
    self.check = "Un dibujo furro homoerótico de\nLucía. Mejor no preguntar.\n* Está hecho con mucho cariño. Y anatomía dudosa."
    self.text = {
        "* El Dibujo Sospechoso se sonroja.",
        "* Huele a rotulador Posca.",
        "* La barra de censura tiembla."
    }
    self.low_health_text = "* El Dibujo Sospechoso se está arrugando."
    self:act("Admirar el arte", { mercy = 40, text = "* Lo miras con respeto artístico.\n* Muy respetuoso.\n* Demasiado respetuoso." }, nil, nil)
    self:act("Apartar la mirada", { mercy = 30, text = "* Miras hacia otro lado con educación.\n* El Dibujo agradece tu discreción." }, nil, nil)
    self:act("Subir a DeviantArt", { mercy = 70, text = "* Lucía lo sube a DeviantArt.\n* Tres favoritos en un segundo.\n* El Dibujo brilla de orgullo." }, nil, {
        "lucia"
    })
end

return enemy
