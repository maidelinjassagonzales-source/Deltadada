-- NPCs y objetos genéricos: guaguas, móvil...
return {
    guagua = function(c, stop)
        if not PCDM.flag("guaguas_activas") then
            c:text("* Una guagua azul de la Global.[wait:5]\n* Está aparcada.[wait:5] No hay conductor.")
            return
        end
        PCDM.setFlag("parada_" .. stop, true)
        Assets.playSound("pcdm_bocina")
        c:text("* ¡Guagua Global![wait:5] Gratis para todo el mundo.\n* ¿A dónde vamos, mi niño?", "happy", "paco")
        local dest = {}
        for _, s in ipairs(GuaguaStop.STOPS) do
            if s.id ~= stop and PCDM.flag("parada_" .. s.id) then
                table.insert(dest, s)
            end
        end
        if #dest == 0 then
            c:text("* Todavía no conoces otras paradas.[wait:5]\n* ¡Explora un poco, chacho!", "neutral", "paco")
            return
        end
        local names = {}
        for i = 1, math.min(3, #dest) do table.insert(names, dest[i].name) end
        table.insert(names, "Quedarse")
        local ch = c:choicer(names)
        if ch > math.min(3, #dest) then return end
        local d = dest[ch]
        c:wait(c:fadeOut(0.4))
        Assets.playSound("pcdm_bocina")
        c:loadMap(d.map, d.marker, "down")
        c:wait(c:fadeIn(0.4))
        c:text("* (Habéis llegado a: " .. d.name .. ".)")
    end,
    movil = function(c)
        Assets.playSound("phone", 0.6)
        if Game:isLight() then
            c:text("* Grupo \"PCDM 2ºB\"[wait:5] (47 mensajes)")
            c:text("* [color:ff9ccf]Ángel[color:reset]: chicos alguien tiene los apuntes\n  de mates?")
            c:text("* [color:b57edc]Gabriel[color:reset]: (sticker de Susie)")
            c:text("* [color:a8322d]Dayron[color:reset]: (sticker de Dayron)\n* [color:a8322d]Dayron[color:reset]: (sticker de Dayron)\n* [color:a8322d]Dayron[color:reset]: (sticker de Dayron)")
            c:text("* [color:f5cd30]Xibin[color:reset]: 2x1 en Modas Shanghái este finde.")
            c:text("* [color:c77dff]Carmen[color:reset]: xibin te quedan 2 años y 11 meses")
        else
            c:text("* Sin cobertura.[wait:5] Estás en el Dark World.")
            c:text("* ...[wait:10]Te llega un mensaje igualmente.")
            c:text("* [color:ff3a3a]AROY.EXE[color:reset]: q tal va todo\n* [color:ff3a3a]AROY.EXE[color:reset]: haz lo que te digo eh\n* [color:ff3a3a]AROY.EXE[color:reset]: soy el puto amo")
        end
    end,
}
