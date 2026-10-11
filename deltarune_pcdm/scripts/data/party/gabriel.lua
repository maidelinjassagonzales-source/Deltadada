-- Gabriel
local character, super = Class(PartyMember, "gabriel")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "gabriel", name = "Gabriel",
        title = "Retramonguer\nFan nº1 de\nSusie.",
        hp = 130, atk = 14, def = 2, mag = 2,
        color = {0.6, 0.3, 0.85},
        spells = {"retramonguer_buster", "cura_mierdera", "discurso_retramonguer"},
        soul_priority = 2,
        attack_sprite = "effects/attack/mash", attack_sound = "impact",
        gameover = {"¡¿Eso es todo lo\nque tienes?! ¡Arriba!", "Susie no se rendiría.\nYO TAMPOCO, JODER."},
    })
end

return character
