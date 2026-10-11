-- Alma de Silla (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "silla")

function enemy:init()
    super.init(self, "silla")
    self.name = "Alma de Silla"
    self.max_health = 380
    self.health = 380
    self.attack = 4
    self.defense = 0
    self.money = 18
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "pata_silla",
        "silla_mini"
    }
    self.bullet_words = nil
    self.waves = {
        "lluvia",
        "rebote"
    }
    self.dialogue = {
        "Me rompieron...",
        "¿Por qué,\nAngel Pedro?",
        "Solo quería que\nalguien se sentara\nen mí...",
        "Cric.\nCrac."
    }
    self.check = "El alma en pena de una silla\nque rompió Angel Pedro.\n* Solo quiere que alguien se siente."
    self.text = {
        "* El Alma de Silla cruje tristemente.",
        "* Huele a pupitre viejo y a chicle.",
        "* El Alma de Silla cojea de una pata."
    }
    self.low_health_text = "* El Alma de Silla está a punto de hacerse astillas."
    self:act("Sentarse", { mercy = 50, text = {
            "* Te sientas con muchísimo cuidado.",
            "* La silla llora de felicidad.\n* ¡Por fin alguien la usa!"
        } }, nil, nil)
    self:act("Pegamento", { mercy = 35, text = "* Le pones pegamento Imedio en la\npata.\n* Casi como nueva." }, nil, nil)
    self:act("Culpar a Angel Pedro", { mercy = 25, text = "* ¡Todo es culpa de Angel Pedro!\n* La silla asiente con el respaldo." }, nil, nil)
end

return enemy
