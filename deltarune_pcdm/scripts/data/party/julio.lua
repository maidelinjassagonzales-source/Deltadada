-- Julio
local character, super = Class(PartyMember, "julio")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "julio", name = "Julio",
        title = "Furro Tren\nCHU CHU.\nFan de Thomas.",
        hp = 125, atk = 12, def = 3, mag = 4,
        color = {0.18, 0.44, 0.85},
        spells = {"chu_chu", "arepazo", "thomas_amigos"},
        soul_priority = 1,
        attack_sprite = "effects/attack/mash", attack_sound = "impact",
        gameover = {"¡Chu chu!\n¡Arriba, pana!", "Thomas nunca\nse descarrila."},
    })
end

return character
