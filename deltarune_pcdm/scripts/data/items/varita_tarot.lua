-- Varita de Tarot
local item, super = Class(Item, "varita_tarot")

function item:init()
    super.init(self)
    self.name = "Varita de Tarot"
    self.type = "weapon"
    self.icon = "ui/menu/icon/magic"
    self.effect = ""
    self.shop = ""
    self.description = "Una varita de bruja con una carta del\ntarot pegada con celo."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 1, magic = 3 }
    self.can_equip = {carmen = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
