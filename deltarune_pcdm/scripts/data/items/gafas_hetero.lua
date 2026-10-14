-- Gafas Heterobásicas
local item, super = Class(Item, "gafas_hetero")

function item:init()
    super.init(self)
    self.name = "Gafas Heterobásicas"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "Unas gafas normales. Muy normales.\nDemasiado normales."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 2, magic = 0 }
    self.can_equip = {dayron = true}
    self.reactions = {}
end

return item
