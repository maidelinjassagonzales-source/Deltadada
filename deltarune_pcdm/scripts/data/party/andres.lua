-- Andrés (solo jugable en su escena del Light World)
local character, super = Class(PartyMember, "andres")

function character:init()
    super.init(self)
    PCDM.setupParty(self, {
        id = "andres", name = "Andrés",
        title = "Compañero amable\n...¿Seguro?",
        hp = 120, atk = 12, def = 2, mag = 6,
        color = {0.5, 0.1, 0.1},
        spells = {},
        soul_priority = 0,
    })
    self.has_spells = false
end

return character
