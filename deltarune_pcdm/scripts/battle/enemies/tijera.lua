-- Tijerita (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "tijera")

function enemy:init()
    super.init(self, "tijera")
    self.name = "Tijerita"
    self.max_health = 400
    self.health = 400
    self.attack = 5
    self.defense = 1
    self.money = 20
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "tijerita"
    }
    self.bullet_words = nil
    self.waves = {
        "lateral",
        "apuntado"
    }
    self.dialogue = {
        "Ris, ras.",
        "Corto todo lo que\nno es NORMAL.",
        "Andrés me usa\npara cosas raras...",
        "¡RIS! ¡RAS!"
    }
    self.check = "Unas tijeras de Andrés que han\ncobrado vida.\n* Cortan, pero también tienen miedo."
    self.text = {
        "* La Tijerita se abre y se cierra.",
        "* Ris, ras. Ris, ras.",
        "* La Tijerita apunta a tu cola con\n  malas intenciones."
    }
    self.low_health_text = "* A la Tijerita se le ha mellado el filo."
    self:act("Darle papel", { mercy = 40, text = "* Le das un folio de apuntes.\n* La Tijerita lo corta en tiras.\n* Está feliz." }, nil, nil)
    self:act("Sacar piedra", { mercy = 20, tired = true, text = "* Sacas una piedra.\n* Piedra gana a tijera.\n* La Tijerita se queda [color:blue]CANSADA[color:reset] del susto." }, nil, nil)
    self:act("Afilar", { mercy = 30, text = "* Le pasas el afilador con cariño.\n* Ris... ras... (de placer)." }, nil, nil)
end

return enemy
