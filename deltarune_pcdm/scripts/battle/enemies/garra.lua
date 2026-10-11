-- Garra Furra (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "garra")

function enemy:init()
    super.init(self, "garra")
    self.name = "Garra Furra"
    self.max_health = 360
    self.health = 360
    self.attack = 4
    self.defense = 0
    self.money = 18
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "huella"
    }
    self.bullet_words = nil
    self.waves = {
        "lluvia",
        "rebote"
    }
    self.dialogue = {
        "Uwu.",
        "*zarpazo blandito*",
        "¿Me rascas\ndetrás de la uña?",
        "Nya~"
    }
    self.check = "Una garra de fursuit con vida\npropia. Tiene almohadillas.\n* Es blandita. Muy blandita."
    self.text = {
        "* La Garra Furra amasa el aire.",
        "* Huele a fursuit recién lavado.",
        "* Las almohadillas brillan."
    }
    self.low_health_text = "* A la Garra Furra se le cae el pelo."
    self:act("Chocar la zarpa", { mercy = 50, text = "* ¡Chocáis la zarpa!\n* *pof*" }, nil, nil)
    self:act("Rascar", { mercy = 40, text = "* La rascas detrás de la uña.\n* Ronronea. ¿Las garras ronronean?" }, nil, nil)
    self:act("Ruidos furros", { mercy = 70, text = "* Lucía hace \"nya~\".\n* La Garra Furra se derrite de amor." }, nil, {
        "lucia"
    })
end

return enemy
