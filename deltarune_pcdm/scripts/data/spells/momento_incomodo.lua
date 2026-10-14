-- MOMENTO INCÓMODO
local spell, super = Class(PCDMSpell, "momento_incomodo")

function spell:init()
    super.init(self)
    self.name = "MOMENTO INCÓMODO"
    self.effect = "CANSAR\n+piedad"
    self.description = "...[wait:5] ¡¡¡MOMENTO INCÓMODO!!!\nCansa a todos y da piedad."
    self.cost = 35
    self.target = "enemies"
    self.kind = "tired_all"
    self.power = {}
    self.fx = { kind = "bubbles", color = {0.8, 0.8, 0.8}, sound = "pcdm_grillos", count = 16 }
    self.mercy = 20
    self.cast_lines = {"* ...[wait:10]\n* ¡¡¡MOMENTO INCÓMODO!!!"}
    self.tags = { "tired_all" }
end

return spell
