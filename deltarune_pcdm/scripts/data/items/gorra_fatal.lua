-- Gorra Fatal Fury
local item, super = Class(Item, "gorra_fatal")

function item:init()
    super.init(self)
    self.name = "Gorra Fatal Fury"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "La gorra roja de Terry. Con la F.\nSolo le queda bien a Yerover."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 1, magic = 0 }
    self.can_equip = {yerover = true}
    self.reactions = {}
end

return item
