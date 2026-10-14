-- JEFE FINAL: LORD TIJERAFANG (Andrés). Con Flower Man de fondo y el Papa Francisco al rescate.
local encounter, super = Class(PCDMEncounter, "andres")

function encounter:init()
    super.init(self)
    self.text = "* ¡LORD TIJERAFANG!\n* Las almas robadas gritan a su alrededor."
    self:setMusic("jefe_andres")
    self.flowerman = true
    self.turn = 0
    self.boss = self:addEnemy("andres")
end

function encounter:onTurnStart()
    self.turn = self.turn + 1
end

local function partyInDanger()
    for _, b in ipairs(Game.battle.party) do
        if b.chara:getHealth() <= b.chara:getStat("health") * 0.35 then return true end
    end
    return false
end

function encounter:getDialogueCutscene()
    local boss = self.boss
    if boss and not boss.pope and (self.turn >= 3 or (self.turn >= 2 and partyInDanger())) then
        boss.pope = true
        return function(c)
            c:text("* Las almas protegen a Tijerafang.[wait:5]\n* Vuestros golpes no le hacen casi nada.")
            c:text("* Toda esperanza parece perdida...")
            c:wait(0.5)
            Assets.playSound("bell")
            c:shakeCamera(4)
            local id = PCDM.musicId("papa_francisco")
            if id and Game.battle.music then Game.battle.music:play(id) end
            local pope = Sprite("chars/papa/dark/walk/down_1", 500, -80)
            pope:setScale(2)
            pope.layer = BATTLE_LAYERS["above_battlers"]
            Game.battle:addChild(pope)
            pope:slideTo(500, 60, 1.2)
            c:wait(1.3)
            c:text("* ...¡El Papa Francisco ha bajado del cielo!", "smile", "papa")
            c:text("* Hijos míos.[wait:5] ¿Quién soy yo para juzgar?\n* ...[wait:10]Bueno.[wait:5] A este sí.", "neutral", "papa")
            c:text("* Esas almas no son suyas.[wait:5] Mandémoslas\n  a donde tienen que estar.", "angry", "papa")
            c:text("* (¡Ahora podéis ACTUAR: [color:yellow]Mandar al infierno[color:reset]!)")
            boss:act("Mandar al infierno", { func = function(e) return e:sendSoul() end }, "Con ayuda\ndel Papa")
            for _, b in ipairs(Game.battle.party) do b:heal(60) end
            Game:giveTension(40)
            c:battlerText(boss, "¿¡EL PAPA!?\n¡¡ESTO NO\nES JUSTO!!")
            boss.pope_sprite = pope
        end
    end
end

return encounter
