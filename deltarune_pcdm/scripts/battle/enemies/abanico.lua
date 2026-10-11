-- Abanico Arcoíris (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "abanico")

function enemy:init()
    super.init(self, "abanico")
    self.name = "Abanico Arcoíris"
    self.max_health = 380
    self.health = 380
    self.attack = 4
    self.defense = 0
    self.money = 20
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "corazon_arcoiris"
    }
    self.bullet_words = {
        "SLAY",
        "¡ZAS!",
        "PURPURINA",
        "ORGULLO",
        "DIVA"
    }
    self.waves = {
        "espiral",
        "palabras"
    }
    self.dialogue = {
        "¡Zas!\n¡Abanicazo!",
        "Calor, ¿eh?",
        "Slay, cari.",
        "¡Que viva el\norgullo!"
    }
    self.check = "Un abanico con los colores de la\nbandera LGTB. Muy diva.\n* Abanica con TODA la muñeca."
    self.text = {
        "* El Abanico Arcoíris hace ¡ZAS!",
        "* Huele a purpurina.",
        "* El Abanico pide que le digas que es\nguapo."
    }
    self.low_health_text = "* Al Abanico se le doblan las varillas."
    self:act("Abanicarse", { mercy = 40, text = "* Te abanicas con él.\n* ¡ZAS! ¡ZAS! Qué fresquito." }, nil, nil)
    self:act("Voguing", { mercy = 50, text = "* Haces voguing.\n* El Abanico te da un 10." }, nil, nil)
    self:act("Gritar SLAY", { mercy = 40, text = "* ¡¡SLAY!!\n* El Abanico se abre del todo de la emoción." }, nil, nil)
end

return enemy
