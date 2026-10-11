-- Bocadillo de Chorizo (Light World)
local item, super = Class(HealItem, "light/bocadillo_chorizo")

function item:init()
    super.init(self)
    self.name = "Bocadillo de Chorizo"
    self.type = "item"
    self.light = true
    self.description = "Un bocadillo de chorizo envuelto en\npapel de aluminio. +12HP"
    self.check = "Cura 12 HP\n* Un bocadillo de chorizo envuelto en papel de aluminio. +12HP"
    self.heal_amount = 12
    self.target = "ally"
    self.usable_in = "all"
end

return item
