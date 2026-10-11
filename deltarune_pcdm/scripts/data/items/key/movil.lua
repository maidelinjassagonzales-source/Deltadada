-- El móvil: mensajes del grupo y de Yerover.
local item, super = Class(Item, "movil")

function item:init()
    super.init(self)
    self.name = "Móvil"
    self.type = "key"
    self.light = false
    self.description = "Tu móvil. Tiene 3% de batería y\n47 mensajes sin leer en el grupo."
    self.check = "Tu móvil."
    self.price = 0
    self.can_sell = false
    self.target = "none"
    self.usable_in = "world"
end

function item:onWorldUse()
    Game.world:startCutscene("npcs.movil")
    return false
end

return item
