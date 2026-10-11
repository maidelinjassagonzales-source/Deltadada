-- Tupé de Trump
local item, super = Class(Item, "pelo_trump")

function item:init()
    super.init(self)
    self.name = "Tupé de Trump"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "El tupé de Trump. +3 DEF.\n-100 de dignidad."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 3, magic = 0 }
    self.can_equip = {lucia = true, yerover = true, gabriel = true, isra = true, angel = true, alejandro = true, carmen = true, david = true, julio = true, xibin = true, dayron = true}
    self.reactions = {}
end

return item
