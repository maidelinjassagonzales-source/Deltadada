-- Maletín Shanghái
local item, super = Class(Item, "maletin_shanghai")

function item:init()
    super.init(self)
    self.name = "Maletín Shanghái"
    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"
    self.effect = ""
    self.shop = ""
    self.description = "Maletín lleno de contratos de\nHoyoverse y Modas Shanghái."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 3, magic = 1 }
    self.can_equip = {xibin = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
