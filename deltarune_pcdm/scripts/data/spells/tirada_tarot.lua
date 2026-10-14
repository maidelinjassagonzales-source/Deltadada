-- Tirada de Tarot
local spell, super = Class(PCDMSpell, "tirada_tarot")

function spell:init()
    super.init(self)
    self.name = "Tirada de Tarot"
    self.effect = "¿¿¿???"
    self.description = "Saca una carta del tarot.\nPuede pasar CUALQUIER cosa."
    self.cost = 25
    self.target = "enemy"
    self.kind = "custom"
    self.power = {mag = 14, base = 80, rnd = 30}
    self.fx = { kind = "cards", color = {0.95, 0.9, 0.8}, sound = "item", count = 16 }
    self.mercy = 0
    self.cast_lines = nil
    self.tags = { "custom" }
end

local CARDS = {
    { "LA TORRE", "* ¡La Torre! Destrucción total." },
    { "EL SOL", "* ¡El Sol! Todo el equipo se cura." },
    { "LA LUNA", "* ¡La Luna! Los enemigos se quedan dormidos." },
    { "LA MUERTE", "* ¡La Muerte!\n* ...Xibin, en tres años. Como siempre." },
}

function spell:getCastMessage(user, target)
    self.card = love.math.random(1, #CARDS)
    return "* " .. user.chara:getName() .. " sacó una carta: [color:yellow]" .. CARDS[self.card][1] .. "[color:reset]!\n" .. CARDS[self.card][2]
end

function spell:applyTo(user, t)
    local c = self.card or 1
    if c == 1 then
        t:flash()
        t:hurt(self:calc(user, t) * 2, user)
    elseif c == 2 then
        for _, battler in ipairs(Game.battle.party) do battler:heal(60) end
    elseif c == 3 then
        for _, e in ipairs(Game.battle:getActiveEnemies()) do e:setTired(true) end
    else
        t:addMercy(10)
    end
end

return spell
