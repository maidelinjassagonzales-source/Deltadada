-- Bolsa de Papas (Light World)
local item, super = Class(HealItem, "light/papas_lw")

function item:init()
    super.init(self)
    self.name = "Bolsa de Papas"
    self.type = "item"
    self.light = true
    self.description = "Papas fritas de bolsa. Quedan tres.\n+6HP"
    self.check = "Cura 6 HP\n* Papas fritas de bolsa. Quedan tres. +6HP"
    self.heal_amount = 6
    self.target = "ally"
    self.usable_in = "all"
end

return item
