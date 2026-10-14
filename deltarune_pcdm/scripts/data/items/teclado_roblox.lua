-- Teclado Gamer
local item, super = Class(Item, "teclado_roblox")

function item:init()
    super.init(self)
    self.name = "Teclado Gamer"
    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"
    self.effect = ""
    self.shop = ""
    self.description = "Teclado RGB con el que juega a Roblox\ncomo JakoSherry."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 2, magic = 1 }
    self.can_equip = {alejandro = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
