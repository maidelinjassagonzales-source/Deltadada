-- Testosterona (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "pastilla_t")

function enemy:init()
    super.init(self, "pastilla_t")
    self.name = "Testosterona"
    self.max_health = 380
    self.health = 380
    self.attack = 5
    self.defense = 1
    self.money = 16
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "pastilla_t"
    }
    self.bullet_words = {
        "BRO",
        "VOZ GRAVE",
        "PELO",
        "GYM"
    }
    self.waves = {
        "lateral",
        "palabras"
    }
    self.dialogue = {
        "BRO.",
        "¿Te está saliendo\nbarba? A mí sí.",
        "Voz grave en\n3... 2... 1...",
        "GYM."
    }
    self.check = "Una pastilla de testosterona.\nVa al gimnasio. Mucho.\n* Lucía la mira con curiosidad."
    self.text = {
        "* La Testosterona hace flexiones.",
        "* A la Testosterona le ha salido un pelo.",
        "* Huele a desodorante de los chinos."
    }
    self.low_health_text = "* La Testosterona necesita proteína."
    self:act("Hacer flexiones", { mercy = 40, text = "* Hacéis flexiones juntos.\n* BRO." }, nil, nil)
    self:act("Hablar grave", { mercy = 40, text = "* Pones la voz más grave que puedes.\n* La Testosterona te respeta." }, nil, nil)
    self:act("Mirar con ilusión", { mercy = 60, text = {
            "* Lucía mira a la pastilla...",
            "* (Algún día...)\n* La Testosterona le choca el puño."
        } }, nil, {
        "lucia"
    })
end

return enemy
