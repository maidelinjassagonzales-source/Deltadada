"""Todos los mapas del mod DELTARUNE PCDM.  Ejecuta:  python3 herramientas/mapas.py

Leyenda de tiles (ver mapdsl.py):
  .  suelo   ,  suelo 2   :  suelo 3   =  camino/alfombra
  #  pared arriba*   W  pared*   P  pared deco*   V  pared deco 2*
  d l p  objetos 1x1*   r f  decoración de suelo   _ acantilado*   ~ agua*
  A B C E  objetos grandes 2x2* (A=16, B=18, C=20, E=22)        (* = sólido)
"""
import os
import sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from mapdsl import Map  # noqa

ROOT = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm"))
MAPS = []


def M(*a, **k):
    m = Map(*a, **k)
    MAPS.append(m)
    return m


def field(m, floor=".", wall="W", top="#"):
    """Zona exterior del Dark World: bordes de pared y suelo dentro."""
    m.rect(0, 0, m.w, m.h, top)
    m.rect(1, 1, m.w - 2, 1, wall)
    m.rect(1, 2, m.w - 2, m.h - 3, floor)


def scatter(m, chars, positions):
    for (x, y), c in zip(positions, chars * 50):
        m.set(x, y, c)


# =============================================================================== INTRO
m = M("intro", 16, 12, "aroy", "???", music="aroy", fill=":")
m.marker("spawn", 8, 7)

# =============================================================================== LIGHT WORLD
# ---------------------------------------------------------------- Casa de Pablo
m = M("lw/casa_pablo", 12, 9, "casa_pablo", "Casa de Pablo", music="casa_pablo", light=True)
m.box(0, 0, 12, 9)
m.set(3, 1, "P")
m.set(7, 1, "P")
m.big(1, 2, "A")          # cama sin hacer
m.big(8, 2, "E")          # escritorio gamer
m.set(5, 5, "r"); m.set(6, 5, "r")
m.set(3, 6, "f"); m.set(9, 6, "f"); m.set(6, 7, "f")
m.npc_named("pablo", 8, 4, "pablo_lw", facing="up", turn=False)
m.marker("spawn", 5, 6)

# ---------------------------------------------------------------- Casa de Lucía
m = M("lw/casa_lucia", 12, 10, "casa", "Habitación de Lucía", music="casa_lucia", light=True)
m.box(0, 0, 12, 10)
m.set(2, 1, "P"); m.set(4, 1, "P"); m.set(9, 1, "P")
m.big(1, 2, "A")          # cama
m.big(9, 2, "B")          # armario
m.set(1, 5, "p")          # Mandarina (cabeza de fursuit)
m.set(10, 5, "d")         # ordenador
m.set(1, 7, "l")          # estantería
for x in (5, 6):
    for y in (5, 6):
        m.set(x, y, "r")
m.set(5, 9, "="); m.set(6, 9, "=")
m.event("deco", 6, 0, 1, 1, texture="objects/espejo", oy=10, ox=-4, cutscene="lw_lucia.espejo")
m.interact(6, 1, "lw_lucia.espejo")
m.interact(1, 2, "lw_lucia.cama", w=2, h=2)
m.interact(9, 2, "lw_lucia.armario", w=2, h=2)
m.interact(1, 5, "lw_lucia.mandarina")
m.interact(10, 5, "lw_lucia.pc")
m.interact(2, 1, "lw_lucia.poster")
m.interact(4, 1, "lw_lucia.poster")
m.interact(9, 1, "lw_lucia.poster")
m.interact(1, 7, "lw_lucia.estanteria")
m.trans(5, 9, 2, 1, "lw/calle", "casa_lucia", facing="down", cond="pcdm_lucia_despierta")
m.script(5, 8, 2, 1, "lw_lucia.no_salir", once=False, cond="not pcdm_lucia_despierta")
m.marker("spawn", 3, 4)
m.marker("puerta", 5, 8)

# ---------------------------------------------------------------- Calle
m = M("lw/calle", 40, 12, "calle", "Calle del Instituto", music="calle", light=True)
m.rect(0, 0, 40, 1, "#")
m.rect(0, 1, 40, 2, "W")
for x in range(1, 40, 4):
    m.set(x, 1, "P")
