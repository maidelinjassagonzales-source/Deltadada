-- Ron Miel
local item, super = Class(HealItem, "ron_miel")

function item:init()
    super.init(self)
    self.name = "Ron Miel"
    self.type = "item"
    self.effect = "Cura\n40HP"
    self.shop = "Licor\ncanario\n+40HP"
    self.description = "Ron miel canario. Isra lo huele a\nkilómetros. +40HP"
    self.heal_amount = 40
    self.price = 30
    self.can_sell = true
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {isra = "...Hic. Nunca más. (Sí más.)", lucia = "¡Yo no bebo!", angel = "Un traguito, venga."}
end

return item
