-- RUTA FURRYGRAVE: el bando malo también cae.
local encounter, super = Class(PCDMEncounter, "sg_malos1")

function encounter:init()
    super.init(self)
    self.text = "* Pablo y Angel Pedro se acercan."
    self:setMusic("ruta_furrygrave")
    self.list = {}
    table.insert(self.list, self:addEnemy("pablo"))
    table.insert(self.list, self:addEnemy("angelpedro"))
    for _, e in ipairs(self.list) do
        e.max_health = math.floor(e.max_health * 0.35)
        e.health = e.max_health
        e.disable_mercy = true
        e.lethal = true
    end
end

return encounter
