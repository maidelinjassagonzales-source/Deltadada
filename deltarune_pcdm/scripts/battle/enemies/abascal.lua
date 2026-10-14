-- SANTIAGO ABASCAL (a caballo). Bando malo.
local enemy, super = Class(PCDMEnemy, "abascal")

function enemy:init()
    super.init(self, "abascal_caballo")
    self:setup({
        name = "Abascal", hp = 1800, atk = 8, def = 3, money = 180, bad_id = "abascal", power = 1.3,
        sprites = { "herradura", "papeleta" },
        words = { "¡RECONQUISTA!", "¡A CABALLO!", "¡ESPAÑA!", "COVADONGA", "¡A POR ELLOS!" },
        word_color = { 0.4, 0.9, 0.3 },
        waves = { "carga", "lluvia", "palabras" },
        dialogue = { "¡A CABALLO!", "¡Reconquista!", "Esto es España.\nAquí se viene\na caballo.", "¿Tú sabes montar?\nYo tampoco.", "¡Covadonga!" },
        check = "Va a caballo a todas partes.[wait:5]\n* El caballo no ha elegido estar aquí.",
        text = { "* Abascal pide que le saquen fotos a caballo.", "* El caballo suspira.", "* Huele a cortijo y a testosterona de bote.", "* Abascal grita \"¡España!\" sin motivo." },
        low = "* A Abascal le cuesta mantenerse en la silla.",
        spareable = "* Abascal se baja del caballo.[wait:5] Por fin.",
        death = { "¡España...!" },
        acts = {
            { "Zanahoria al caballo", { mercy = 30, text = { "* Le das una zanahoria al caballo.", "* El caballo te mira con amor.[wait:5]\n* Se está poniendo de tu lado." } } },
            { "Bajarle del caballo", { mercy = 20, tired = true, text = "* Tiras de la pierna de Abascal.\n* Se queda colgando.[wait:5] [color:blue]CANSADO[color:reset]." } },
            { "Hablar de historia", { mercy = 25, text = { "* Le cuentas que en España ha habido\n  romanos, visigodos, árabes, judíos, gitanos...", "* A Abascal le da un cortocircuito." } } },
        },
    })
end

-- Si Abascal muere, el caballo (por fin libre) se va trotando
function enemy:onKilled()
    local x, y = self:getRelativePos(self.width / 2, self.height, Game.battle)
    local horse = Sprite("objects/caballo", x - 70, y - 100)
    horse:setScale(2)
    horse:play(0.12, true)
    horse.layer = BATTLE_LAYERS and BATTLE_LAYERS["above_battlers"] or 600
    Game.battle:addChild(horse)
    Game.battle.timer:tween(1.6, horse, { x = SCREEN_WIDTH + 40 }, "in-quad", function() horse:remove() end)
end

return enemy
