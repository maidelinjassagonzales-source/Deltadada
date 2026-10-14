-- Alma de Silla
local item, super = Class(HealItem, "alma_silla")

function item:init()
    super.init(self)
    self.name = "Alma de Silla"
    self.type = "item"
    self.effect = "Cura\n100HP"
    self.shop = ""
    self.description = "El alma liberada de una silla rota.\nTe sientas encima. +100HP"
    self.heal_amount = 100
    self.price = 0
    self.can_sell = false
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {}
end

return item
