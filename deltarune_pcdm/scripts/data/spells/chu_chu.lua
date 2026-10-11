-- CHU-CHU
local spell, super = Class(PCDMSpell, "chu_chu")

function spell:init()
    super.init(self)
    self.name = "CHU-CHU"
    self.effect = "Daño\na todos"
    self.description = "¡CHU-CHUUU! Julio se convierte en tren\ny atropella a todos los enemigos."
    self.cost = 45
    self.target = "enemies"
    self.kind = "damage_all"
    self.power = {atk = 6, mag = 4, base = 40, rnd = 15}
    self.fx = { kind = "smoke", color = {0.85, 0.85, 0.85}, sound = "pcdm_chuchu", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡¡CHUUUU CHUUUUU!!"}
    self.tags = { "damage_all" }
end

return spell
