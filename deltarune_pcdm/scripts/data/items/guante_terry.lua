-- Guante de Terry
local item, super = Class(Item, "guante_terry")

function item:init()
    super.init(self)
    self.name = "Guante de Terry"
    self.type = "weapon"
    self.icon = "ui/menu/icon/glove"
    self.effect = ""
    self.shop = ""
    self.description = "El guante sin dedos de Terry Bogard.\nHEY, COME ON!"
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 3, magic = 0 }
    self.can_equip = {yerover = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
