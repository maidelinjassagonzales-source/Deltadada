-- Gacha Hoyoverse
local spell, super = Class(PCDMSpell, "gacha_hoyoverse")

function spell:init()
    super.init(self)
    self.name = "Gacha Hoyoverse"
    self.effect = "¿5★?"
    self.description = "Tira del gacha de Hoyoverse.\nSi sale 5★, destroza."
    self.cost = 30
    self.target = "enemy"
    self.kind = "custom"
    self.power = {}
    self.fx = { kind = "stars", color = {1, 0.85, 0.3}, sound = "sparkle_glock", count = 16 }
    self.mercy = 0
    self.cast_lines = nil
    self.tags = { "custom" }
end

function spell:getCastMessage(user, target)
    local r = love.math.random(1, 100)
    if r <= 12 then
        self.stars = 5
    elseif r <= 45 then
        self.stars = 4
    else
        self.stars = 3
    end
    local txt = { [5] = "* ¡¡¡5★!!! ¡¡¡LEGENDARIO!!!", [4] = "* 4★. No está mal.", [3] = "* 3★... Un arma azul. Qué asco." }
    return "* Xibin tiró del gacha de su propia empresa.\n" .. txt[self.stars]
end

function spell:applyTo(user, t)
    local dmg = ({ [5] = 650, [4] = 210, [3] = 35 })[self.stars or 3]
    t:flash()
    t:hurt(dmg + love.math.random(0, 30), user)
end

return spell
