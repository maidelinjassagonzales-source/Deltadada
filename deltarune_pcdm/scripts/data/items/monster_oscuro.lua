-- Monster Oscuro
local item, super = Class(TensionItem, "monster_oscuro")

function item:init()
    super.init(self)
    self.name = "Monster Oscuro"
    self.type = "item"
    self.effect = "+32%\nTP"
    self.shop = "Lata de\nenergía\n+32% TP"
    self.description = "Un Monster de mango del Dark World.\nDa 32% de TP."
    self.tp_amount = 32
    self.price = 50
    self.can_sell = true
    self.target = "none"
    self.usable_in = "battle"
    self.reactions = {yerover = "¡Le traigo uno a Lucía!", lucia = "¡Mi favorito!"}
end

return item
