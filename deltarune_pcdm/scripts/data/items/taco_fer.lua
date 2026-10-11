-- Taco de la Fer
local item, super = Class(HealItem, "taco_fer")

function item:init()
    super.init(self)
    self.name = "Taco de la Fer"
    self.type = "item"
    self.effect = "Cura\n80HP"
    self.shop = "Taco al\npastor\n+80HP"
    self.description = "Un taco al pastor de la tienda de\nFernanda. Pica. MUCHO. +80HP"
    self.heal_amount = 80
    self.price = 60
    self.can_sell = true
    self.target = "ally"
    self.usable_in = "all"
    self.reactions = {yerover = "¡Me arde la boca!", xibin = "Diría que pica. Pero no lo digo. Porque pica."}
end

return item
