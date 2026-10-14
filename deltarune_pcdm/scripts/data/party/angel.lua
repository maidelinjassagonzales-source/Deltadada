-- Ángel
local character, super = Class(PartyMember, "angel")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "angel", name = "Ángel",
        title = "Femboy Gitano\nFuturo presidente\ndel PCE.",
        hp = 120, atk = 9, def = 2, mag = 8,
        color = {1, 0.48, 0.72},
        spells = {"beca_universal", "zuzu", "expropiacion"},
        soul_priority = 1,
        attack_sprite = "effects/attack/cut", attack_sound = "laz_c",
        gameover = {"¡Ay, no, cariño!\n¡Levántate!", "Zuzu cree en ti.\nYo también."},
    })
end

return character
