"""Tilesets originales (20x20 px por tile, 8 columnas x 4 filas = 32 tiles).

Índices comunes en todos los tilesets (los usa mapas.py):
  0 suelo A   1 suelo B   2 suelo C   3 camino/alfombra
  4 pared arriba*  5 pared frente*  6 pared deco 1*  7 pared deco 2*
  8 vacío*   9 objeto 1*  10 objeto 2*  11 objeto 3*
  12 deco suelo 1  13 deco suelo 2  14 borde/acantilado*  15 agua/peligro*
  16..23 objetos grandes (2x2 => 16,17 / 24,25 ; 18,19 / 26,27 ; ...)*  24..31 parte baja*
(* = sólido)
"""
import random
from pix import Canvas, hexc, shade, text3x5

T = 20
SOLID = {4, 5, 6, 7, 8, 9, 10, 11, 14, 15} | set(range(16, 32))


def tile_canvas():
    return Canvas(T, T)


def noise_floor(base, var, seed, density=10, pattern=None):
    cv = tile_canvas()
    cv.rect(0, 0, T, T, base)
    rnd = random.Random(seed)
    for _ in range(density):
        cv.put(rnd.randrange(T), rnd.randrange(T), var)
    if pattern == "tiles":
        cv.hline(0, T - 1, 0, shade(base, 0.85))
        cv.vline(0, 0, T - 1, shade(base, 0.85))
    elif pattern == "planks":
        for y in (0, 10):
            cv.hline(0, T - 1, y, shade(base, 0.75))
        cv.vline(7, 1, 9, shade(base, 0.75))
        cv.vline(15, 11, 19, shade(base, 0.75))
    elif pattern == "cobble":
        for (x, y) in ((1, 1), (11, 2), (4, 11), (14, 12)):
            cv.ellipse(x + 3, y + 3, 4, 3, shade(base, 1.1))
    elif pattern == "checker":
        cv.rect(0, 0, 10, 10, shade(base, 0.8))
        cv.rect(10, 10, 10, 10, shade(base, 0.8))
    elif pattern == "sparkle":
        for _ in range(2):
            x, y = rnd.randrange(2, 18), rnd.randrange(2, 18)
            cv.put(x, y, var)
            cv.put(x - 1, y, shade(var, 0.6))
            cv.put(x + 1, y, shade(var, 0.6))
            cv.put(x, y - 1, shade(var, 0.6))
            cv.put(x, y + 1, shade(var, 0.6))
    return cv


