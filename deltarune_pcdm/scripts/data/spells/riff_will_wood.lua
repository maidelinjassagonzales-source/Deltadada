-- Riff de Will Wood
local spell, super = Class(PCDMSpell, "riff_will_wood")

function spell:init()
    super.init(self)
    self.name = "Riff de Will Wood"
    self.effect = "Daño\na todos"
    self.description = "Un riff caótico de Will Wood.\nDaño a todos los enemigos."
    self.cost = 32
    self.target = "enemies"
    self.kind = "damage_all"
    self.power = {mag = 6, base = 30, rnd = 10}
    self.fx = { kind = "notes", color = {1, 0.3, 0.3}, sound = "laz_c", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡Nadie conoce esta canción!"}
    self.tags = { "damage_all" }
end

return spell
