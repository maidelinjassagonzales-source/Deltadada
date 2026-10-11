-- Escaño de Junts (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "escano")

function enemy:init()
    super.init(self, "escano")
    self.name = "Escaño de Junts"
    self.max_health = 420
    self.health = 420
    self.attack = 5
    self.defense = 2
    self.money = 26
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "escano",
        "billete"
    }
    self.bullet_words = {
        "DEPENDE",
        "WATERLOO",
        "¿Y YO QUÉ?"
    }
    self.waves = {
        "lluvia",
        "palabras"
    }
    self.dialogue = {
        "Mi voto vale\nMUCHO.",
        "¿Qué me das\na cambio?",
        "Me voy a\nWaterloo.",
        "Depende..."
    }
    self.check = "Un escaño del Congreso. Decide\nlas votaciones. Todas.\n* Lleva una maleta preparada."
    self.text = {
        "* El Escaño de Junts está negociando.",
        "* El Escaño mira la hora del vuelo a\nBruselas.",
        "* Huele a moqueta del Congreso."
    }
    self.low_health_text = "* El Escaño se tambalea. Igual que el Gobierno."
    self:act("Negociar", { mercy = 40, text = "* Negociáis durante tres horas.\n* Ha cedido un poquito." }, nil, nil)
    self:act("Amnistía", { mercy = 60, text = "* Le das la amnistía.\n* El Escaño se emociona muchísimo." }, nil, nil)
    self:act("Hablar de Waterloo", { mercy = 30, text = "* Le hablas de Waterloo.\n* Se pone nostálgico." }, nil, nil)
end

return enemy
