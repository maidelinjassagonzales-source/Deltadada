-- Abanico de Zuzu
local item, super = Class(Item, "abanico_zuzu")

function item:init()
    super.init(self)
    self.name = "Abanico de Zuzu"
    self.type = "weapon"
    self.icon = "ui/menu/icon/scarf"
    self.effect = ""
    self.shop = ""
    self.description = "Abanico arcoíris con la cara de\nZuzu pintada. Precioso."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 1, magic = 2 }
    self.can_equip = {angel = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
