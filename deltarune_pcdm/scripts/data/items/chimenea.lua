-- Chimenea de Tren
local item, super = Class(Item, "chimenea")

function item:init()
    super.init(self)
    self.name = "Chimenea de Tren"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "La chimenea que le sale a Julio en la\ncabeza en el Dark World. Echa humo."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 2, magic = 0 }
    self.can_equip = {julio = true}
    self.reactions = {}
end

return item
