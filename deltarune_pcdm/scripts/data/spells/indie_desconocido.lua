-- Indie Desconocido
local spell, super = Class(PCDMSpell, "indie_desconocido")

function spell:init()
    super.init(self)
    self.name = "Indie Desconocido"
    self.effect = "+Piedad"
    self.description = "Recomienda un juego indie que nadie\nconoce. Da piedad a un enemigo."
    self.cost = 20
    self.target = "enemy"
    self.kind = "mercy"
    self.power = {}
    self.fx = { kind = "stars", color = {0.9, 0.9, 0.9}, sound = "mercyadd", count = 16 }
    self.mercy = 35
    self.cast_lines = {"* El enemigo no lo conoce. Le da curiosidad."}
    self.tags = { "mercy" }
end

return spell
