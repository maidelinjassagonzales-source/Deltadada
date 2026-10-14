-- RUTA FURRYGRAVE: el bando malo también cae.
local encounter, super = Class(PCDMEncounter, "sg_malos3")

function encounter:init()
    super.init(self)
    self.text = "* Trump, Netanyahu y dos hormigas."
    self:setMusic("ruta_furrygrave")
    self.list = {}
    table.insert(self.list, self:addEnemy("trump"))
    table.insert(self.list, self:addEnemy("netanyahu"))
    table.insert(self.list, self:addEnemy("trancas"))
    for _, e in ipairs(self.list) do
        e.max_health = math.floor(e.max_health * 0.35)
        e.health = e.max_health
        e.disable_mercy = true
        e.lethal = true
    end
end

return encounter
