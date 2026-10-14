-- Alma de Caballo
local item, super = Class(HealItem, "alma_caballo")

function item:init()
    super.init(self)
    self.name = "Alma de Caballo"
    self.type = "item"
    self.effect = "Cura\n150HP"
    self.shop = ""
    self.description = "El alma del caballo de Abascal. El\ncaballo era inocente. +150HP"
    self.heal_amount = 150
    self.price = 0
    self.can_sell = false
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {julio = "El caballo no tenía la culpa..."}
end

return item
