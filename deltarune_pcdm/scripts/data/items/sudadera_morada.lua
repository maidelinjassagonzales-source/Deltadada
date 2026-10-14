-- Sudadera Morada
local item, super = Class(Item, "sudadera_morada")

function item:init()
    super.init(self)
    self.name = "Sudadera Morada"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "Sudadera morada como Susie.\nHuele a Gabriel."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 2, magic = 0 }
    self.can_equip = {lucia = true, yerover = true, gabriel = true, isra = true, angel = true, alejandro = true, carmen = true, david = true, julio = true, xibin = true, dayron = true}
    self.reactions = {}
end

return item
