-- Dayron
local character, super = Class(PartyMember, "dayron")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "dayron", name = "Dayron",
        title = "Fife Hetero\nValores\ntradicionales.",
        hp = 140, atk = 13, def = 3, mag = 5,
        color = {0.66, 0.2, 0.18},
        spells = {"pegatinazo"},
        soul_priority = 4,
        attack_sprite = "effects/attack/mash", attack_sound = "impact",
        gameover = {"Levántate.\nSé un hombre.", "Esto es lo natural."},
    })
end

return character