for x in (3, 11, 27, 33):
    m.set(x, 2, "V")
m.big(16, 1, "C")         # ventana de Aridai
m.rect(0, 3, 40, 2, ".")
m.rect(0, 5, 40, 3, "=")
for y in (5, 6, 7):
    m.set(10, y, "r")
m.rect(0, 8, 40, 2, ".")
m.rect(0, 10, 40, 1, "f")
m.rect(0, 11, 40, 1, "#")
m.rect(0, 3, 1, 8, "W")
for x in (6, 14, 22, 30):
    m.set(x, 3, "d")
m.set(13, 3, "l")
m.big(24, 3, "B")         # parada de guagua
m.big(20, 5, "E")         # coche
m.set(34, 8, "p")
m.set(18, 9, "l")
m.interact(3, 2, "lw_calle.puerta_lucia")
m.interact(16, 2, "lw_calle.aridai", w=2)
m.npc(8, 4, "candelaria_lw", "lw_calle.candelaria")
m.npc(26, 4, "paco_lw", "lw_calle.paco", facing="left")
m.npc(30, 9, "brayan_lw", "lw_calle.brayan", facing="left")
m.npc_named("julio", 12, 8, "julio_lw", "lw_calle.julio_npc", facing="left")
m.script(11, 3, 1, 7, "lw_calle.julio")
m.event("deco", 37, 1, 1, 1, texture="objects/cartel_instituto", oy=30)
m.trans(39, 3, 1, 7, "lw/pasillo", "entrada", facing="right")
m.marker("spawn", 3, 3)
m.marker("casa_lucia", 3, 3)
m.marker("instituto", 38, 6)

# ---------------------------------------------------------------- Pasillo del instituto
m = M("lw/pasillo", 30, 10, "instituto", "Pasillo del IES", music="instituto", light=True)
m.box(0, 0, 30, 10, face_rows=1)
for x in range(2, 29, 3):
    m.set(x, 1, "V")
m.rect(1, 2, 28, 1, "l")  # taquillas
m.set(8, 2, "="); m.set(9, 2, "=")
m.set(8, 1, "W"); m.set(9, 1, "W")
m.set(22, 2, "p")
m.set(0, 4, "="); m.set(0, 5, "="); m.set(0, 6, "=")
m.big(26, 6, "C")         # máquina expendedora
m.npc(7, 4, "profe_lw", "lw_pasillo.profe", facing="right")
m.npc_named("carmen", 13, 5, "carmen_lw", "lw_pasillo.carmen", facing="right")
m.npc_named("xibin", 14, 5, "xibin_lw", "lw_pasillo.xibin", facing="left")
m.npc_named("david", 16, 4, "david_lw", "lw_pasillo.david", facing="down")
m.npc(20, 7, "fernanda_lw", "lw_pasillo.fernanda", facing="up")
m.interact(26, 6, "lw_pasillo.maquina", w=2, h=2)
m.interact(4, 2, "lw_pasillo.taquilla")
m.script(11, 3, 1, 6, "lw_pasillo.tarot")
m.trans(0, 4, 1, 3, "lw/calle", "instituto", facing="left")
m.trans(8, 2, 2, 1, "lw/aula", "puerta", facing="up")
m.marker("spawn", 2, 5)
m.marker("entrada", 2, 5)
m.marker("aula", 8, 3)

# ---------------------------------------------------------------- Aula 2ºB
m = M("lw/aula", 16, 14, "instituto", "Aula 2ºB", music="aula", light=True)
m.box(0, 0, 16, 14, face_rows=1)
m.set(4, 1, "P"); m.set(5, 1, "P"); m.set(10, 1, "P"); m.set(11, 1, "P")
m.big(6, 0, "E")          # pizarra con un dibujo de Thomas
m.set(6, 0, "E")
m.set(13, 1, "V"); m.set(14, 1, "V"); m.set(2, 1, "V")
m.big(7, 3, "A")          # mesa del profe
m.big(1, 2, "B")          # estantería
DESKS_X = [2, 4, 6, 9, 11, 13]
for y in (6, 8, 10):
    for x in DESKS_X:
        m.set(x, y, "d")
