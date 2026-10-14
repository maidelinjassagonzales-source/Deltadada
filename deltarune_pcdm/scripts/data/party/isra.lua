-- Isra
local character, super = Class(PartyMember, "isra")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "isra", name = "Isra",
        title = "Capitán Israel\nProtector de\nTel Aviv. Hic.",
        hp = 140, atk = 11, def = 3, mag = 4,
        color = {0.35, 0.6, 1},
        spells = {"chupito", "cupula_hierro", "capitan_israel"},
        soul_priority = 1,
        attack_sprite = "effects/attack/mash", attack_sound = "impact",
        gameover = {"Hic... ¡arriba!\nQue aún no es viernes.", "¡El Capitán Israel\nnunca se rinde!"},
    })
end

return character
