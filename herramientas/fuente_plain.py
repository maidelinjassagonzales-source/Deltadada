"""Crea assets/fonts/plain.png del mod: la fuente de los bocadillos de Kristal
con tildes, eñes y signos de apertura (¿ ¡) añadidos.
Uso: python3 herramientas/fuente_plain.py /ruta/a/Kristal
"""
import json
import os
import sys

from PIL import Image

KRISTAL = sys.argv[1]
HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm", "assets", "fonts"))

src = Image.open(os.path.join(KRISTAL, "assets", "fonts", "plain.png")).convert("RGBA")
glyphs = json.load(open(os.path.join(KRISTAL, "assets", "fonts", "plain.json")))["glyphs"]
SEP = src.getpixel((0, 0))
W, H = 9, src.size[1]


def glyph(ch):
    i = glyphs.index(ch)
    return src.crop((10 * i + 1, 0, 10 * i + 1 + W, H))


def ink(g):
    # color de la tinta: el primer píxel opaco
    for y in range(H):
        for x in range(W):
            p = g.getpixel((x, y))
            if p[3] > 0:
                return p
    return (255, 255, 255, 255)


def dots(g, pts):
    g = g.copy()
    c = ink(g)
    for x, y in pts:
        g.putpixel((x, y), c)
    return g


def clear_rows(g, y0, y1):
    g = g.copy()
    for y in range(y0, y1):
        for x in range(W):
            g.putpixel((x, y), (0, 0, 0, 0))
    return g


ACUTE = lambda y: [(5, y), (6, y), (4, y + 1), (5, y + 1)]
DIAER = lambda y: [(2, y), (3, y), (6, y), (7, y)]
TILDE = lambda y: [(3, y), (4, y), (7, y), (2, y + 1), (5, y + 1), (6, y + 1)]

extra = {}
for base, acc in zip("aeiou", "áéíóú"):
    g = glyph(base)
    if base == "i":
        g = clear_rows(g, 0, 6)
    extra[acc] = dots(g, ACUTE(3))
for base, acc in zip("AEIOU", "ÁÉÍÓÚ"):
    extra[acc] = dots(glyph(base), ACUTE(0))
extra["ü"] = dots(glyph("u"), DIAER(4))
extra["Ü"] = dots(glyph("U"), DIAER(0))
extra["ñ"] = dots(glyph("n"), TILDE(3))
extra["Ñ"] = dots(glyph("N"), TILDE(0))
extra["¿"] = glyph("?").rotate(180)
extra["¡"] = glyph("!").rotate(180)

all_glyphs = glyphs + "".join(extra)
n = len(all_glyphs)
out = Image.new("RGBA", (10 * n + 1, H), (0, 0, 0, 0))
for i, ch in enumerate(all_glyphs):
    for y in range(H):
        out.putpixel((10 * i, y), SEP)
    out.paste(extra[ch] if ch in extra else glyph(ch), (10 * i + 1, 0))
for y in range(H):
    out.putpixel((10 * n, y), SEP)

os.makedirs(OUT, exist_ok=True)
out.save(os.path.join(OUT, "plain.png"))
settings = json.load(open(os.path.join(KRISTAL, "assets", "fonts", "plain.json")))
settings["glyphs"] = all_glyphs
json.dump(settings, open(os.path.join(OUT, "plain.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=4)
print("plain.png:", n, "glifos")