m.set(14, 12, "p")
m.set(0, 10, "="); m.set(0, 11, "=")
m.event("armario", 13, 2, 2, 4)
# alumnos sentados (día 1)
SEATS = {
    "yerover": (2, 7), "gabriel": (6, 7), "angel": (9, 7), "alejandro": (11, 7), "julio": (13, 7),
    "isra": (2, 9), "carmen": (4, 9), "david": (6, 9), "xibin": (9, 9), "fernanda": (11, 9), "brayan": (13, 9),
    "pablo": (2, 11), "dayron": (4, 11), "angelpedro": (6, 11), "andres": (9, 11),
}
for who, (x, y) in SEATS.items():
    m.npc_named(who, x, y, who + "_lw", "lw_aula." + who, facing="up", cond="not pcdm_dia2 and not pcdm_final")
m.npc_named("profe", 5, 4, "profe_lw", "lw_aula.profe", facing="down", cond="not pcdm_dia2 and not pcdm_final and not pcdm_profe_fuera")
m.interact(11, 10, "lw_aula.pupitre_vacio")
m.interact(13, 10, "lw_aula.pupitre_aridai")
m.interact(6, 0, "lw_aula.pizarra", w=2, h=2)
m.interact(7, 3, "lw_aula.mesa_profe", w=2, h=2)
m.script(4, 7, 1, 1, "lw_aula.pablo", cond="not pcdm_dia2 and not pcdm_final")
m.trans(0, 10, 1, 2, "lw/pasillo", "aula", facing="down", cond="pcdm_puede_salir_aula")
m.script(0, 10, 1, 2, "lw_aula.no_salir", once=False, cond="not pcdm_puede_salir_aula")
m.marker("spawn", 4, 12)
m.marker("puerta", 1, 11)
m.marker("asiento", 4, 7)
m.marker("armario", 12, 6)

# ---------------------------------------------------------------- Patio
m = M("lw/patio", 24, 14, "calle", "Patio del IES", music="patio", light=True)
m.rect(0, 0, 24, 1, "#")
m.rect(0, 1, 24, 2, "W")
for x in range(2, 23, 4):
    m.set(x, 1, "P")
m.set(11, 2, "V"); m.set(12, 2, "V")
m.rect(0, 3, 24, 10, ".")
m.rect(4, 6, 12, 5, "=")  # pista
for y in range(6, 11):
    m.set(10, y, "r")
m.rect(0, 13, 24, 1, "#")
m.rect(0, 3, 1, 10, "W")
m.rect(23, 3, 1, 10, "W")
m.set(6, 4, "p"); m.set(7, 4, "p")      # banco
m.set(18, 4, "p"); m.set(19, 4, "p")    # banco
m.set(2, 4, "d"); m.set(21, 11, "d"); m.set(2, 11, "d")
m.set(16, 11, "l")
m.event("deco", 20, 8, 1, 1, texture="objects/sillas_apiladas", solid=True, cutscene="lw_patio.sillas")
m.npc_named("lucia", 6, 5, "lucia_lw", "lw_patio.lucia", facing="down")
m.npc_named("yerover", 7, 5, "yerover_lw", "lw_patio.yerover", facing="down")
m.npc_named("angel", 12, 4, "angel_lw", "lw_patio.angel", facing="right")
m.npc_named("alejandro", 13, 4, "alejandro_lw", "lw_patio.alejandro", facing="left")
m.npc_named("isra", 18, 5, "isra_lw", "lw_patio.isra", facing="down")
m.npc_named("julio", 15, 9, "julio_lw", "lw_patio.julio", facing="left")
m.npc_named("dayron", 9, 8, "dayron_lw", "lw_patio.dayron_npc", facing="left", cond="not pcdm_patio_dayron")
m.npc_named("angelpedro", 19, 9, "angelpedro_lw", "lw_patio.angelpedro", facing="right", cond="not pcdm_patio_silla")
m.script(8, 3, 1, 10, "lw_patio.dayron")
m.script(17, 6, 1, 7, "lw_patio.silla", cond="pcdm_patio_dayron")
m.marker("spawn", 3, 10)

