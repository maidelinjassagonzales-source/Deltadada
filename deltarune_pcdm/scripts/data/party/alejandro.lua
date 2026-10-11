-- Alejandro
local character, super = Class(PartyMember, "alejandro")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "alejandro", name = "Alejandro",
        title = "Kralseiano\nJakoSherry en\nRoblox.",
        hp = 105, atk = 10, def = 2, mag = 8,
        color = {0.18, 0.63, 0.29},
        spells = {"jakosherry", "canon_kralsei", "hidden_in_the_sand"},
        soul_priority = 1,
        attack_sprite = "effects/attack/cut", attack_sound = "laz_c",
        gameover = {"¡Kralsei cree en ti!", "Esto no es el final.\nTally Hall lo sabe."},
    })
end

return character
