-- Zarpa de Peluche
local item, super = Class(Item, "zarpa_peluche")

function item:init()
    super.init(self)
    self.name = "Zarpa de Peluche"
    self.type = "weapon"
    self.icon = "ui/menu/icon/glove"
    self.effect = ""
    self.shop = ""
    self.description = "Una zarpa de peluche gigante.\nBlandita pero contundente."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 2, magic = 0 }
    self.can_equip = {lucia = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
