-- Base de los combates del Dark World.
local PCDMEncounter, super = Class(Encounter)

function PCDMEncounter:init()
    super.init(self)
    self.music = PCDM.musicId("combate") or "battle"
    self.background = true
    self.flowerman = false
end

function PCDMEncounter:getVictoryText(text, money, xp)
    return "* ¡Has ganado!\n* Conseguiste " .. money .. " " .. Game:getConfig("darkCurrencyShort") .. "."
end

function PCDMEncounter:onBattleStart()
    if self.music_section == "jefe_motos" and Game.battle.music then
        PCDM.playReversedSlowed(Game.battle.music, "jefe_motos")
    end
end

function PCDMEncounter:setMusic(section)
    self.music_section = section
    if section == "jefe_motos" then
        self.music = nil
    else
        self.music = PCDM.musicId(section) or PCDM.musicId("jefe") or "battle"
    end
end

function PCDMEncounter:draw(fade)
    super.draw(self, fade)
    if self.flowerman then
        local t = Kristal.getTime and Kristal.getTime() or love.timer.getTime()
        local f = math.floor(t * 4) % 2 + 1
        local tex = Assets.getTexture("objects/flowerman_" .. f)
        if tex then
            Draw.setColor(1, 1, 1, 0.55 * fade)
            for i = 0, 3 do
                Draw.draw(tex, 40 + i * 160, 60 + math.sin(t * 2 + i) * 6, 0, 2, 2)
            end
            Draw.setColor(1, 1, 1, 1)
        end
    end
end

return PCDMEncounter
