local encounter, super = Class(PCDMEncounter, "stickers")

function encounter:init()
    super.init(self)
    self.text = "* ¡¡¡STICKERS DE DAYRON!!!\n* Son demasiados."
    self:addEnemy("sticker1")
    self:addEnemy("sticker2")
    self:addEnemy("sticker3")
end

return encounter
