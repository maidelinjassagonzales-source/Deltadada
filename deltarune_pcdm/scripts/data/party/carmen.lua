-- Carmen
local character, super = Class(PartyMember, "carmen")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "carmen", name = "Carmen",
        title = "Bruja Vecina\nLee el tarot.\nNunca falla.",
        hp = 95, atk = 8, def = 2, mag = 11,
        color = {0.55, 0.25, 0.75},
        spells = {"tirada_tarot", "profecia"},
        soul_priority = 1,
        attack_sprite = "effects/attack/cut", attack_sound = "laz_c",
        gameover = {"Las cartas dicen\nque te levantes.", "Hoy no mueres.\nXibin sí. En 3 años."},
    })
end

return character
