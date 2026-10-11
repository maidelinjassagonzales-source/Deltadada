"""Todos los mapas del mod. Ejecuta: python3 herramientas/mapas.py"""
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


# =============================================================================== INTRO
m = M("intro", 16, 12, "aroy", "???", music="aroy", fill=":")
m.marker("spawn", 8, 7)

# =============================================================================== SALA DE PRUEBAS
m = M("pruebas", 16, 12, "llanuras", "Sala de pruebas", music="llanuras")
m.box(0, 0, 16, 12, floor=".")
m.marker("spawn", 8, 8)
m.save(8, 4)

m = M("pruebas_lw", 16, 12, "instituto", "Sala de pruebas LW", music="aula", light=True)
m.box(0, 0, 16, 12, floor=".")
m.marker("spawn", 8, 8)

if __name__ == "__main__":
    import glob
    for f in glob.glob(os.path.join(ROOT, "scripts", "world", "maps", "**", "*.lua"), recursive=True):
        os.remove(f)
    for mp in MAPS:
        mp.write(ROOT)
    print("mapas:", len(MAPS))
