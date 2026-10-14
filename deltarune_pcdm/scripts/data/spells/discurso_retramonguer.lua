-- Discurso Retra
local spell, super = Class(PCDMSpell, "discurso_retramonguer")

function spell:init()
    super.init(self)
    self.name = "Discurso Retra"
    self.effect = "CANSAR\nenemigo"
    self.description = "Un discurso de media hora sobre\nDeltarune. Cansa a un enemigo."
    self.cost = 24
    self.target = "enemy"
    self.kind = "tired"
    self.power = {}
    self.fx = { kind = "bubbles", color = {0.8, 0.6, 1}, sound = "ui_spooky_action", count = 16 }
    self.mercy = 15
    self.cast_lines = {"* El enemigo se ha quedado dormido de pie."}
    self.tags = { "tired" }
end

return spell