# ---------------------------------------------------------------- Casa de Andrés
m = M("lw/casa_andres", 12, 10, "casa_andres", "Habitación de Andrés", music="casa_andres", light=True)
m.box(0, 0, 12, 10)
m.set(3, 1, "V")          # póster PROVE ME WRONG
m.big(1, 2, "C")          # maniquí con el cosplay de cartón
m.set(4, 2, "d")          # escritorio con tijeras
m.set(5, 2, "l")          # cajón cerrado
m.big(8, 2, "E")          # PC con WoW y foros
m.big(9, 6, "A")          # cama
m.event("deco", 6, 0, 1, 1, texture="objects/espejo", oy=10, ox=-4)
m.interact(6, 1, "lw_andres.espejo")
m.interact(3, 1, "lw_andres.poster")
m.interact(1, 2, "lw_andres.cosplay", w=2, h=2)
m.interact(4, 2, "lw_andres.tijeras")
m.interact(5, 2, "lw_andres.cajon")
m.interact(8, 2, "lw_andres.pc", w=2, h=2)
m.interact(9, 6, "lw_andres.movil", w=2, h=2)
m.marker("spawn", 6, 5)

# ---------------------------------------------------------------- Fiestas del Pino (Teror)
m = M("lw/pino", 30, 14, "pino", "Fiestas del Pino, Teror", music="fiestas_pino", light=True)
m.rect(0, 0, 30, 1, "#")
m.rect(0, 1, 30, 1, "P")
m.set(6, 1, "V"); m.set(24, 1, "V")
m.rect(0, 2, 30, 11, ".")
m.rect(0, 13, 30, 1, "#")
m.rect(0, 2, 1, 11, "W"); m.rect(29, 2, 1, 11, "W")
m.big(14, 1, "C")         # basílica
m.big(4, 2, "A")          # churros
m.big(9, 2, "B")          # ron miel
m.big(21, 2, "E")         # verbena
for (x, y) in ((2, 6), (27, 6), (7, 11), (22, 11)):
    m.set(x, y, "p")
for (x, y) in ((12, 7), (17, 7)):
    m.set(x, y, "d")
m.set(25, 9, "l"); m.set(5, 9, "l")
for (x, y) in ((8, 6), (13, 10), (19, 5), (24, 8), (3, 10)):
    m.set(x, y, "r")
for (x, y) in ((11, 9), (20, 10)):
    m.set(x, y, "f")
m.event("deco", 2, 2, 1, 1, texture="objects/cartel_teror", oy=10)
m.npc(9, 4, "candelaria_lw", "lw_pino.ventorrillera", facing="down", turn=False)
m.npc_named("angel", 6, 6, "angel_lw", "lw_pino.angel", facing="right")
m.npc_named("alejandro", 7, 6, "alejandro_lw", "lw_pino.alejandro", facing="left")
m.npc_named("julio", 12, 9, "julio_lw", "lw_pino.julio", facing="down")
m.npc_named("xibin", 18, 5, "xibin_lw", "lw_pino.xibin", facing="down")
m.npc(25, 6, "brayan_lw", "lw_pino.brayan", facing="left")
m.interact(9, 2, "lw_pino.ron", w=2, h=3)
m.interact(4, 2, "lw_pino.churros", w=2, h=2)
m.interact(14, 1, "lw_pino.basilica", w=2, h=2)
m.interact(21, 2, "lw_pino.verbena", w=2, h=2)
m.marker("spawn", 14, 11)

# =============================================================================== DARK WORLD
# ---------------------------------------------------------------- Llanuras del Armario 1
m = M("dw/llanuras_1", 22, 15, "llanuras", "Llanuras del Armario", music="llanuras")
field(m)
m.rect(1, 1, 20, 1, "P")
scatter(m, ["d", "l", "p"], [(3, 3), (17, 3), (4, 11), (18, 12), (9, 3), (14, 12), (2, 7), (19, 9)])
for (x, y) in ((6, 6), (12, 9), (15, 5), (8, 12)):
    m.set(x, y, ":")
