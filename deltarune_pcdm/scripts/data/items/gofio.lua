-- Gofio Escaldado
local item, super = Class(HealItem, "gofio")

function item:init()
    super.init(self)
    self.name = "Gofio Escaldado"
    self.type = "item"
    self.effect = "Cura\n120HP"
    self.shop = "Gofio\nescaldado\n+120HP"
    self.description = "Gofio escaldado de la abuela de\nalguien. Cura un montón. +120HP"
    self.heal_amount = 120
    self.price = 100
    self.can_sell = true
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {gabriel = "Esto sabe a tierra. Me encanta."}
end

return item
