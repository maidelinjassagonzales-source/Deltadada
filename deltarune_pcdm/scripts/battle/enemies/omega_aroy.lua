-- AROY.EXE (forma OMEGA): ruta FURRYGRAVE. Ha absorbido las almas del bando malo.
-- Mientras las tenga es invencible. Llámalas: se rebelan y se unen a Dayron.
local enemy, super = Class(PCDMEnemy, "omega_aroy")

local SOUL_NAMES = {
    pablo = "Pablo", angelpedro = "Angel Pedro", vito = "Vito Quiles", motos = "Pablo Motos", hormigas = "las Hormigas",
    abascal = "Abascal", trump = "Trump", netanyahu = "Netanyahu",
}

function enemy:init()
    super.init(self, "omega_aroy")
    self:setup({
        name = "AROY.EXE", hp = 3000, atk = 9, def = 2, money = 0, lethal = true, power = 1.5,
        sprites = { "lagrima", "glitch" },
        words = { "SOY EL PUTO AMO", "BECA MEC", "GOOD BOY", "MI JUEGO", "BORRAR", "TDAH" },
        word_color = { 1, 0.2, 0.2 },
        waves = { "glitch", "almas", "palabras" },
        dialogue = { "¡¡SOY EL PUTO\nAMO!!", "¡¡ESTE JUEGO LO\nHE HECHO YO!!", "¡¡CON LA BECA\nMEC!!", "Bad boy.\nBAD BOY.", "Te voy a\nBORRAR." },
        check = "El creador.[wait:5] Omnipotente.[wait:5] Enfadado.\n* Tiene TDAH y la Beca MEC.",
        text = { "* La pantalla de Aroy.exe parpadea.", "* Las almas del bando malo gritan dentro de\n  la tele.", "* Huele a ozono y a sangre hiperrealista." },
        disable_mercy = true,
        death = { "Yo...\nera el...\nputo amo..." },
    })
    self.souls = {}
    for id, _ in pairs(SOUL_NAMES) do
        if PCDM.isKilled(id) then table.insert(self.souls, id) end
    end
    table.sort(self.souls)
    if #self.souls == 0 then self.souls = { "pablo", "trump" } end
    self.damage_mult = 0.0001
    self.interjections = {
        "¿TE CREES MUY LISTO, DAYRON?",
        "¡¡ESTO NO ESTABA EN EL GUION!!",
        "¿Sabes cuánto me costó programar esto?\nUN MONTÓN.",
        "...oye, ¿has visto el vídeo del perro\nque hace skate? ...¡¡NO, CÉNTRATE!!",
    }
    self:act("Llamar al alma", { func = function(e, battler) return e:freeSoul() end }, "Libera\nun alma")
end

function enemy:freeSoul()
    local id = table.remove(self.souls, 1)
    if not id then return { "* Ya no quedan almas dentro de Aroy." } end
    Assets.playSound("sparkle_gem")
    self.health = math.max(1, self.health - 300)
    self:statusMessage("damage", 300, { 1, 0.3, 0.3 })
    self:shake(8)
    for _, b in ipairs(Game.battle.party) do b:heal(30) end
    local lines = {
        "* Llamas al alma de " .. SOUL_NAMES[id] .. ".",
        "* ¡El alma de " .. SOUL_NAMES[id] .. " se rebela contra Aroy.exe!\n* \"¡Dayron es de los nuestros!\"",
    }
    if #self.souls == 0 then
        self.damage_mult = nil
        table.insert(lines, "* ¡Todas las almas se han rebelado!\n* ¡AROY.EXE ES VULNERABLE!")
        self:removeAct("Llamar al alma")
    else
        table.insert(lines, "* Quedan " .. #self.souls .. " almas atrapadas.")
    end
    return lines
end

return enemy
