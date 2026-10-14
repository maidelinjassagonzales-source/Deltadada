-- Expropiación
local spell, super = Class(PCDMSpell, "expropiacion")

function spell:init()
    super.init(self)
    self.name = "Expropiación"
    self.effect = "Robar\ndinero"
    self.description = "Expropia los medios de producción\ndel enemigo. Le baja la defensa."
    self.cost = 20
    self.target = "enemy"
    self.kind = "custom"
    self.power = {}
    self.fx = { kind = "stars", color = {1, 0.2, 0.2}, sound = "coin", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Esto ahora es del pueblo!"}
    self.tags = { "custom" }
end

function spell:applyTo(user, t)
    t.defense = math.max(-5, (t.defense or 0) - 2)
    t:statusMessage("msg", "down")
    Game.battle.money = (Game.battle.money or 0) + 25
    t:addMercy(8)
end

return spell
