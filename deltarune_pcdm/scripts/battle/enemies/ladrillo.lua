-- Ladrillo MAGA (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "ladrillo")

function enemy:init()
    super.init(self, "ladrillo")
    self.name = "Ladrillo MAGA"
    self.max_health = 450
    self.health = 450
    self.attack = 5
    self.defense = 2
    self.money = 25
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "ladrillo",
        "hamburguesa",
        "billete"
    }
    self.bullet_words = nil
    self.waves = {
        "muro",
        "lluvia"
    }
    self.dialogue = {
        "¡CONSTRUID\nEL MURO!",
        "¡Y que lo pague\nMéxico!",
        "Soy el mejor\nladrillo. El mejor.",
        "FAKE NEWS."
    }
    self.check = "Un ladrillo del muro de Trump con\ngorra roja.\n* Es tremendo. Tremendísimo. Un ladrillo."
    self.text = {
        "* El Ladrillo MAGA se cree muy alto.",
        "* Huele a cemento y a hamburguesa.",
        "* El Ladrillo grita algo sobre aranceles."
    }
    self.low_health_text = "* Al Ladrillo MAGA se le cae el cemento."
    self:act("Saltar el muro", { mercy = 40, text = "* Saltas el muro de un brinco.\n* El Ladrillo no entiende cómo." }, nil, nil)
    self:act("Hablar en español", { mercy = 30, tired = true, text = "* Le hablas en español.\n* El Ladrillo se asusta y se queda\n[color:blue]CANSADO[color:reset]." }, nil, nil)
    self:act("Pagar", { mercy = 30, text = "* Le das un euro.\n* No es suficiente para un muro.\n* Pero algo es algo." }, nil, nil)
end

return enemy