m.rect(21, 6, 1, 3, ".")
m.big(10, 3, "B")         # cristal oscuro
m.save(5, 5)
m.npc_named("percha", 13, 6, "percha", "dw_llanuras.percha", facing="left", cond="pcdm_llanuras_intro and not pcdm_ruta_furrygrave")
m.enemy(16, 10, "garra", "solo_garra", chase=True)
m.trans(21, 6, 1, 3, "dw/llanuras_2", "oeste", facing="right")
m.marker("spawn", 8, 8)
m.marker("este", 20, 7)
m.marker("caida", 8, 8)

# ---------------------------------------------------------------- Llanuras del Armario 2
m = M("dw/llanuras_2", 28, 18, "llanuras", "Llanuras del Armario", music="llanuras")
field(m)
m.rect(1, 1, 26, 1, "P")
m.rect(0, 7, 1, 3, ".")
m.rect(27, 10, 1, 3, ".")
# acantilados que forman un camino
m.rect(6, 2, 2, 6, "_")
m.rect(12, 6, 2, 10, "_")
m.rect(20, 2, 2, 8, "_")
m.rect(8, 13, 4, 1, "_")
# rincón secreto (arriba a la izquierda) con el sticker dorado
m.rect(2, 2, 4, 3, ",")
m.rect(1, 5, 5, 1, "l")
m.set(3, 5, ".")
scatter(m, ["d", "l", "p"], [(9, 3), (16, 4), (24, 4), (3, 15), (17, 15), (25, 15), (10, 10), (23, 12)])
m.chest(16, 9, item="monster_oscuro")
m.chest(25, 6, item="arepa")
m.event("deco", 3, 2, 1, 1, texture="objects/sticker_dorado", speed=0.3, cutscene="furrygrave.sticker", cond="not pcdm_sticker_cogido")
m.enemy(9, 9, "dibujo", "dibujo_garra", chase=True)
m.enemy(17, 12, "pastilla_e", "pastillas", chase=True)
m.enemy(23, 9, "sticker1", "stickers", chase=True)
m.save(15, 3)
m.trans(0, 7, 1, 3, "dw/llanuras_1", "este", facing="left")
m.trans(27, 10, 1, 3, "dw/llanuras_3", "oeste", facing="right")
m.marker("spawn", 2, 8)
m.marker("oeste", 2, 8)
m.marker("este", 26, 11)

# ---------------------------------------------------------------- Llanuras del Armario 3 (Guaguas)
m = M("dw/llanuras_3", 22, 14, "llanuras", "Parada de Guaguas", music="llanuras")
field(m)
m.rect(1, 1, 20, 1, "P")
m.rect(0, 9, 1, 3, ".")
m.rect(21, 5, 1, 3, ".")
scatter(m, ["d", "p", "l"], [(3, 3), (18, 3), (3, 12), (18, 12), (11, 12)])
m.event("guagua", 7, 3, 6, 3, stop="llanuras")
m.npc_named("mamdani", 14, 6, "mamdani", "dw_llanuras.mamdani", facing="left")
m.save(4, 6)
m.trans(0, 9, 1, 3, "dw/llanuras_2", "este", facing="left")
m.script(20, 5, 1, 3, "dw_llanuras.salida", once=False)
m.marker("spawn", 2, 10)
m.marker("oeste", 2, 10)
m.marker("guagua", 10, 7)

# ---------------------------------------------------------------- Bosque de Tijeras 1
m = M("dw/bosque_1", 28, 15, "bosque", "Bosque de Tijeras", music="bosque")
field(m)
for x in range(1, 27, 2):
    m.set(x, 1, "P")
scatter(m, ["d", "d", "l", "p"], [(3, 3), (6, 3), (9, 4), (14, 3), (19, 3), (24, 4), (4, 12), (8, 11), (15, 12),
                                   (21, 11), (25, 12), (12, 8), (18, 7)])
