-- ANDRÉS / LORD TIJERAFANG: el jefe final del final verdadero.
-- Ha absorbido las almas del bando malo. Mientras las tenga, casi no le haces daño.
-- Cuando toda esperanza parece perdida, aparece el Papa Francisco.
local enemy, super = Class(PCDMEnemy, "andres")

local SOUL_NAMES = {
    pablo = "Pablo", angelpedro = "Angel Pedro", vito = "Vito Quiles", motos = "Pablo Motos", hormigas = "las Hormigas",
    abascal = "Abascal", trump = "Trump", netanyahu = "Netanyahu", dayron = "Dayron",
}

function enemy:init()
    super.init(self, "tijerafang")
    self:setup({
        name = "Lord Tijerafang", hp = 5200, atk = 9, def = 2, money = 0, power = 1.45,
        sprites = { "tijerita", "lagrima" },
        words = { "NORMAL", "¡RIS!", "¡RAS!", "ESCONDIDO", "NADIE LO SABE", "PROVE ME WRONG" },
        word_color = { 1, 0.2, 0.2 },
        waves = { "almas", "tijeretazo", "palabras" },
        dialogue = { "Voy a destruir\na todo el que no\nsea normal.", "Ris, ras.", "Nadie puede\nsaberlo.", "Tijerafang es\nperfecto.", "¡No me mires\nasí, Ángel!" },
        check = "La fursona de Andrés.[wait:5] Un lobo narcisista\n  que absorbe almas.[wait:5] Por dentro...[wait:5]\n  solo hay un chaval asustado.",
        text = { "* Las almas robadas giran alrededor de\n  Tijerafang.", "* Tijerafang hace ris, ras.", "* En el fondo, Flower Man baila.[wait:5]\n* Nadie sabe por qué.", "* Huele a cartón de Zara quemado." },
        low = "* La armadura de Tijerafang se agrieta.[wait:5]\n* Por las grietas se ve a Andrés.",
        disable_mercy = true,
    })
    self.interjections = {
        "¡¡NADIE PUEDE SABERLO!![wait:5]\n¡¡NADIE!!",
        "¡¡RIS!![wait:5] ¡¡RAS!![wait:5]\n¡¡RIS!![wait:5] ¡¡RAS!!",
        "¿Sabéis lo que es esconderse TODA LA VIDA?",
        "¡¡DEJAD DE MIRARME ASÍ!!",
    }
    self.interject_actor = "andres"
    self.interject_face = "shout"
    self.souls = {}
    for _, id in ipairs(PCDM.BAD_BOSSES) do
        if PCDM.isKilled(id) then table.insert(self.souls, id) end
    end
    if #self.souls == 0 then self.souls = { "pablo", "dayron" } end
    self.damage_mult = 0.06
    self.pope = false
    self.blasters = false
    self:act("Suplicar", { text = { "* Le pides que pare.", "* \"¡¡NO!![wait:5] ¡¡NADIE ME DICE LO QUE TENGO QUE\n  HACER!!\"" } })
    self:act("Ángel: hablarle", { text = function(e)
        e.dialogue_override = "...Ángel..."
        return { "* Ángel le habla con calma:[wait:5]\n  \"Andrés, cariño.[wait:5] No pasa nada por ser\n  como eres.\"", "* Tijerafang tiembla.[wait:5] Por un segundo, baja\n  las tijeras." }
    end }, nil, { "angel" })
end

function enemy:soulsLeft() return #self.souls end

function enemy:onTurnEnd()
    self.turns = (self.turns or 0) + 1
end

--- Mandar un alma al infierno (ACT que da el Papa Francisco)
function enemy:sendSoul()
    local id = table.remove(self.souls, 1)
    if not id then return { "* Ya no quedan almas." } end
    Assets.playSound("spell_pacify")
    Game.battle:shakeCamera(4)
    local lines = {
        "* El Papa Francisco levanta la mano y bendice\n  el alma de " .. SOUL_NAMES[id] .. ".",
        "* ¡¡AL INFIERNO!![wait:5]\n* El alma de " .. SOUL_NAMES[id] .. " cae al infierno gritando.",
    }
    if #self.souls == 0 then
        self.damage_mult = nil
        table.insert(lines, "* ¡Tijerafang ya no tiene almas![wait:5]\n* ¡Ahora es VULNERABLE!")
        self.waves = { "blasters", "tijeretazo", "almas" }
        self:removeAct("Mandar al infierno")
        if not self.blasters then
            self.blasters = true
            table.insert(lines, "* Tijerafang, desesperado, se abre agujeros en\n  las garras con sus propias tijeras...")
            table.insert(lines, "* ...¡y por los agujeros salen calaveras de lobo\n  que disparan rayos!")
            self.dialogue_override = "¡¡RIS!!\n¡¡RAS!!"
        end
    else
        table.insert(lines, "* Quedan " .. #self.souls .. " almas.")
    end
    return lines
end

function enemy:getEncounterText()
    if self.pope and #self.souls > 0 then
        return "* El Papa Francisco reza.[wait:5] Quedan " .. #self.souls .. " almas."
    end
    return super.getEncounterText(self)
end

-- Andrés no muere: Tijerafang se deshace y queda Andrés.
function enemy:onDefeat(damage, battler)
    self.hurt_timer = -1
    Assets.playSound("snowgrave", 0.6, 0.5)
    self:defeat("DEFEATED", false)
    local sprite = self:getActiveSprite()
    Game.battle.timer:tween(1, sprite, { alpha = 0 })
end

function enemy:onDefeatFatal(damage, battler)
    self:onDefeat(damage, battler)
end

function enemy:freeze()
    self:onDefeat()
end

return enemy
