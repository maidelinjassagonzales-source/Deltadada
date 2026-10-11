-- Estrógeno (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "pastilla_e")

function enemy:init()
    super.init(self, "pastilla_e")
    self.name = "Estrógeno"
    self.max_health = 340
    self.health = 340
    self.attack = 4
    self.defense = 0
    self.money = 16
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "pastilla_e",
        "corazon"
    }
    self.bullet_words = nil
    self.waves = {
        "lluvia",
        "anillo"
    }
    self.dialogue = {
        "¡Glow up!",
        "Soy euforia de\ngénero en pastilla.",
        "Bebe agua, cari.",
        "¡Hidratación!"
    }
    self.check = "Una pastilla de estrógeno con\nmuy buen rollo.\n* No es mala. Solo quiere jugar."
    self.text = {
        "* El Estrógeno hace una pose.",
        "* Huele a crema hidratante.",
        "* El Estrógeno te manda un besito."
    }
    self.low_health_text = "* El Estrógeno se está disolviendo."
    self:act("Hidratarse", { mercy = 50, text = "* Bebes agua.\n* El Estrógeno aplaude orgulloso." }, nil, nil)
    self:act("Dar las gracias", { mercy = 40, text = "* Le das las gracias por existir.\n* El Estrógeno se emociona." }, nil, nil)
    self:act("Skincare", { mercy = 35, text = "* Os hacéis una rutina de skincare.\n* Piel de porcelana." }, nil, nil)
end

return enemy
