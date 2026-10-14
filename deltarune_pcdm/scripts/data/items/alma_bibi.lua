-- Alma de Bibi
local item, super = Class(HealItem, "alma_bibi")

function item:init()
    super.init(self)
    self.name = "Alma de Bibi"
    self.type = "item"
    self.effect = "Equipo\n+100HP"
    self.shop = ""
    self.description = "Un alma muy, muy enfadada.\nCura 100HP a todo el equipo."
    self.heal_amount = 100
    self.price = 0
    self.can_sell = false
    self.target = "party"
    self.usable_in = "all"
    self.reactions = {}
end

return item
