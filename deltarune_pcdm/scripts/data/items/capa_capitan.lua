-- Capa del Capitán
local item, super = Class(Item, "capa_capitan")

function item:init()
    super.init(self)
    self.name = "Capa del Capitán"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "La capa del Capitán Israel.\nProtege las calles. Y a Isra."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 2, magic = 0 }
    self.can_equip = {isra = true}
    self.reactions = {}
end

return item
