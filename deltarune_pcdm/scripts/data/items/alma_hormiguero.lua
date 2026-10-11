-- Alma del Hormiguero
local item, super = Class(HealItem, "alma_hormiguero")

function item:init()
    super.init(self)
    self.name = "Alma del Hormiguero"
    self.type = "item"
    self.effect = "Cura\nequipo 70"
    self.shop = ""
    self.description = "Huele a plató y a puntos de share.\nCura 70HP a todo el equipo."
    self.heal_amount = 70
    self.price = 0
    self.can_sell = false
    self.target = "party"
    self.usable_in = "all"
    self.reactions = {}
end

return item
