-- NPCs y objetos genéricos: guaguas, móvil...
return {
    guagua = function(c, stop)
        PCDM.setFlag("parada_" .. stop, true)
        if not PCDM.flag("guaguas_activas") then
            c:text("* Una guagua azul de la Global.[wait:5]\n* El cartel pone: \"FUERA DE SERVICIO\".")
            c:text("* (Las Guaguas Global todavía no funcionan.\n  Ya llegará el día.)")
            return
        end
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
        -- el menú de elegir tiene 4 huecos: si hay más destinos, se pasa de página
        local d, page = nil, 1
        while not d do
            local first = (page - 1) * 2 + 1
            local names, map = {}, {}
            local fits_all = #dest - first + 1 <= 3
            local last = fits_all and #dest or first + 1
            for i = first, last do
                table.insert(names, dest[i].short or dest[i].name)
                table.insert(map, dest[i])
            end
            if not fits_all then table.insert(names, "Más...") end
            table.insert(names, "Quedarse")
            local ch = c:choicer(names)
            if ch <= #map then
                d = map[ch]
            elseif names[ch] == "Más..." then
                page = page + 1
            else
                return
            end
        end
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
