-- Hacha de Susie
local item, super = Class(Item, "hacha_susie")

function item:init()
    super.init(self)
    self.name = "Hacha de Susie"
    self.type = "weapon"
    self.icon = "ui/menu/icon/axe"
    self.effect = ""
    self.shop = ""
    self.description = "Réplica de cartón piedra del hacha de\nSusie. Pega más de lo que parece."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 4, magic = 0 }
    self.can_equip = {gabriel = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
