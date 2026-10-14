-- Palabras que caen (mensajes, insultos, preguntas...).
local Wave, super = Class(Wave, "palabras")

function Wave:init()
    super.init(self)
    self.time = 6
end

function Wave:onStart()
    local p = WaveKit.power(self)
    local e = WaveKit.enemy(self)
    local col = e and e.word_color or { 1, 1, 1 }
    self.timer:every(0.55 / p, function()
        local l, t, r, b = WaveKit.arena()
        local x = MathUtils.random(l + 10, r - 10)
        local bl = self:spawnBullet("pcdm", x, t - 30, { text = WaveKit.word(self), color = col, dir = math.rad(90), speed = 2.5 + p * 0.8 })
        bl.remove_offscreen = false
        self.timer:after(5, function() if bl.parent then bl:remove() end end)
    end)
end

return Wave
