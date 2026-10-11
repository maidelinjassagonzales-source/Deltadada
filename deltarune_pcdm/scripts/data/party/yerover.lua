-- Yerover
local character, super = Class(PartyMember, "yerover")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "yerover", name = "Yerover",
        title = "Twink Supremo\nMain Terry en\nSmash Bros.",
        hp = 100, atk = 13, def = 1, mag = 3,
        color = {1, 0.82, 0.25},
        spells = {"power_geyser", "buster_wolf"},
        soul_priority = 1,
        attack_sprite = "effects/attack/mash", attack_sound = "impact",
        gameover = {"ARE YOU OKAY?!\n¡Levántate, bebé!", "Hey, come on!\n¡Que no se diga!"},
    })
end

return character
