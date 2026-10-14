-- CAPITÁN ISRAEL
local spell, super = Class(PCDMSpell, "capitan_israel")

function spell:init()
    super.init(self)
    self.name = "CAPITÁN ISRAEL"
    self.effect = "Daña y\ncura"
    self.description = "¡Por las calles de Tel Aviv!\nDaña a todos y cura al equipo."
    self.cost = 70
    self.target = "enemies"
    self.kind = "damage_all"
    self.power = {atk = 7, mag = 6, base = 40, rnd = 20}
    self.fx = { kind = "stars", color = {0.4, 0.7, 1}, sound = "tensionhorn", count = 16 }
    self.mercy = 0
    self.cast_lines = {"* ¡¡CAPITÁN ISRAEL AL RESCATE!!"}
    self.tags = { "damage_all" }
end

function spell:onExtra(user, target)
    Game.battle.timer:after(0.5, function()
        for _, battler in ipairs(Game.battle.party) do
            battler:heal(30)
        end
    end)
end

return spell
