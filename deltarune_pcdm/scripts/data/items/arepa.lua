-- Arepa
local item, super = Class(HealItem, "arepa")

function item:init()
    super.init(self)
    self.name = "Arepa"
    self.type = "item"
    self.effect = "Cura\n60HP"
    self.shop = "Arepa\nrellena\n+60HP"
    self.description = "Arepa de reina pepiada. Julio dice\nque la de su abuela es mejor. +60HP"
    self.heal_amount = 60
    self.price = 40
    self.can_sell = true
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {julio = "¡Épale! ¡Como en casa!", gabriel = "Joder, qué buena.", lucia = "¡Está riquísima!"}
end

return item
