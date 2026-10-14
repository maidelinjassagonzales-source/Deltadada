-- Chocolatina (Light World)
local item, super = Class(HealItem, "light/chocolatina")

function item:init()
    super.init(self)
    self.name = "Chocolatina"
    self.type = "item"
    self.light = true
    self.description = "Una chocolatina medio derretida. +10HP"
    self.check = "Cura 10 HP\n* Una chocolatina medio derretida. +10HP"
    self.heal_amount = 10
    self.target = "ally"
    self.usable_in = "all"
end

function item:onWorldUse(target)
    Game.world:heal(target, self.heal_amount, "* Te comes: " .. self:getName() .. ".")
    return true
end

return item
