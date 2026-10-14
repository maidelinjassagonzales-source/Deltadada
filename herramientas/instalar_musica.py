"""Coloca la banda sonora del mod en deltarune_pcdm/assets/music/<sección>/.

El mod no incluye música con copyright: este script la copia de TUS copias
de DELTARUNE y UNDERTALE y de las canciones de la carpeta de Drive.

Uso:
  python3 herramientas/instalar_musica.py \
      --deltarune "C:/Program Files (x86)/Steam/steamapps/common/DELTARUNE" \
      --undertale "C:/Program Files (x86)/Steam/steamapps/common/Undertale" \
      --drive     "C:/Users/yo/Descargas/deltarunekdadas"

Todos los argumentos son opcionales. Lo que no encuentre usa la música que
trae Kristal. Puedes meter canciones a mano: cualquier .ogg/.mp3/.wav dentro de
assets/music/<sección>/ suena en esa parte del juego.
"""
import argparse
import os
import shutil
import unicodedata

HERE = os.path.dirname(os.path.abspath(__file__))
MOD = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm"))
MUSIC = os.path.join(MOD, "assets", "music")
AUDIO = (".ogg", ".mp3", ".wav", ".flac")

# sección -> nombres de archivo candidatos (sin extensión). Se prueban en orden:
# primero coincidencia exacta y luego "contiene".
SECCIONES = {
    "intro":            ["AUDIO_STORY", "mus_story"],
    "casa_pablo":       ["mus_home", "home"],
    "casa_lucia":       ["home", "mus_home"],
    "calle":            ["town", "mus_town"],
    "instituto":        ["school", "town"],
    "aula":             ["school", "mus_school"],
    "patio":            ["mus_town", "town"],
    "casa_andres":      ["creepychase", "mus_ruins"],
    "fiestas_pino":     ["dogcheck", "mus_dogsong", "mus_dance_of_dog"],
    "combate_light":    ["mus_battle1", "mus_battle2"],
    "caida":            ["AUDIO_DRONE", "mus_fallendown"],
    "llanuras":         ["field_of_hopes", "field"],
    "bosque":           ["forest", "mus_woods"],
    "plato":            ["cybercity", "cyber", "mus_hotel"],
    "cortijo":          ["card_castle", "castle", "mus_castle"],
    "muro":             ["mus_waterfall", "lancer"],
    "torre_aroy":       ["mus_core", "AUDIO_ANOTHERHIM"],
    "combate":          ["battle", "rudebuster"],
    "jefe":             ["vs_lancer", "lancer_battle", "mus_vsundyne", "mus_mettatonbattle"],
    "jefe_dayron":      ["chaos", "mus_x_undyne", "spearofjustice"],
    "jefe_aroy":        ["mus_f_finale_1", "mus_f_finale", "mus_flowey", "mus_zz_megalovania"],
    "jefe_andres":      ["kingboss", "mus_vsasgore", "mus_x_undyne"],
    "papa_francisco":   ["mus_hopesanddreams", "mus_savetheworld", "AUDIO_DEFEAT"],
    "tienda":           ["hip_shop", "mus_shop", "shop"],
    "final_neutral":    ["mus_reunited", "mus_tv_show", "legend"],
    "final_verdadero":  ["mus_hopesanddreams", "mus_reunited", "legend"],
    "final_furrygrave": ["mus_anothermedium", "AUDIO_ANOTHERHIM"],
    "ruta_furrygrave":  ["snowgrave", "mus_toomuch", "AUDIO_DRONE"],
}

# canciones de la carpeta de Drive "deltarunekdadas" -> sección
DRIVE = [
    ("pablo motos", "jefe_motos"),   # el mod la invierte y la ralentiza solo
    ("aroy habla", "aroy"),
    ("aroy", "aroy"),
    ("gabriel", "jefe_gabriel"),
]


def norm(s):
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode().lower()
    return s


def audio_files(root):
    out = []
    for r, _, fs in os.walk(root):
        for f in fs:
            if f.lower().endswith(AUDIO):
                out.append(os.path.join(r, f))
    return out


def stem(path):
    return os.path.splitext(os.path.basename(path))[0].lower()


def copy_to(section, src):
    dst_dir = os.path.join(MUSIC, section)
    os.makedirs(dst_dir, exist_ok=True)
    for f in os.listdir(dst_dir):
        if f.lower().endswith(AUDIO):
            os.remove(os.path.join(dst_dir, f))
    dst = os.path.join(dst_dir, os.path.basename(src).replace(" ", "_"))
    shutil.copyfile(src, dst)
    print("  %-17s <- %s" % (section, os.path.basename(src)))


def from_games(roots):
    pool = []
    for r in roots:
        if r and os.path.isdir(r):
            pool += audio_files(r)
    if not pool:
        return
    print("Música de los juegos (%d archivos encontrados):" % len(pool))
    by_stem = {}
    for p in pool:
        by_stem.setdefault(stem(p), p)
    for section, cands in SECCIONES.items():
        found = None
        for c in cands:
            if c.lower() in by_stem:
                found = by_stem[c.lower()]
                break
        if not found:
            for c in cands:
                hits = sorted(p for s, p in by_stem.items() if c.lower() in s)
                if hits:
                    found = hits[0]
                    break
        if found:
            copy_to(section, found)
        else:
            print("  %-17s (sin encontrar: se usa la de Kristal)" % section)


def from_drive(root, dayron):
    files = audio_files(root) if root and os.path.isdir(root) else []
    if dayron:
        files.append(dayron)
    if not files:
        return
    print("Canciones propias:")
    used = set()
    for p in files:
        n = norm(os.path.basename(p))
        if "dayron" in n:
            dst = os.path.join(MOD, "assets", "sounds", "Dayron" + os.path.splitext(p)[1].lower())
            shutil.copyfile(p, dst)
            print("  %-17s <- %s" % ("sounds/Dayron", os.path.basename(p)))
            continue
        for key, section in DRIVE:
            if key in n and section not in used:
                copy_to(section, p)
                used.add(section)
                break


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--deltarune", help="carpeta de instalación de DELTARUNE")
    ap.add_argument("--undertale", help="carpeta de instalación de UNDERTALE")
    ap.add_argument("--drive", help="carpeta descargada de Drive con los mp3")
    ap.add_argument("--dayron", help="ruta a Dayron.ogg si no está en la carpeta de Drive")
    a = ap.parse_args()
    from_games([a.deltarune, a.undertale])  # si hay repetidos, gana DELTARUNE
    from_drive(a.drive, a.dayron)
    print("Listo. Copia de nuevo la carpeta deltarune_pcdm a Kristal/mods si ya la tenías allí.")


if __name__ == "__main__":
    main()
