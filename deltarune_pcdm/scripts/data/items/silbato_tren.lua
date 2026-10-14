-- Silbato de Tren
local item, super = Class(Item, "silbato_tren")

function item:init()
    super.init(self)
    self.name = "Silbato de Tren"
    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"
    self.effect = ""
    self.shop = ""
    self.description = "El silbato de Thomas. CHU CHU."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 3, magic = 0 }
    self.can_equip = {julio = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
