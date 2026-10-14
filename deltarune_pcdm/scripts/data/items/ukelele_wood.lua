-- Ukelele de Will Wood
local item, super = Class(Item, "ukelele_wood")

function item:init()
    super.init(self)
    self.name = "Ukelele de Will Wood"
    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"
    self.effect = ""
    self.shop = ""
    self.description = "Un ukelele firmado por nadie.\nSuena a disco indie."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { attack = 2, magic = 2 }
    self.can_equip = {david = true}
    self.reactions = {}
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item
