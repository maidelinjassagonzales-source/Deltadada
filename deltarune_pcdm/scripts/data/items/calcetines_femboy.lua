-- Calcetines Femboy
local item, super = Class(Item, "calcetines_femboy")

function item:init()
    super.init(self)
    self.name = "Calcetines Femboy"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "Calcetines largos de rayas rosas.\n+1 DEF, +1000 de estilo."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 1, magic = 1 }
    self.can_equip = {lucia = true, yerover = true, gabriel = true, isra = true, angel = true, alejandro = true, carmen = true, david = true, julio = true, xibin = true, dayron = true}
    self.reactions = {}
end

return item
