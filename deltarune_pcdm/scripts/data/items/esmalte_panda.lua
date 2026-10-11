-- Esmalte del Panda
local item, super = Class(Item, "esmalte_panda")

function item:init()
    super.init(self)
    self.name = "Esmalte del Panda"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "Esmalte de uñas que te regaló Borja\nIglesias. Las uñas pintadas dan poder."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 2, magic = 1 }
    self.can_equip = {lucia = true, yerover = true, gabriel = true, isra = true, angel = true, alejandro = true, carmen = true, david = true, julio = true, xibin = true, dayron = true}
    self.reactions = {}
end

return item
