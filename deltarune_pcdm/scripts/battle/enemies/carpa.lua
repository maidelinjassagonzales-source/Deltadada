-- Carpa Prove Me Wrong (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "carpa")

function enemy:init()
    super.init(self, "carpa")
    self.name = "Carpa Prove Me Wrong"
    self.max_health = 420
    self.health = 420
    self.attack = 5
    self.defense = 1
    self.money = 24
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "interrogante"
    }
    self.bullet_words = {
        "PROVE ME WRONG",
        "DEBATE",
        "FACTS",
        "LOGIC",
        "¿?"
    }
    self.waves = {
        "palabras",
        "lluvia"
    }
    self.dialogue = {
        "Siéntate y\ndebate conmigo.",
        "Demuéstrame que\nme equivoco.",
        "Esto es un hecho,\nno una opinión.",
        "..."
    }
    self.check = "Una carpa de debates universitarios.\n* Tiene una mesa, una silla vacía y\nmuchas ganas de discutir."
    self.text = {
        "* La Carpa despliega un cartel.",
        "* La silla vacía te invita a sentarte.",
        "* Huele a campus americano."
    }
    self.low_health_text = "* La Carpa se está desmontando."
    self:act("Demostrar que no", { mercy = 60, text = "* Le demuestras que se equivoca, con\nfuentes y todo.\n* La Carpa no sabe qué hacer." }, nil, nil)
    self:act("No entrar al trapo", { mercy = 40, text = "* No te sientas a debatir.\n* La Carpa se desinfla un poco." }, nil, nil)
    self:act("Pedir fuentes", { mercy = 30, text = "* \"¿Fuentes?\"\n* La Carpa busca en sus bolsillos.\n* No tiene bolsillos." }, nil, nil)
end

return enemy
