-- Créditos finales.
local PCDMCredits, super = Class(Object)

local LINES = {
    { "DELTARUNE PCDM", 1.4 },
    { "Capítulo 1: ¡SAL DEL ARMARIO!", 0.9 },
    { "" },
    { "Un mod de DELTARUNE y UNDERTALE", 0.8 },
    { "" },
    { "Creador del universo", 0.7 },
    { "AROY.EXE (el puto amo)", 1 },
    { "con la ayuda de la BECA MEC", 0.7 },
    { "" },
    { "Protagonista", 0.7 },
    { "Lucía (PCDM)", 1 },
    { "" },
    { "Bando bueno", 0.7 },
    { "Yerover · Gabriel · Isra · Ángel · Alejandro", 0.75 },
    { "Carmen · David · Julio · Xibin", 0.75 },
    { "" },
    { "Bando malo", 0.7 },
    { "Pablo · Dayron · Angel Pedro · Andrés", 0.75 },
    { "" },
    { "Paradero desconocido", 0.7 },
    { "Aridai (y Daniel)", 0.75 },
    { "" },
    { "Personajes nuevos", 0.7 },
    { "Fernanda · Brayan · Profe Mari Carmen", 0.75 },
    { "Paco el Guagüero · Doña Candelaria · Príncipe Percha", 0.75 },
    { "" },
    { "Apariciones estelares (parodias)", 0.7 },
    { "Pedro Sánchez · Zohran Mamdani · Pablo Iglesias", 0.7 },
    { "Yolanda Díaz · El Pana Vi · Borja Iglesias · Héctor Bellerín", 0.7 },
    { "Papa Francisco · Flower Man", 0.7 },
    { "" },
    { "Villanos (parodias)", 0.7 },
    { "Trump · Netanyahu · Abascal · Vito Quiles · Pablo Motos", 0.7 },
    { "Trancas y Barrancas", 0.7 },
    { "" },
    { "Guion, programación y sprites originales", 0.7 },
    { "hechos para este mod", 0.7 },
    { "" },
    { "Basado en DELTARUNE y UNDERTALE de Toby Fox", 0.7 },
    { "Motor: Kristal", 0.7 },
    { "" },
    { "Ningún furro fue maltratado", 0.7 },
    { "durante la creación de este mod.", 0.7 },
    { "" },
    { "GRACIAS POR JUGAR", 1.2 },
}

function PCDMCredits:init(title, color)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.layer = 1800
    self.title = title or "FIN"
    self.tcolor = color or { 1, 1, 1 }
    self.timer = 0
    self.scroll = SCREEN_HEIGHT
    self.done = false
    self.font = Assets.getFont("main_mono")
end

function PCDMCredits:update()
    super.update(self)
    self.timer = self.timer + DT
    if self.timer > 3 then
        local speed = Input.down("confirm") and 4 or 1
        self.scroll = self.scroll - 0.9 * speed * DTMULT
    end
    local total = #LINES * 40 + 200
    if self.scroll < -total or (Input.pressed("cancel") and self.timer > 3) then
        self.done = true
    end
end

function PCDMCredits:draw()
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setFont(self.font)
    if self.timer < 3.5 then
        local a = math.min(1, self.timer)
        Draw.setColor(self.tcolor[1], self.tcolor[2], self.tcolor[3], a)
        love.graphics.printf(self.title, 0, SCREEN_HEIGHT / 2 - 20, SCREEN_WIDTH, "center")
    else
        local y = self.scroll
        for _, l in ipairs(LINES) do
            local s = l[2] or 1
            Draw.setColor(1, 1, 1, 1)
            love.graphics.printf(l[1], 0, y, SCREEN_WIDTH / s, "center", 0, s, s)
            y = y + 40
        end
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return PCDMCredits