m.rect(27, 6, 1, 3, ".")
m.save(3, 7)
m.enemy(10, 9, "tijera", "tijera_marine", chase=True)
m.enemy(20, 9, "silla", "sillas", chase=True)
m.script(15, 2, 1, 12, "dw_bosque.vito")
m.npc_named("vito", 17, 7, "vito", None, facing="left", cond="not pcdm_vito_hecho")
m.trans(27, 6, 1, 3, "dw/bosque_2", "oeste", facing="right")
m.marker("spawn", 2, 8)
m.marker("caida", 4, 8)
m.marker("oeste", 2, 8)

# ---------------------------------------------------------------- Bosque de Tijeras 2 (Angel Pedro)
m = M("dw/bosque_2", 24, 16, "bosque", "Claro de las Sillas", music="bosque")
field(m)
for x in range(1, 23, 2):
    m.set(x, 1, "P")
m.rect(0, 6, 1, 3, ".")
m.rect(23, 10, 1, 3, ".")
scatter(m, ["p", "p", "d"], [(8, 5), (14, 5), (9, 11), (15, 11), (4, 3), (20, 3), (4, 13), (20, 13)])
m.big(11, 3, "A")          # árbol-tijera gigante
m.event("guagua", 2, 11, 6, 3, stop="bosque")
m.npc_named("angelpedro", 12, 8, "angelpedro", None, facing="left", cond="not pcdm_angelpedro_hecho")
m.script(9, 6, 1, 6, "dw_bosque.angelpedro")
m.save(18, 7)
m.enemy(15, 12, "marine", "trio_andres", chase=True)
m.trans(0, 6, 1, 3, "dw/bosque_1", "este", facing="left")
m.script(22, 10, 1, 3, "dw_bosque.salida", once=False)
m.marker("spawn", 2, 7)
m.marker("oeste", 2, 7)
m.marker("este", 21, 11)
m.marker("guagua", 5, 14)

# ---------------------------------------------------------------- Plató del Hormiguero 1
m = M("dw/plato_1", 26, 15, "plato", "Plató del Hormiguero", music="plato")
field(m)
m.rect(1, 1, 24, 1, "P")
scatter(m, ["d", "l", "p"], [(3, 3), (22, 3), (6, 12), (19, 12), (12, 3), (3, 9), (23, 9)])
m.rect(25, 6, 1, 3, ".")
m.big(9, 2, "A")           # pantalla APLAUSOS
m.event("deco", 15, 2, 1, 1, texture="objects/cartel_plato", oy=20)
m.npc_named("xibin", 13, 6, "xibin", "dw_plato.xibin", facing="down", cond="not pcdm_xibin_unido")
m.npc_named("yolanda", 5, 6, "yolanda", "dw_plato.yolanda", facing="right")
m.npc_named("panavi", 20, 6, "panavi", "dw_plato.panavi", facing="left")
m.enemy(10, 10, "papeleta", "papeleta_escano", chase=True)
m.enemy(16, 10, "pastilla_t", "hormonas_garra", chase=True)
m.save(3, 6)
m.trans(25, 6, 1, 3, "dw/plato_2", "oeste", facing="right")
m.marker("spawn", 2, 11)
m.marker("caida", 4, 11)
m.marker("oeste", 2, 11)

# ---------------------------------------------------------------- Plató del Hormiguero 2 (Pablo Motos)
m = M("dw/plato_2", 22, 15, "plato", "Escenario Principal", music="plato")
field(m)
m.rect(1, 1, 20, 1, "P")
m.rect(0, 6, 1, 3, ".")
m.rect(21, 10, 1, 3, ".")
m.big(10, 2, "A")
m.rect(6, 4, 10, 4, "=")   # alfombra del escenario
scatter(m, ["d", "l"], [(4, 3), (17, 3), (4, 12), (17, 12)])
m.event("deco", 9, 4, 1, 1, texture="objects/tele", speed=0.5, scale=2, ox=-10, cond="not pcdm_motos_hecho")
m.npc_named("motos", 11, 6, "motos", None, facing="down", cond="not pcdm_motos_hecho")
m.script(6, 8, 10, 1, "dw_plato.motos")
m.event("guagua", 2, 11, 6, 3, stop="plato")
m.save(18, 7)
m.trans(0, 6, 1, 3, "dw/plato_1", "este", facing="left")
m.script(20, 10, 1, 3, "dw_plato.salida", once=False)
m.marker("spawn", 2, 7)
m.marker("oeste", 2, 7)
m.marker("guagua", 5, 14)

