-- Utilidades compartidas por las oleadas (ataques enemigos).
local WaveKit = {}

--- Enemigo que lanza la oleada (o el primero activo)
function WaveKit.enemy(wave)
    local a = wave:getAttackers()
    return a[1] or Game.battle:getActiveEnemies()[1]
end

--- Sprite de bala aleatorio del enemigo
function WaveKit.sprite(wave, default)
    local e = WaveKit.enemy(wave)
    local list = e and e.bullet_sprites
    if list and #list > 0 then return "bullets/" .. list[love.math.random(1, #list)] end
    return "bullets/" .. (default or "estrella")
end

--- Palabra aleatoria del enemigo
function WaveKit.word(wave, default)
    local e = WaveKit.enemy(wave)
    local list = e and e.bullet_words
    if list and #list > 0 then return list[love.math.random(1, #list)] end
    return default or "!"
end

--- Dificultad (1 = normal). Los jefes la suben.
function WaveKit.power(wave)
    local e = WaveKit.enemy(wave)
    return (e and e.wave_power) or 1
end

function WaveKit.arena()
    local a = Game.battle.arena
    return a.left, a.top, a.right, a.bottom, a.x, a.y
end

--- Si el enemigo tiene frases para interrumpir (Aroy.exe, Andrés...), a veces
--- habla en mitad del ataque: el combate se PAUSA para poder leerlo.
function WaveKit.maybeInterject(wave, delay)
    local e = WaveKit.enemy(wave)
    if not e or not e.interjections or #e.interjections == 0 then return end
    if love.math.random() > (e.interject_chance or 0.6) then return end
    wave.timer:after(delay or 2.2, function()
        local line = table.remove(e.interjections, love.math.random(1, #e.interjections))
        PCDM.interject(wave, { line }, e.interject_actor or "aroy", e.interject_face or "shout")
    end)
end

return WaveKit