def wall_face(base, trim, kind=None):
    cv = tile_canvas()
    cv.rect(0, 0, T, T, base)
    cv.hline(0, T - 1, T - 1, shade(base, 0.6))
    cv.hline(0, T - 1, T - 2, shade(base, 0.8))
    if trim:
        cv.rect(0, 13, T, 3, trim)
    if kind == "brick":
        for y in range(0, T, 5):
            cv.hline(0, T - 1, y, shade(base, 0.7))
            off = 0 if (y // 5) % 2 == 0 else 5
            for x in range(off, T, 10):
                cv.vline(x, y, y + 4, shade(base, 0.7))
    return cv


def wall_top(base):
    cv = tile_canvas()
    cv.rect(0, 0, T, T, base)
    cv.hline(0, T - 1, T - 1, shade(base, 1.4))
    return cv


def make_tileset(theme):
    cv = Canvas(8 * T, 4 * T)
    tiles = {}
    p = THEMES[theme]
    tiles[0] = noise_floor(p["floor"], p["floor_var"], 1, pattern=p.get("pattern"))
    tiles[1] = noise_floor(shade(p["floor"], 0.95), p["floor_var"], 2, density=16, pattern=p.get("pattern"))
    tiles[2] = noise_floor(p["floor"], p.get("floor_detail", p["floor_var"]), 3, density=4, pattern="sparkle")
    tiles[3] = noise_floor(p["path"], shade(p["path"], 0.85), 4, pattern=p.get("path_pattern"))
    tiles[4] = wall_top(p["wall_top"])
    tiles[5] = wall_face(p["wall"], p.get("trim"), p.get("wall_kind"))
    tiles[6] = wall_face(p["wall"], p.get("trim"), p.get("wall_kind"))
    tiles[7] = wall_face(p["wall"], p.get("trim"), p.get("wall_kind"))
    v = tile_canvas()
    v.rect(0, 0, T, T, p.get("void", hexc("000000")))
    tiles[8] = v
    for i in (9, 10, 11, 12, 13, 14, 15) + tuple(range(16, 32)):
        tiles[i] = tile_canvas()
    # acantilado
    cl = tiles[14]
    cl.rect(0, 0, T, T, shade(p["floor"], 0.55))
    for x in range(0, T, 4):
        cl.vline(x, 2, T - 1, shade(p["floor"], 0.4))
    cl.hline(0, T - 1, 0, shade(p["floor"], 1.2))
    # agua/peligro
    w = tiles[15]
    w.rect(0, 0, T, T, p.get("water", hexc("2a4a8a")))
    for x in range(0, T, 6):
        w.hline(x, x + 3, 6, shade(p.get("water", hexc("2a4a8a")), 1.4))
        w.hline(x + 3, x + 5, 14, shade(p.get("water", hexc("2a4a8a")), 1.4))
    p["deco"](tiles, p)
    for i, t in tiles.items():
        cv.paste(t, (i % 8) * T, (i // 8) * T)
    return cv


# ---------------------------------------------------------------------------- decoración por tema
def big(tiles, idx, img):
    """Coloca una imagen de 40x40 en 4 tiles (idx, idx+1, idx+8, idx+9)."""
    full = Canvas(40, 40)
    full.paste(img, 0, 0)
    for k, (dx, dy) in enumerate(((0, 0), (1, 0), (0, 1), (1, 1))):
        t = tile_canvas()
        t.paste(full.im.crop((dx * T, dy * T, dx * T + T, dy * T + T)), 0, 0)
        tiles[idx + dx + dy * 8] = t


def deco_instituto(tiles, p):
    H = hexc
    # 6: pizarra   7: ventana
    t = tiles[6]
    t.rect(1, 3, 18, 11, H("1f4a2f"))
    t.rect(0, 2, 20, 1, H("8a6a3a"))
    t.rect(0, 14, 20, 2, H("8a6a3a"))
    text3x5(t, 2, 5, "PCDM", H("e8e8e8"))
    t = tiles[7]
    t.rect(3, 2, 14, 10, H("9fd8ff"))
    t.vline(10, 2, 11, H("ffffff"))
    t.hline(3, 16, 7, H("ffffff"))
    # 9: pupitre  10: taquilla  11: planta
    t = tiles[9]
    t.rect(2, 4, 16, 8, H("c8955a"))
    t.rect(2, 12, 2, 6, H("6a6a6a"))
    t.rect(16, 12, 2, 6, H("6a6a6a"))
    t.rect(6, 13, 8, 5, H("3f6fb0"))
    t.outline()
    t = tiles[10]
    t.rect(2, 0, 16, 20, H("4a7ab0"))
    t.vline(10, 0, 19, H("2a4a70"))
    for y in (3, 5, 7):
        t.hline(4, 8, y, H("2a4a70"))
        t.hline(12, 16, y, H("2a4a70"))
    t = tiles[11]
    t.rect(6, 12, 8, 7, H("b0603a"))
    t.ellipse(10, 8, 7, 6, H("3f9a4a"))
    t.outline()
    # 12: alfombra  13: papel en el suelo
    t = tiles[12]
    t.rect(0, 0, T, T, H("8a3a4a"))
    t.rect(2, 2, 16, 16, H("a04a5a"))
    t = tiles[13]
    t.rect(0, 0, T, T, p["floor"])
    t.rect(6, 7, 7, 5, H("ffffff"))
    t.hline(7, 11, 9, H("8a8aff"))
    # 16: mesa del profe (2x2)
    img = Canvas(40, 40)
    img.rect(2, 8, 36, 18, H("8a5a2b"))
    img.rect(2, 26, 4, 12, H("5a3a1a"))
    img.rect(34, 26, 4, 12, H("5a3a1a"))
    img.rect(8, 4, 10, 6, H("ffffff"))
    img.rect(24, 2, 8, 8, H("d12f2f"))  # manzana
    img.outline()
    big(tiles, 16, img)
    # 18: estantería
    img = Canvas(40, 40)
    img.rect(2, 0, 36, 40, H("6a4426"))
    for y in (8, 20, 32):
        img.rect(4, y - 6, 32, 6, H("3a2a1a"))
        for x in range(5, 34, 4):
            img.rect(x, y - 6, 3, 6, H(random.Random(x * y).choice(["d12f2f", "2fa04a", "1e5bb8", "f5cd30"])))
    big(tiles, 18, img)
    # 20: máquina expendedora
    img = Canvas(40, 40)
    img.rect(6, 0, 28, 40, H("d12f2f"))
    img.rect(9, 4, 16, 26, H("bfe6ff"))
    for y in range(6, 28, 6):
        img.hline(10, 24, y, H("ffffff"))
    img.rect(27, 10, 4, 10, H("2a2a2a"))
    big(tiles, 20, img)
    # 22: pizarra grande con dibujo de Thomas
    img = Canvas(40, 40)
    img.rect(0, 4, 40, 26, H("1f4a2f"))
    img.rect(8, 12, 18, 10, H("bfbfbf"))
    img.ellipse(28, 18, 5, 5, H("bfbfbf"))
    text3x5(img, 2, 6, "CHU CHU", H("ffffff"))
    big(tiles, 22, img)


def deco_casa(tiles, p):
    H = hexc
    t = tiles[6]
    t.rect(4, 2, 12, 12, H("ff9ccf"))
    t.ellipse(10, 8, 4, 4, H("ffffff"))
    t.put(9, 7, H("1a1a1a"))
    t.put(11, 7, H("1a1a1a"))
    t = tiles[7]
    t.rect(3, 1, 14, 14, H("1a1a1a"))
    text3x5(t, 4, 3, "PROV", H("ffffff"))
    text3x5(t, 4, 9, "WRNG", H("d12f2f"))
    t = tiles[9]
    t.rect(1, 2, 18, 12, H("6a4426"))
    t.rect(4, 0, 12, 8, H("1a1a1a"))
    t.rect(5, 1, 10, 6, H("3f6fb0"))
    t.outline()
    t = tiles[10]
    t.rect(2, 2, 16, 16, H("8a5a2b"))
    t.rect(4, 4, 12, 4, H("d12f2f"))
    t.rect(4, 10, 12, 4, H("2fa04a"))
    t = tiles[11]
    t.ellipse(10, 10, 7, 7, H("f0954a"))
    t.tri([(4, 6), (6, 0), (9, 5)], H("f0954a"))
    t.tri([(11, 5), (14, 0), (16, 6)], H("f0954a"))
    t.rect(7, 9, 2, 2, H("1a1a1a"))
    t.rect(12, 9, 2, 2, H("1a1a1a"))
    t.outline()
    t = tiles[12]
    t.rect(0, 0, T, T, H("5a6aa0"))
    t.rect(2, 2, 16, 16, H("6a7ab0"))
    t = tiles[13]
    t.rect(0, 0, T, T, p["floor"])
    t.rect(5, 8, 9, 4, H("e0e0e0"))
    # 16: cama
    img = Canvas(40, 40)
    img.rect(2, 2, 36, 36, H("6a4426"))
    img.rect(4, 4, 32, 10, H("ffffff"))
    img.rect(4, 14, 32, 22, H("b48cd8"))
    img.outline()
    big(tiles, 16, img)
    # 18: armario de casa
    img = Canvas(40, 40)
    img.rect(2, 0, 36, 40, H("8a5a2b"))
    img.vline(20, 0, 39, H("3a2a1a"))
    img.rect(16, 18, 2, 5, H("e0c040"))
    img.rect(22, 18, 2, 5, H("e0c040"))
    big(tiles, 18, img)
    # 20: maniquí con cosplay de Warhammer (cartón)
    img = Canvas(40, 40)
    img.rect(12, 0, 16, 12, H("c8a46e"))
    img.rect(15, 4, 10, 3, H("2a8a3a"))
    img.rect(6, 12, 28, 18, H("c8a46e"))
    img.ellipse(8, 14, 6, 5, H("a8844e"))
    img.ellipse(32, 14, 6, 5, H("a8844e"))
    img.rect(18, 30, 4, 10, H("5a3a1a"))
    img.outline()
    big(tiles, 20, img)
    # 22: escritorio gamer con WoW
    img = Canvas(40, 40)
    img.rect(0, 14, 40, 8, H("2a2a2a"))
    img.rect(6, 0, 28, 14, H("111111"))
    img.rect(8, 2, 24, 10, H("3a2a8a"))
    text3x5(img, 10, 4, "WOW", H("f5cd30"))
    img.rect(2, 22, 4, 18, H("2a2a2a"))
    img.rect(34, 22, 4, 18, H("2a2a2a"))
    img.ellipse(20, 32, 6, 6, H("d12f2f"))
    big(tiles, 22, img)


def deco_calle(tiles, p):
    H = hexc
    t = tiles[6]  # balcón canario
    t.rect(1, 2, 18, 12, H("2f6a2f"))
    for x in range(2, 18, 3):
        t.vline(x, 4, 12, H("1f4a1f"))
    t.rect(0, 13, 20, 2, H("1f4a1f"))
    t = tiles[7]  # puerta
    t.rect(4, 2, 12, 18, H("6a3a1a"))
    t.rect(13, 10, 2, 2, H("e0c040"))
    t = tiles[9]  # palmera (tronco)
    t.rect(8, 0, 4, 20, H("8a6a3a"))
    for y in range(2, 20, 4):
        t.hline(8, 11, y, H("6a4a2a"))
    t = tiles[10]  # papelera
    t.rect(5, 6, 10, 14, H("2fa04a"))
    t.rect(4, 4, 12, 3, H("1f7a3a"))
    t.outline()
    t = tiles[11]  # banco
    t.rect(1, 6, 18, 4, H("8a5a2b"))
    t.rect(1, 12, 18, 3, H("8a5a2b"))
    t.rect(2, 15, 2, 5, H("3a3a3a"))
    t.rect(16, 15, 2, 5, H("3a3a3a"))
    t.outline()
    t = tiles[12]  # paso de cebra
    t.rect(0, 0, T, T, p["path"])
    t.rect(0, 2, T, 6, H("f2f2f2"))
    t.rect(0, 12, T, 6, H("f2f2f2"))
    t = tiles[13]  # flores
    t.rect(0, 0, T, T, H("4f9a3f"))
    for (x, y, c) in ((4, 4, "ff5fa2"), (12, 6, "ffd23f"), (7, 13, "ffffff"), (15, 14, "ff8c00")):
        t.rect(x, y, 2, 2, H(c))
    # 16: copa de palmera
    img = Canvas(40, 40)
    for a in range(0, 360, 45):
        import math
        x1 = 20 + math.cos(math.radians(a)) * 19
        y1 = 22 + math.sin(math.radians(a)) * 14
        img.line(20, 22, x1, y1, H("3f9a4a"))
        img.line(20, 23, x1, y1 + 1, H("2f7a3a"))
    img.ellipse(20, 22, 4, 3, H("6a4a2a"))
    big(tiles, 16, img)
    # 18: parada de guagua
    img = Canvas(40, 40)
    img.rect(2, 4, 36, 4, H("1e5bb8"))
    img.rect(2, 8, 2, 32, H("9a9a9a"))
    img.rect(36, 8, 2, 32, H("9a9a9a"))
    img.rect(6, 12, 28, 16, H("bfe6ff"))
    text3x5(img, 8, 14, "GUAGUA", H("1e5bb8"))
    img.rect(6, 30, 28, 4, H("8a5a2b"))
    big(tiles, 18, img)
    # 20: ventana de Aridai (casa)
    img = Canvas(40, 40)
    img.rect(0, 0, 40, 40, p["wall"])
    img.rect(8, 6, 24, 24, H("2a2a3a"))
    img.rect(10, 8, 20, 20, H("bfe6ff"))
    img.vline(20, 8, 27, H("ffffff"))
    big(tiles, 20, img)
    # 22: coche aparcado
    img = Canvas(40, 40)
    img.rect(2, 12, 36, 16, H("d12f2f"))
    img.rect(8, 4, 24, 10, H("b01f1f"))
    img.rect(10, 6, 9, 7, H("bfe6ff"))
    img.rect(21, 6, 9, 7, H("bfe6ff"))
    img.ellipse(10, 30, 5, 5, H("1a1a1a"))
    img.ellipse(30, 30, 5, 5, H("1a1a1a"))
    img.outline()
    big(tiles, 22, img)


def deco_pino(tiles, p):
    H = hexc
    t = tiles[6]
    for x in range(0, 20, 4):
        t.rect(x, 3, 3, 3, H(["ff5fa2", "ffd23f", "6fb8ff", "5fbf2f", "ff8c00"][x // 4]))
    t.hline(0, 19, 2, H("2a2a2a"))
    t = tiles[7]
    t.rect(2, 1, 16, 14, H("f2e8d0"))
    text3x5(t, 3, 3, "PINO", H("8a3a1a"))
    text3x5(t, 3, 9, "2025", H("8a3a1a"))
    t = tiles[9]  # barril de ron
    t.ellipse(10, 11, 7, 8, H("8a5a2b"))
    t.hline(3, 16, 7, H("3a3a3a"))
    t.hline(3, 16, 14, H("3a3a3a"))
    t.outline()
    t = tiles[10]  # mesa con chupitos
    t.rect(1, 6, 18, 6, H("c8955a"))
    for x in (3, 8, 13):
        t.rect(x, 2, 3, 4, H("f0d070"))
    t.rect(2, 12, 2, 8, H("6a4426"))
    t.rect(16, 12, 2, 8, H("6a4426"))
    t.outline()
    t = tiles[11]  # farola
    t.rect(9, 4, 2, 16, H("2a2a2a"))
    t.ellipse(10, 4, 4, 3, H("ffd23f"))
    t = tiles[12]
    t.rect(0, 0, T, T, p["floor"])
    t.rect(5, 6, 6, 4, H("ff5fa2"))  # confeti
    t.rect(12, 12, 3, 3, H("6fb8ff"))
    t = tiles[13]
    t.rect(0, 0, T, T, p["floor"])
    t.rect(7, 8, 5, 6, H("3c8a3c"))  # botella tirada
    # 16: ventorrillo (puesto)
    img = Canvas(40, 40)
    img.rect(0, 0, 40, 8, H("d12f2f"))
    for x in range(0, 40, 8):
        img.rect(x, 0, 4, 8, H("ffffff"))
    img.rect(2, 8, 2, 32, H("6a4426"))
    img.rect(36, 8, 2, 32, H("6a4426"))
    img.rect(2, 24, 36, 8, H("c8955a"))
    text3x5(img, 6, 12, "CHURROS", H("ffffff"))
    big(tiles, 16, img)
    # 18: puesto de ron miel
    img = Canvas(40, 40)
    img.rect(0, 0, 40, 8, H("1e5bb8"))
    for x in range(0, 40, 8):
        img.rect(x, 0, 4, 8, H("ffd23f"))
    img.rect(2, 8, 2, 32, H("6a4426"))
    img.rect(36, 8, 2, 32, H("6a4426"))
    img.rect(2, 24, 36, 8, H("c8955a"))
    text3x5(img, 6, 12, "RON MIEL", H("ffffff"))
    for x in (8, 16, 24):
        img.rect(x, 18, 4, 6, H("d08a30"))
    big(tiles, 18, img)
    # 20: fachada de la basílica
    img = Canvas(40, 40)
    img.rect(0, 0, 40, 40, H("e8e0c8"))
    img.rect(14, 14, 12, 26, H("6a3a1a"))
    img.ellipse(20, 14, 6, 6, H("6a3a1a"))
    img.rect(2, 2, 36, 4, H("9a8a6a"))
    big(tiles, 20, img)
    # 22: escenario de la verbena
    img = Canvas(40, 40)
    img.rect(0, 20, 40, 20, H("3a2a4a"))
    img.rect(0, 0, 40, 4, H("ff5fa2"))
    for x in (6, 20, 34):
        img.ellipse(x, 10, 3, 3, H("ffd23f"))
    big(tiles, 22, img)


def deco_dark_generic(kind):
    def deco(tiles, p):
        H = hexc
        acc = p["accent"]
        t = tiles[6]
        t.rect(0, 0, T, T, p["wall"])
        for i in range(3):
            t.put(4 + i * 6, 6 + (i % 2) * 5, acc)
        t = tiles[7]
        t.rect(0, 0, T, T, p["wall"])
        t.rect(6, 4, 8, 10, shade(acc, 0.6))
        # objetos 9..11 según la zona
        if kind == "llanuras":
            o9 = tiles[9]   # árbol-percha
            o9.rect(9, 6, 2, 14, H("c79a5a"))
            o9.poly([(10, 2), (19, 9), (1, 9)], H("c79a5a"))
            o9.poly([(10, 5), (15, 8), (5, 8)], (0, 0, 0, 0))
            o9.ellipse(10, 1, 2, 2, H("bfbfbf"))
            o9.outline()
            o10 = tiles[10]  # arbusto de ropa
            o10.ellipse(10, 12, 9, 7, H("b48cd8"))
            o10.ellipse(6, 10, 4, 4, H("ff9ccf"))
            o10.ellipse(14, 9, 4, 4, H("6fb8ff"))
            o10.outline()
            o11 = tiles[11]  # calcetín perdido gigante
            o11.rect(7, 1, 6, 13, H("ff9ccf"))
            o11.rect(7, 13, 10, 5, H("ff9ccf"))
            for y in range(2, 14, 3):
                o11.hline(7, 12, y, H("ffffff"))
            o11.outline()
        elif kind == "bosque":
            o9 = tiles[9]   # árbol-tijera
            o9.line(10, 19, 3, 1, H("d9e1e8"))
            o9.line(10, 19, 17, 1, H("d9e1e8"))
            o9.line(11, 19, 4, 1, H("aab4bd"))
            o9.ellipse(10, 17, 3, 3, H("d12f2f"))
            o9.outline()
            o10 = tiles[10]
            o10.ellipse(10, 11, 8, 8, H("1f5a4a"))
            o10.ellipse(7, 8, 3, 3, H("2f7a6a"))
            o10.outline()
            o11 = tiles[11]  # silla rota tirada
            o11.rect(3, 8, 14, 3, H("8a5a2b"))
            o11.line(4, 11, 2, 18, H("6a4426"))
            o11.line(16, 11, 18, 16, H("6a4426"))
            o11.outline()
        elif kind == "plato":
            o9 = tiles[9]   # foco de plató
            o9.rect(8, 8, 4, 12, H("3a3a3a"))
            o9.ellipse(10, 6, 6, 5, H("2a2a2a"))
            o9.ellipse(10, 6, 3, 3, H("ffd23f"))
            o9.outline()
            o10 = tiles[10]  # cámara
            o10.rect(3, 6, 12, 8, H("2a2a2a"))
            o10.rect(15, 8, 4, 4, H("4a4a4a"))
            o10.rect(8, 14, 2, 6, H("3a3a3a"))
            o10.put(5, 8, H("d12f2f"))
            o10.outline()
            o11 = tiles[11]  # hormiguero
            o11.ellipse(10, 14, 9, 6, H("8a6a3a"))
            o11.ellipse(10, 13, 2, 2, H("1a1a1a"))
            o11.outline()
        elif kind == "cortijo":
            o9 = tiles[9]   # valla
            o9.rect(0, 6, 20, 2, H("8a5a2b"))
            o9.rect(0, 12, 20, 2, H("8a5a2b"))
            o9.rect(3, 3, 2, 16, H("6a4426"))
            o9.rect(15, 3, 2, 16, H("6a4426"))
            o10 = tiles[10]  # bala de paja
            o10.rect(2, 6, 16, 12, H("e0c060"))
            for x in range(3, 17, 3):
                o10.vline(x, 7, 16, H("c0a040"))
            o10.outline()
            o11 = tiles[11]  # toro de cartón
            o11.rect(2, 4, 16, 10, H("1a1a1a"))
            o11.rect(2, 14, 2, 6, H("1a1a1a"))
            o11.rect(16, 14, 2, 6, H("1a1a1a"))
            o11.line(16, 4, 19, 1, H("efe6cf"))
            o11.outline()
        elif kind == "trump":
            o9 = tiles[9]   # columna dorada
            o9.rect(5, 0, 10, 20, H("e0b830"))
            o9.vline(8, 0, 19, H("f5d860"))
            o10 = tiles[10]  # pila de hamburguesas
            for i in range(3):
                o10.ellipse(10, 15 - i * 5, 8, 3, H("c8803a"))
                o10.hline(3, 17, 15 - i * 5, H("5a2a1a"))
            o10.outline()
            o11 = tiles[11]  # cartel MAGA
            o11.rect(2, 2, 16, 10, H("d12f2f"))
            text3x5(o11, 3, 4, "MAGA", H("ffffff"))
            o11.rect(9, 12, 2, 8, H("6a4426"))
            o11.outline()
        else:  # aroy / final
            o9 = tiles[9]   # monolito con ojo sangrante
            o9.rect(4, 0, 12, 20, H("1a1a1a"))
            o9.rect(8, 5, 4, 3, H("f1efe9"))
            o9.rect(9, 6, 2, 1, H("ff2a2a"))
            o9.vline(9, 8, 16, H("a0000a"))
            o10 = tiles[10]  # glitch
            rnd = random.Random(7)
            for _ in range(40):
                o10.rect(rnd.randrange(20), rnd.randrange(20), rnd.randrange(1, 5), 1,
                         H(rnd.choice(["ff2a2a", "2aff2a", "2a2aff", "ffffff"])))
            o11 = tiles[11]  # almas en jaula
            o11.rect(3, 0, 14, 20, H("3a3a3a"))
            for x in range(4, 17, 3):
                o11.vline(x, 0, 19, H("6a6a6a"))
            o11.rect(8, 8, 4, 4, H("ff2a2a"))
        t = tiles[12]
        t.rect(0, 0, T, T, p["floor"])
        t.ellipse(10, 10, 4, 4, acc)
        t.ellipse(10, 10, 2, 2, shade(acc, 1.4))
        t = tiles[13]
        t.rect(0, 0, T, T, p["floor"])
        for i in range(5):
            t.put(3 + i * 3, 4 + (i * 7) % 12, acc)
        # 16: gran objeto (2x2): fuente/columna/árbol enorme
        img = Canvas(40, 40)
        if kind == "llanuras":
            img.rect(4, 0, 32, 40, H("8a5a2b"))
            img.rect(6, 2, 28, 36, H("0a0012"))
            for i in range(8):
                img.put(10 + (i * 5) % 22, 6 + (i * 11) % 30, acc)
        elif kind == "bosque":
            img.line(20, 39, 2, 0, H("d9e1e8"))
            img.line(20, 39, 38, 0, H("d9e1e8"))
            img.line(21, 39, 3, 0, H("aab4bd"))
            img.line(19, 39, 37, 0, H("aab4bd"))
            img.ellipse(20, 34, 6, 6, H("d12f2f"))
        elif kind == "plato":
            img.rect(0, 10, 40, 30, H("2a2a2a"))
            img.rect(4, 14, 32, 22, H("1e5bb8"))
            text3x5(img, 6, 22, "APLAUSOS", H("ffd23f"))
        elif kind == "cortijo":
            img.rect(0, 14, 40, 26, H("f2f2f2"))
            img.poly([(0, 14), (20, 0), (40, 14)], H("b5523a"))
            img.rect(16, 24, 8, 16, H("6a3a1a"))
        elif kind == "trump":
            img.rect(0, 0, 40, 40, H("b5523a"))
            for y in range(0, 40, 6):
                img.hline(0, 39, y, H("e8d8c0"))
            text3x5(img, 4, 16, "THE WALL", H("ffffff"))
        else:
            img.rect(10, 0, 20, 40, H("1a1a1a"))
            img.ellipse(20, 14, 7, 9, H("f1efe9"))
            img.vline(17, 14, 36, H("a0000a"))
            img.vline(23, 14, 36, H("a0000a"))
        big(tiles, 16, img)
        # 18: savepoint decorativo / cristal oscuro
        img = Canvas(40, 40)
        img.poly([(20, 2), (34, 20), (20, 38), (6, 20)], shade(acc, 0.7))
        img.poly([(20, 6), (30, 20), (20, 34), (10, 20)], acc)
        img.outline()
        big(tiles, 18, img)
        # 20: arco de entrada
        img = Canvas(40, 40)
        img.rect(0, 0, 8, 40, p["wall"])
        img.rect(32, 0, 8, 40, p["wall"])
        img.rect(0, 0, 40, 8, p["wall"])
        img.rect(8, 8, 24, 32, (0, 0, 0, 0))
        big(tiles, 20, img)
        # 22: roca grande
        img = Canvas(40, 40)
        img.ellipse(20, 24, 18, 14, shade(p["wall"], 1.2))
        img.ellipse(14, 18, 6, 4, shade(p["wall"], 1.5))
        img.outline()
        big(tiles, 22, img)
    return deco


H = hexc
THEMES = {
    "instituto": dict(floor=H("d8c8a0"), floor_var=H("c8b890"), path=H("b04a5a"), pattern="tiles",
                      wall=H("a8c8a0"), wall_top=H("4a5a48"), trim=H("7a9a70"), deco=deco_instituto),
    "casa": dict(floor=H("b8875a"), floor_var=H("a8774a"), path=H("5a6aa0"), pattern="planks",
                 wall=H("c8b8e0"), wall_top=H("4a3a5a"), trim=H("a898c0"), deco=deco_casa),
    "casa_andres": dict(floor=H("6a5a4a"), floor_var=H("5a4a3a"), path=H("4a2a2a"), pattern="planks",
                        wall=H("3a4a3a"), wall_top=H("1a221a"), trim=H("6a1a1a"), deco=deco_casa),
    "calle": dict(floor=H("c8c0b0"), floor_var=H("b0a898"), path=H("5a5a60"), pattern="tiles",
                  wall=H("f2eee6"), wall_top=H("b5523a"), trim=H("d8a04a"), deco=deco_calle, water=H("3a7ac8")),
    "pino": dict(floor=H("a89a8a"), floor_var=H("988a7a"), path=H("8a6a4a"), pattern="cobble",
                 wall=H("e8e0c8"), wall_top=H("6a5a4a"), trim=H("2f6a2f"), deco=deco_pino),
    "llanuras": dict(floor=H("3a2050"), floor_var=H("ff7ad9"), path=H("5a3a7a"), pattern=None,
                     wall=H("2a1438"), wall_top=H("140a1e"), accent=H("ff7ad9"), deco=deco_dark_generic("llanuras"),
                     water=H("3a1a6a")),
    "bosque": dict(floor=H("1f3a3a"), floor_var=H("8fe0d0"), path=H("2f4f4f"), pattern=None,
                   wall=H("142828"), wall_top=H("0a1414"), accent=H("8fe0d0"), deco=deco_dark_generic("bosque"),
                   water=H("0f2a3a")),
    "plato": dict(floor=H("3a3a5a"), floor_var=H("ffd23f"), path=H("8a1a2a"), pattern="checker",
                  wall=H("2a2a40"), wall_top=H("101020"), accent=H("ffd23f"), deco=deco_dark_generic("plato")),
    "cortijo": dict(floor=H("6a5a3a"), floor_var=H("8a7a4a"), path=H("8a6a3a"), pattern=None,
                    wall=H("4a6a2a"), wall_top=H("2a3a1a"), accent=H("5fbf2f"), deco=deco_dark_generic("cortijo")),
    "trump": dict(floor=H("b89a3a"), floor_var=H("f5d860"), path=H("a01f2f"), pattern="tiles",
                  wall=H("b5523a"), wall_top=H("5a2a1a"), accent=H("f5d860"), wall_kind="brick",
                  deco=deco_dark_generic("trump")),
    "aroy": dict(floor=H("141018"), floor_var=H("ff2a2a"), path=H("2a0a0e"), pattern=None,
                 wall=H("0a0a0e"), wall_top=H("000000"), accent=H("ff2a2a"), deco=deco_dark_generic("aroy"),
                 water=H("3a0008")),
}
