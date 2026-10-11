-- Plancha de Stickers
local item, super = Class(Item, "plancha_pegatinas")

function item:init()
    super.init(self)
    self.name = "Plancha de Stickers"
    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"
    self.effect = ""
    self.shop = ""
    self.description = "Una plancha de stickers con su\npropia cara. Cientos."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 3, magic = 0 }
    self.can_equip = {dayron = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
