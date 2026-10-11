-- Lucía
local character, super = Class(PartyMember, "lucia")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "lucia", name = "Lucía",
        title = "Furra Legendaria\nOtaku. Puede usar\nFURRYGRAVE.",
        hp = 110, atk = 10, def = 2, mag = 9,
        color = {0.71, 0.55, 0.85},
        spells = {"furry_shock", "abrazo_furro", "furrygrave"},
        soul_priority = 3,
        attack_sprite = "effects/attack/cut", attack_sound = "laz_c",
        gameover = {"¡No te rindas!\n¡Por el fandom!", "Mandarina te está\nesperando en casa..."},
    })
end

return character
