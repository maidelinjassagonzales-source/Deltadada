-- Botella Vacía
local item, super = Class(Item, "botella_vacia")

function item:init()
    super.init(self)
    self.name = "Botella Vacía"
    self.type = "weapon"
    self.icon = "ui/menu/icon/knife"
    self.effect = ""
    self.shop = ""
    self.description = "Una botella de ron miel vacía.\nIsra no recuerda vaciarla."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 2, magic = 1 }
    self.can_equip = {isra = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
