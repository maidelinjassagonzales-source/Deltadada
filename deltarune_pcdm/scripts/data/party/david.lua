-- David
local character, super = Class(PartyMember, "david")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "david", name = "David",
        title = "Indie Kid\nFan de Will Wood\ny Tally Hall.",
        hp = 105, atk = 10, def = 2, mag = 7,
        color = {0.9, 0.25, 0.25},
        spells = {"riff_will_wood", "indie_desconocido", "tally_hall_hall"},
        soul_priority = 1,
        attack_sprite = "effects/attack/cut", attack_sound = "laz_c",
        gameover = {"Venga, que esto\nno lo conoce nadie.", "Levántate.\nPor Will Wood."},
    })
end

return character
