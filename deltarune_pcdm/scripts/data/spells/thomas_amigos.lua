-- Thomas y sus Amigos
local spell, super = Class(PCDMSpell, "thomas_amigos")

function spell:init()
    super.init(self)
    self.name = "Thomas y sus Amigos"
    self.effect = "CANSAR\ntodos"
    self.description = "Canta la canción de Thomas.\nCansa a todos los enemigos."
    self.cost = 40
    self.target = "enemies"
    self.kind = "tired_all"
    self.power = {}
    self.fx = { kind = "notes", color = {0.3, 0.5, 1}, sound = "pcdm_chuchu", count = 16 }
    self.mercy = 10
    self.cast_lines = {"* Todos se han quedado embobados."}
    self.tags = { "tired_all" }
end

return spell
