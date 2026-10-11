-- Papeleta de Vox (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "papeleta")

function enemy:init()
    super.init(self, "papeleta")
    self.name = "Papeleta de Vox"
    self.max_health = 400
    self.health = 400
    self.attack = 5
    self.defense = 1
    self.money = 22
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "papeleta"
    }
    self.bullet_words = {
        "¡ESPAÑA!",
        "¡A POR ELLOS!",
        "RECONQUISTA"
    }
    self.waves = {
        "lluvia",
        "lateral",
        "palabras"
    }
    self.dialogue = {
        "¡España!",
        "¡A por ellos!",
        "Es la hora de la\nReconquista.",
        "Me han votado.\nQué vergüenza."
    }
    self.check = "Una papeleta verde que se ha\nescapado de una urna.\n* Grita mucho para ser de papel."
    self.text = {
        "* La Papeleta de Vox grita \"¡España!\".",
        "* Huele a sobre electoral.",
        "* La Papeleta se ha puesto una pulsera\ncon la bandera."
    }
    self.low_health_text = "* La Papeleta se está arrugando."
    self:act("Romperla", { mercy = 50, text = "* La rompes en pedacitos.\n* Lucía aplaude." }, nil, nil)
    self:act("Votar a otro", { mercy = 40, text = "* Votas a otro partido.\n* La Papeleta se queda sin sitio en la\nurna." }, nil, nil)
    self:act("Explicar historia", { mercy = 30, text = "* Le explicas que Al-Ándalus duró ocho\nsiglos.\n* La Papeleta se queda en blanco." }, nil, nil)
end

return enemy
