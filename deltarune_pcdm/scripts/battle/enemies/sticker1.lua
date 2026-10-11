-- Sticker de Dayron (enemigo de a pie)
local enemy, super = Class(PCDMEnemy, "sticker1")

function enemy:init()
    super.init(self, "sticker1")
    self.name = "Sticker de Dayron"
    self.max_health = 360
    self.health = 360
    self.attack = 4
    self.defense = 0
    self.money = 15
    self.experience = 0
    self.spare_points = 20
    self.bullet_sprites = {
        "sticker"
    }
    self.bullet_words = {
        "VALORES",
        "NORMAL",
        "ISRAEL FOREVER"
    }
    self.waves = {
        "stickers",
        "rebote"
    }
    self.dialogue = {
        "Soy Dayron.\nPero en pegatina.",
        "Pégame en tu\ncarpeta.",
        "Valores\ntradicionales.",
        "Esto lo ha generado\nuna IA."
    }
    self.check = "Un sticker de WhatsApp con la cara\nde Dayron.\n* Alguien lo mandó al grupo a las 4 AM."
    self.text = {
        "* El Sticker de Dayron te mira fijamente.",
        "* El Sticker de Dayron brilla con filtro de IA.",
        "* Hay demasiados stickers de Dayron."
    }
    self.low_health_text = "* El Sticker de Dayron se está despegando."
    self:act("Despegar", { mercy = 40, text = "* Lo despegas con la uña.\n* Hace \"fsssh\"." }, nil, nil)
    self:act("Reenviar al grupo", { mercy = 40, text = "* Lo reenvías al grupo.\n* 14 personas reaccionan con una calavera." }, nil, nil)
    self:act("Coleccionar", { mercy = 30, text = "* Lo guardas en favoritos.\n* El Sticker se siente valorado." }, nil, nil)
end

return enemy
