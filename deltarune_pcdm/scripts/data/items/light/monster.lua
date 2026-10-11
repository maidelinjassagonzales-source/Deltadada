-- Monster de Mango (Light World)
local item, super = Class(HealItem, "light/monster")

function item:init()
    super.init(self)
    self.name = "Monster de Mango"
    self.type = "item"
    self.light = true
    self.description = "Lata de Monster de mango.\nYerover te la compró. +8HP"
    self.check = "Cura 8 HP\n* Lata de Monster de mango. Yerover te la compró. +8HP"
    self.heal_amount = 8
    self.target = "ally"
    self.usable_in = "all"
end

return item
