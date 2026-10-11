-- Papas Arrugadas
local item, super = Class(HealItem, "papas_arrugadas")

function item:init()
    super.init(self)
    self.name = "Papas Arrugadas"
    self.type = "item"
    self.effect = "Cura\nequipo 45"
    self.shop = "Papas con\nmojo\n+45 todos"
    self.description = "Papas arrugadas con mojo picón.\nCura 45HP a todo el equipo."
    self.heal_amount = 45
    self.price = 90
    self.can_sell = true
    self.target = "party"
    self.usable_in = "all"
    self.reactions = {isra = "Con mojo, como Dios manda."}
end

return item
