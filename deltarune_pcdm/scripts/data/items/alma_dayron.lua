-- Alma de Dayron
local item, super = Class(Item, "alma_dayron")

function item:init()
    super.init(self)
    self.name = "Alma de Dayron"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "El alma de Dayron, cristalizada en\nforma de sticker. Muy hetero."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 3, magic = 2 }
    self.can_equip = {lucia = true, yerover = true, gabriel = true, isra = true, angel = true, alejandro = true, carmen = true, david = true, julio = true, xibin = true, dayron = true}
    self.reactions = {}
end

return item
