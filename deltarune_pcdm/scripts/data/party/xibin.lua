-- Xibin
local character, super = Class(PartyMember, "xibin")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "xibin", name = "Xibin",
        title = "Aurafarmer\nDueño de Modas\nShanghái y Hoyoverse.",
        hp = 120, atk = 12, def = 3, mag = 8,
        color = {0.96, 0.8, 0.19},
        spells = {"rizz", "gacha_hoyoverse", "momento_incomodo"},
        soul_priority = 1,
        attack_sprite = "effects/attack/mash", attack_sound = "impact",
        gameover = {"Diría que vas a morir.\nPero no lo digo.", "El aura no se rinde."},
    })
end

return character
