-- Alma Incel
local item, super = Class(HealItem, "alma_incel")

function item:init()
    super.init(self)
    self.name = "Alma Incel"
    self.type = "item"
    self.effect = "Equipo\n+80HP"
    self.shop = ""
    self.description = "El alma de Pablo. Huele a sótano.\nCura 80HP a todo el equipo."
    self.heal_amount = 80
    self.price = 0
    self.can_sell = false
    self.target = "party"
    self.usable_in = "all"
    self.reactions = {angel = "Te, te. Qué asco.", lucia = "...Pobre alma."}
end

return item