# ---------------------------------------------------------------- Cortijo de la Reconquista 1
m = M("dw/cortijo_1", 30, 16, "cortijo", "Cortijo de la Reconquista", music="cortijo")
field(m)
for x in range(1, 29, 3):
    m.set(x, 1, "P")
m.rect(29, 7, 1, 3, ".")
m.rect(1, 4, 6, 1, "d")    # valla
m.big(3, 2, "A")           # cortijo blanco
scatter(m, ["l", "p"], [(9, 3), (24, 3), (9, 13), (16, 13), (24, 13), (27, 4)])
m.event("deco", 12, 2, 1, 1, texture="objects/cartel_taberna", oy=10)
m.event("deco", 18, 2, 1, 1, texture="objects/cartel_tacos", oy=10)
m.npc_named("sanchez", 7, 7, "sanchez", "dw_cortijo.sanchez", facing="right")
m.npc_named("iglesias", 12, 4, "iglesias", "dw_cortijo.iglesias", facing="down")
m.npc_named("fernanda", 18, 4, "fernanda", "dw_cortijo.fernanda", facing="down")
m.npc_named("borja", 22, 7, "borja", "dw_cortijo.borja", facing="left")
m.npc_named("bellerin", 23, 8, "bellerin", "dw_cortijo.bellerin", facing="left")
m.enemy(14, 10, "carpa", "ladrillo_carpa", chase=True)
m.enemy(20, 11, "ladrillo", "ladrillos", chase=True)
m.npc_named("abascal", 26, 8, "abascal", None, facing="left", cond="not pcdm_abascal_hecho")
m.script(25, 2, 1, 13, "dw_cortijo.abascal")
m.save(5, 9)
m.trans(29, 7, 1, 3, "dw/cortijo_2", "oeste", facing="right")
m.marker("spawn", 2, 10)
m.marker("caida", 3, 10)
m.marker("este", 28, 8)

# ---------------------------------------------------------------- Cortijo 2: el Trono del Armario (Pablo)
m = M("dw/cortijo_2", 22, 16, "cortijo", "Trono del Armario", music="cortijo")
field(m)
m.rect(1, 1, 20, 1, "P")
m.rect(0, 7, 1, 3, ".")
m.rect(21, 7, 1, 3, ".")
m.event("deco", 9, 1, 1, 1, texture="objects/trono_armario", oy=-20, solid=True)
m.rect(9, 6, 4, 6, "=")
m.npc_named("pablo", 10, 6, "pablo", None, facing="down", cond="not pcdm_pablo_hecho")
m.script(8, 10, 6, 1, "dw_cortijo.pablo")
m.event("guagua", 14, 12, 6, 3, stop="cortijo")
m.save(3, 4)
m.trans(0, 7, 1, 3, "dw/cortijo_1", "este", facing="left")
m.script(21, 7, 1, 3, "dw_cortijo.salida", once=False)
m.marker("spawn", 2, 8)
m.marker("oeste", 2, 8)
m.marker("guagua", 17, 14)

