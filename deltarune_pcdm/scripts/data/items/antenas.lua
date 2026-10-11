-- Antenas de Hormiga
local item, super = Class(TensionItem, "antenas")

function item:init()
    super.init(self)
    self.name = "Antenas de Hormiga"
    self.type = "item"
    self.effect = "+100%\nTP"
    self.shop = ""
    self.description = "Las antenas de Trancas o de Barrancas.\nNadie sabe cuál es cuál. 100% de TP."
    self.tp_amount = 100
    self.price = 0
    self.can_sell = false
    self.target = "none"
    self.usable_in = "battle"
    self.reactions = {}
end

return item
