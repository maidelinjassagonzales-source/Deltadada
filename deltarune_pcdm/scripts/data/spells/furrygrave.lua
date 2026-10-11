-- FURRYGRAVE: la habilidad MÁS PODEROSA de Lucía. Daño fatal a todos los enemigos.
local spell, super = Class(Spell, "furrygrave")

function spell:init()
    super.init(self)
    self.name = "FURRYGRAVE"
    self.effect = "FATAL"
    self.description = "La técnica prohibida de Lucía.\nDaño FATAL a todos los enemigos."
    self.cost = 100
    self.target = "enemies"
    self.tags = { "furry", "fatal", "damage" }
end

function spell:getCastMessage(user, target)
    if PCDM.flag("ruta_furrygrave") then
        return "* " .. user.chara:getName() .. " usó FURRYGRAVE."
    end
    return "* " .. user.chara:getName() .. " usó [color:ff7ad9]FURRYGRAVE[color:reset]!\n* ¡¡EL PODER DEL FANDOM!!"
end

function spell:onCast(user, target)
    local object = FurryGraveSpell(user)
    object.damage = self:getDamage(user, target)
    object.layer = BATTLE_LAYERS["above_ui"]
    Game.battle:addChild(object)
    return false
end

function spell:getDamage(user, target)
    return math.ceil((user.chara:getStat("magic") * 40) + 600)
end

return spell
