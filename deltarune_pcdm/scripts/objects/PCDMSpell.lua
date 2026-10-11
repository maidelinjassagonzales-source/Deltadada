-- Base de todas las magias del mod. Cada personaje tiene habilidades distintas,
-- pero comparten este motor: daño, curas, cansancio, piedad, etc.
local PCDMSpell, super = Class(Spell)

function PCDMSpell:init()
    super.init(self)
    self.kind = "damage"       -- damage, damage_all, heal, heal_all, tired, tired_all, mercy, mercy_all, pacify, fatal_all, buff_party, custom
    self.power = { atk = 0, mag = 10, base = 40, rnd = 10 }
    self.fx = { kind = "stars", color = { 1, 1, 1 }, sound = "spellcast", count = 14 }
    self.cast_lines = nil
    self.mercy = 0
end

function PCDMSpell:getCastMessage(user, target)
    local msg = "* " .. user.chara:getName() .. " usó " .. self:getCastName() .. "!"
    if self.cast_lines then
        msg = msg .. "\n" .. self.cast_lines[love.math.random(1, #self.cast_lines)]
    end
    return msg
end

function PCDMSpell:calc(user, target)
    local p = self.power
    local v = (p.atk or 0) * user.chara:getStat("attack") + (p.mag or 0) * user.chara:getStat("magic") + (p.base or 0)
    if p.rnd and p.rnd > 0 then v = v + love.math.random(0, p.rnd) end
    if target and target.defense and (self.kind == "damage" or self.kind == "damage_all") then
        v = v - target.defense * 2
    end
    return math.max(1, math.floor(v))
end

function PCDMSpell:spawnFX(target)
    if not target or not target.getRelativePos then return end
    local x, y = target:getRelativePos(target.width / 2, target.height / 2, Game.battle)
    local fx = PCDMSpellFX(x, y, self.fx.kind, self.fx.color, self.fx.count, self.fx.duration)
    Game.battle:addChild(fx)
end

local function asList(target)
    if type(target) == "table" and not isClass(target) then return target end
    return { target }
end

function PCDMSpell:applyTo(user, t)
    local k = self.kind
    if k == "damage" or k == "damage_all" then
        local dmg = self:calc(user, t)
        t:flash()
        t:hurt(dmg, user)
    elseif k == "heal" or k == "heal_all" then
        local amount = self:calc(user, t)
        amount = Game.battle:applyHealBonuses(amount, user.chara, t.chara)
        t:heal(amount)
    elseif k == "tired" or k == "tired_all" then
        if t.setTired then t:setTired(true) end
        if self.mercy > 0 and t.addMercy then t:addMercy(self.mercy) end
    elseif k == "mercy" or k == "mercy_all" then
        if t.addMercy then t:addMercy(self.mercy) end
    elseif k == "pacify" then
        if t:isTired() or t.mercy >= 100 then
            t:spare(true)
            Assets.playSound("spell_pacify")
        else
            t:addMercy(self.mercy > 0 and self.mercy or 10)
        end
    elseif k == "fatal_all" then
        local dmg = self:calc(user, t)
        t.hit_count = 0
        t:hurt(dmg, user, t.onDefeatFatal)
        if t.health > 0 then t:flash() end
    end
end

function PCDMSpell:onCast(user, target)
    if self.fx.sound then Assets.playSound(self.fx.sound, 0.8) end
    local list = asList(target)
    local delay = 0
    for _, t in ipairs(list) do
        Game.battle.timer:after(delay, function()
            self:spawnFX(t)
            if t.parent or t.chara then
                self:applyTo(user, t)
            end
        end)
        delay = delay + 0.08
    end
    if self.kind == "buff_party" then
        self:onBuff(user)
    end
    if self.onExtra then self:onExtra(user, target) end
    Game.battle.timer:after(delay + 0.4, function()
        Game.battle:finishActionBy(user)
    end)
    return false
end

function PCDMSpell:onBuff(user) end

return PCDMSpell
