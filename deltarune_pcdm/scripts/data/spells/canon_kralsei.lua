-- Canon Kralsei
local spell, super = Class(PCDMSpell, "canon_kralsei")

function spell:init()
    super.init(self)
    self.name = "Canon Kralsei"
    self.effect = "Curar\nequipo"
    self.description = "El poder del ship más canon de la\nhistoria. Cura a todo el equipo."
    self.cost = 30
    self.target = "party"
    self.kind = "heal_all"
    self.power = {mag = 3, base = 15}
    self.fx = { kind = "hearts", color = {0.5, 1, 0.6}, sound = "power", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* Kris y Ralsei os bendicen."}
    self.tags = { "heal_all" }
end

return spell
