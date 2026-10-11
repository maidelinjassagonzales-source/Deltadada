-- Sombrero de Bruja
local item, super = Class(Item, "sombrero_bruja")

function item:init()
    super.init(self)
    self.name = "Sombrero de Bruja"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.effect = ""
    self.shop = ""
    self.description = "El sombrero de Carmen. Predice cosas\ncuando nadie mira."
    self.price = 40
    self.can_sell = true
    self.target = "none"
    self.usable_in = "all"
    self.bonuses = { defense = 1, magic = 1 }
    self.can_equip = {carmen = true}
    self.reactions = {}
end

return item