# ---------------------------------------------------------------- El Muro (Trump)
m = M("dw/muro_1", 30, 18, "trump", "El Muro", music="muro")
field(m, floor=".")
m.rect(1, 1, 28, 1, "W")
m.rect(0, 8, 1, 3, ".")
m.rect(12, 2, 6, 3, "=")
m.big(13, 2, "A")          # THE WALL
m.big(15, 2, "A")
scatter(m, ["d", "l", "p"], [(4, 3), (25, 3), (4, 14), (25, 14), (9, 6), (21, 6)])
m.event("deco", 22, 2, 1, 1, texture="objects/cartel_casablanca", oy=10)
m.npc_named("trump", 15, 8, "trump", None, facing="down", cond="not pcdm_trump_hecho")
m.script(6, 11, 18, 1, "dw_muro.trump")
m.script(2, 6, 1, 7, "dw_muro.reunion")
m.event("guagua", 3, 13, 6, 3, stop="muro")
for who, (x, y) in {"yerover": (10, 14), "isra": (12, 15), "alejandro": (14, 14), "carmen": (17, 15), "david": (19, 14),
                    "julio": (21, 15), "xibin": (23, 14), "angel": (11, 13), "gabriel": (20, 13)}.items():
    m.npc_named("amigo_" + who, x, y, who, "dw_muro.amigo_" + who, facing="up",
                cond="pcdm_reunion and not pcdm_en_equipo_" + who)
m.save(26, 8)
m.trans(14, 4, 2, 1, "dw/muro_2", "sur", facing="up", cond="pcdm_trump_hecho")
m.trans(0, 8, 1, 3, "dw/cortijo_2", "este", facing="left")
m.marker("spawn", 2, 9)
m.marker("oeste", 2, 9)
m.marker("guagua", 6, 16)
m.marker("centro", 15, 12)
m.marker("muro", 14, 5)

# ---------------------------------------------------------------- El Muro 2 (Gabriel vs Dayron)
m = M("dw/muro_2", 20, 16, "trump", "Azotea del Muro", music="muro")
field(m)
m.rect(1, 1, 18, 1, "W")
m.rect(9, 14, 2, 2, ".")
scatter(m, ["d", "p"], [(3, 3), (16, 3), (3, 12), (16, 12)])
m.npc_named("dayron", 10, 5, "dayron", None, facing="down", cond="not pcdm_dayron_hecho")
m.script(4, 9, 12, 1, "dw_muro.dayron")
m.trans(9, 2, 2, 1, "dw/torre_aroy", "sur", facing="up", cond="pcdm_dayron_hecho")
m.marker("spawn", 10, 13)
m.marker("sur", 10, 13)

# ---------------------------------------------------------------- Torre de Aroy (final)
m = M("dw/torre_aroy", 18, 16, "aroy", "Torre de Aroy.exe", music="torre_aroy")
field(m, floor=":")
m.rect(1, 1, 16, 1, "W")
m.big(8, 2, "A")           # monolito
scatter(m, ["d", "l", "p"], [(3, 4), (14, 4), (3, 11), (14, 11)])
m.script(4, 9, 10, 1, "dw_torre.final")
m.marker("spawn", 9, 13)
m.marker("sur", 9, 13)
m.marker("centro", 9, 7)

# =============================================================================== RUTA FURRYGRAVE
m = M("dw/sg_camino", 44, 10, "noche", "Llanuras del Armario...?", music="ruta_furrygrave")
field(m)
m.rect(1, 1, 42, 1, "P")
scatter(m, ["d", "l"], [(4, 3), (10, 8), (16, 3), (22, 8), (28, 3), (34, 8), (40, 3)])
for i, x in enumerate((7, 13, 19, 25, 31, 37)):
    m.script(x, 2, 1, 7, "furrygrave.tramo%d" % (i + 1))
m.script(42, 2, 1, 7, "furrygrave.fin_camino")
m.marker("spawn", 2, 5)

m = M("dw/sg_cumbre", 16, 14, "noche", "La Cumbre", music="ruta_furrygrave")
field(m)
m.rect(1, 1, 14, 1, "P")
m.npc_named("gabriel", 8, 4, "gabriel", None, facing="down")
m.script(3, 8, 10, 1, "furrygrave.gabriel")
m.marker("spawn", 8, 11)

m = M("dw/sg_vacio", 16, 12, "aroy", "...", music="")
m.rect(0, 0, 16, 12, ":")
m.marker("spawn", 8, 8)


if __name__ == "__main__":
    import glob
    for f in glob.glob(os.path.join(ROOT, "scripts", "world", "maps", "**", "*.lua"), recursive=True):
        os.remove(f)
    for mp in MAPS:
        mp.write(ROOT)
    print("mapas:", len(MAPS))
