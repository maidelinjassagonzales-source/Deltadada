-- Churros del Pino
local item, super = Class(HealItem, "churros")

function item:init()
    super.init(self)
    self.name = "Churros del Pino"
    self.type = "item"
    self.effect = "Cura\n45HP"
    self.shop = "Churros\nde feria\n+45HP"
    self.description = "Churros de las Fiestas del Pino.\nSiguen calientes. Misteriosamente. +45HP"
    self.heal_amount = 45
    self.price = 35
    self.can_sell = true
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {isra = "Esto me trae recuerdos... borrosos."}
end

return item
