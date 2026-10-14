-- Barraquito
local item, super = Class(TensionItem, "barraquito")

function item:init()
    super.init(self)
    self.name = "Barraquito"
    self.type = "item"
    self.effect = "+50%\nTP"
    self.shop = "Café\ncanario\n+50% TP"
    self.description = "Un barraquito con Licor 43. Da 50% de\nTP. Isra pide otro."
    self.tp_amount = 50
    self.price = 80
    self.can_sell = true
    self.target = "none"
    self.usable_in = "battle"
    self.reactions = {isra = "Esto también cuenta como alcohol, ¿no?"}
end

return item
