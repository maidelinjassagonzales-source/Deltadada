-- Barraquito (Light World)
local item, super = Class(HealItem, "light/barraquito_lw")

function item:init()
    super.init(self)
    self.name = "Barraquito"
    self.type = "item"
    self.light = true
    self.description = "Café canario con leche condensada\ny licor. +15HP"
    self.check = "Cura 15 HP\n* Café canario con leche condensada y licor. +15HP"
    self.heal_amount = 15
    self.target = "ally"
    self.usable_in = "all"
end

return item
