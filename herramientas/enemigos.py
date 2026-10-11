"""Sprites originales de enemigos de a pie (objetos personificados), jefes especiales y objetos."""
import os
from PIL import Image
from pix import Canvas, hexc, shade, text3x5, text_width3x5, OUTLINE

H = hexc
EYE = H("231a2e")
W_ = H("ffffff")


def face(cv, x, y, mood="normal", s=1):
    """Cara sencilla (dos ojos + boca) centrada en x,y."""
    if mood == "angry":
        cv.line(x - 5, y - 3, x - 2, y - 2, EYE)
        cv.line(x + 5, y - 3, x + 2, y - 2, EYE)
    cv.rect(x - 4, y - 1, 2, 2 + s, EYE)
    cv.rect(x + 2, y - 1, 2, 2 + s, EYE)
    if mood == "happy":
        cv.hline(x - 2, x + 1, y + 3, EYE)
        cv.put(x - 3, y + 2, EYE)
        cv.put(x + 2, y + 2, EYE)
    elif mood == "sad":
        cv.hline(x - 2, x + 1, y + 3, EYE)
        cv.put(x - 3, y + 4, EYE)
        cv.put(x + 2, y + 4, EYE)
    elif mood == "angry":
        cv.rect(x - 2, y + 3, 4, 2, EYE)
    elif mood == "hurt":
        cv.line(x - 4, y - 1, x - 2, y + 1, EYE)
        cv.line(x - 2, y - 1, x - 4, y + 1, EYE)
        cv.rect(x - 1, y + 3, 3, 2, EYE)
    elif mood == "spared":
        cv.hline(x - 4, x - 2, y, EYE)
        cv.hline(x + 2, x + 4, y, EYE)
        cv.hline(x - 1, x + 1, y + 3, EYE)
    else:
        cv.hline(x - 1, x + 1, y + 3, EYE)


def legs(cv, x, y, n=2, c=EYE, f=0):
    for i in range(n):
        lx = x + i * 6 - (n - 1) * 3
        cv.vline(lx, y, y + 3, c)
        cv.hline(lx - 1 + (f if i == 0 else -f), lx + 1, y + 4, c)


def finish(cv):
    cv.outline()
    return cv


# ---------------------------------------------------------------------------- MOBS
def silla(mood, f):
    cv = Canvas(40, 48)
    wood = H("9a6232")
    dk = shade(wood, 0.7)
    ghost = (150, 200, 255, 120)
    if mood != "spared":
        cv.ellipse(20, 26, 17, 20, ghost)
    yy = 2 + (f % 2)
    cv.rect(10, yy + 4, 20, 16, wood)  # respaldo
    cv.rect(12, yy + 6, 16, 2, dk)
    cv.rect(8, yy + 20, 24, 4, wood)   # asiento
    cv.rect(9, yy + 24, 3, 14, dk)
    cv.rect(28, yy + 24, 3, 9, dk)     # pata rota
    cv.line(28, yy + 33, 31, yy + 35, dk)
    cv.rect(20, yy + 26, 2, 3, (0, 0, 0, 0))
    face(cv, 20, yy + 12, {"normal": "sad", "hurt": "hurt", "spared": "spared"}.get(mood, mood))
    # grieta
    cv.line(14, yy + 4, 17, yy + 10, dk)
    cv.line(17, yy + 10, 15, yy + 16, dk)
    return finish(cv)


def tijera(mood, f):
    cv = Canvas(36, 48)
    blade = H("d9e1e8")
    red = H("d12f2f")
    o = 3 if f % 2 else 0
    cv.poly([(17, 24), (19, 24), (12 - o, 2), (10 - o, 3)], blade)
    cv.poly([(17, 24), (19, 24), (26 + o, 2), (24 + o, 3)], blade)
    cv.ellipse(18, 24, 2, 2, H("9aa4ad"))
    cv.ellipse(12, 34, 6, 6, red)
    cv.ellipse(24, 34, 6, 6, red)
    cv.ellipse(12, 34, 3, 3, (0, 0, 0, 0))
    cv.ellipse(24, 34, 3, 3, (0, 0, 0, 0))
    m = {"hurt": "hurt", "spared": "spared"}.get(mood, "angry")
    face(cv, 18, 15, m)
    legs(cv, 18, 41, 2, H("7a0000"), f % 2)
    return finish(cv)


def dibujo(mood, f):
    cv = Canvas(40, 48)
    paper = H("f4f0e6")
    cv.rect(6, 3 + f % 2, 28, 34, paper)
    cv.tri([(26, 3 + f % 2), (34, 3 + f % 2), (34, 11 + f % 2)], H("d9d2c0"))
    # garabato furro (muy mal dibujado, como debe ser)
    ink = H("4a4a8a")
    cv.ellipse(20, 15 + f % 2, 6, 5, H("f0954a"))
    cv.tri([(15, 12), (17, 6), (19, 12)], H("f0954a"))
    cv.tri([(21, 12), (23, 6), (25, 12)], H("f0954a"))
    cv.rect(15, 21, 10, 9, H("f0954a"))
    cv.put(18, 15, ink)
    cv.put(22, 15, ink)
    # barra de censura
    if mood != "spared":
        cv.rect(4, 19 + f % 2, 32, 7, H("111111"))
        text3x5(cv, 6, 20 + f % 2, "CENSURA", H("ffffff"))
    for i in range(3):
        cv.put(32, 30 + i, H("ff7ab8"))
    if mood == "hurt":
        cv.line(8, 6, 30, 34, H("c02020"))
    legs(cv, 20, 38, 2, EYE, f % 2)
    return finish(cv)


def pastilla(kind):
    def draw(mood, f):
        cv = Canvas(36, 44)
        a = H("ff9ccf") if kind == "e" else H("6fb8ff")
        b = H("ffffff")
        y = 6 + (f % 2)
        cv.ellipse(18, y + 8, 9, 9, a)
        cv.rect(9, y + 8, 19, 12, a)
        cv.rect(9, y + 20, 19, 6, b)
        cv.ellipse(18, y + 26, 9, 8, b)
        cv.hline(9, 27, y + 20, shade(a, 0.7))
        text3x5(cv, 16, y + 3, "E" if kind == "e" else "T", W_)
        face(cv, 18, y + 13, {"hurt": "hurt", "spared": "spared"}.get(mood, "happy" if kind == "e" else "angry"))
        cv.vline(5, y + 14, y + 18, a)
        cv.vline(31, y + 14, y + 18, a)
        return finish(cv)
    return draw


def garra(mood, f):
    cv = Canvas(44, 44)
    fur = H("f0954a")
    pad = H("ffb3c6")
    y = 4 + f % 2
    cv.ellipse(22, y + 20, 15, 13, fur)
    for i, (x, yy) in enumerate([(10, y + 8), (18, y + 4), (26, y + 4), (34, y + 8)]):
        cv.ellipse(x, yy, 4, 5, fur)
        cv.ellipse(x, yy + 1, 2, 2.5, pad)
        cv.line(x, yy - 5, x + (1 if i > 1 else -1), yy - 8, H("eeeeee"))
    cv.ellipse(22, y + 22, 7, 6, pad)
    face(cv, 22, y + 21, {"hurt": "hurt", "spared": "spared"}.get(mood, "happy"))
    cv.rect(16, y + 33, 12, 5, H("ffffff"))
    return finish(cv)


def abanico(mood, f):
    cv = Canvas(48, 44)
    cols = ["e40303", "ff8c00", "ffed00", "008026", "004dff", "750787"]
    cx, cy = 24, 32
    import math
    spread = 0.15 if f % 2 else 0
    for i, c in enumerate(cols):
        a0 = math.pi + (i / 6) * math.pi - spread
        a1 = math.pi + ((i + 1) / 6) * math.pi + spread
        pts = [(cx, cy)]
        for k in range(6):
            a = a0 + (a1 - a0) * k / 5
            pts.append((cx + math.cos(a) * 22, cy + math.sin(a) * 22))
        cv.poly(pts, H(c))
    cv.rect(22, cy, 4, 10, H("5a3a1a"))
    face(cv, 24, 22, {"hurt": "hurt", "spared": "spared"}.get(mood, "happy"))
    return finish(cv)


def ladrillo(mood, f):
    cv = Canvas(44, 40)
    br = H("b5523a")
    y = 8 + f % 2
    cv.rect(4, y, 36, 22, br)
    for yy in (y + 7, y + 14):
        cv.hline(4, 39, yy, H("e8d8c0"))
    for xx in (14, 30):
        cv.vline(xx, y, y + 6, H("e8d8c0"))
        cv.vline(xx - 8, y + 8, y + 13, H("e8d8c0"))
        cv.vline(xx + 6, y + 15, y + 21, H("e8d8c0"))
    # gorra roja
    cv.rect(12, y - 7, 20, 7, H("d12f2f"))
    cv.rect(30, y - 2, 6, 2, H("a01f1f"))
    text3x5(cv, 14, y - 6, "MAGA", W_)
    face(cv, 22, y + 10, {"hurt": "hurt", "spared": "spared"}.get(mood, "angry"))
    legs(cv, 22, y + 22, 2, EYE, f % 2)
    return finish(cv)


def marine(mood, f):
    cv = Canvas(44, 52)
    cb = H("c8a46e")
    dk = shade(cb, 0.75)
    tape = H("d8d0b0")
    y = 2 + f % 2
    cv.rect(12, y, 20, 16, cb)          # casco de cartón
    cv.rect(15, y + 6, 14, 4, H("2a8a3a"))  # visor
    cv.rect(4, y + 16, 36, 22, cb)      # armadura
    cv.ellipse(7, y + 18, 7, 6, dk)     # hombreras
    cv.ellipse(37, y + 18, 7, 6, dk)
    cv.rect(18, y + 20, 8, 10, H("b02020"))  # águila pintada con rotu
    cv.rect(14, y + 38, 6, 10, dk)
    cv.rect(24, y + 38, 6, 10, dk)
    cv.line(4, y + 28, 40, y + 32, tape)
    text3x5(cv, 8, y + 30, "ZARA", H("444444"))
    if mood == "hurt":
        cv.line(12, y, 30, y + 36, H("6a4a2a"))
    if mood == "spared":
        cv.rect(15, y + 6, 14, 4, H("8fd3ff"))
    return finish(cv)


def carpa(mood, f):
    cv = Canvas(60, 52)
    roof = H("1e3a8a")
    cv.poly([(4, 16), (56, 16), (48, 4 + f % 2), (12, 4 + f % 2)], roof)
    for x in range(8, 56, 8):
        cv.vline(x, 16, 19, H("ffffff"))
    cv.vline(8, 16, 46, H("9a9a9a"))
    cv.vline(52, 16, 46, H("9a9a9a"))
    cv.rect(10, 30, 40, 4, H("efefef"))  # mesa
    cv.rect(12, 34, 2, 12, H("777777"))
    cv.rect(46, 34, 2, 12, H("777777"))
    cv.rect(14, 17, 32, 13, H("ffffff"))
    text3x5(cv, 15, 18, "PROVE ME", H("d12f2f"))
    text3x5(cv, 20, 24, "WRONG", H("1e3a8a"))
    face(cv, 30, 39, {"hurt": "hurt", "spared": "spared"}.get(mood, "angry"))
    return finish(cv)


def papeleta(mood, f):
    cv = Canvas(40, 46)
    g = H("5fbf2f")
    y = 3 + f % 2
    cv.rect(6, y, 28, 32, W_)
    cv.rect(6, y, 28, 8, g)
    text3x5(cv, 14, y + 2, "VOX", W_)
    for i in range(3):
        cv.hline(10, 30, y + 12 + i * 4, H("bbbbbb"))
    face(cv, 20, y + 24, {"hurt": "hurt", "spared": "spared"}.get(mood, "angry"))
    legs(cv, 20, y + 33, 2, EYE, f % 2)
    return finish(cv)


def escano(mood, f):
    cv = Canvas(44, 48)
    red = H("a3182a")
    y = 2 + f % 2
    cv.rect(8, y, 28, 22, red)
    cv.rect(6, y + 22, 32, 8, shade(red, 0.85))
    cv.rect(6, y + 30, 4, 12, H("5a3a1a"))
    cv.rect(34, y + 30, 4, 12, H("5a3a1a"))
    for i in range(4):
        cv.rect(10 + i * 6, y + 2, 3, 6, H("f5cd30"))
    face(cv, 22, y + 15, {"hurt": "hurt", "spared": "spared"}.get(mood, "normal"))
    # maleta hacia Waterloo
    cv.rect(30, y + 34, 10, 8, H("2a2a2a"))
    cv.rect(33, y + 32, 4, 2, H("2a2a2a"))
    return finish(cv)


def sticker_from(path):
    def draw(mood, f):
        cv = Canvas(48, 48)
        try:
            src = Image.open(path).convert("RGBA")
            src = src.resize((40, 40), Image.BILINEAR)
            src = src.quantize(colors=24, method=Image.Quantize.FASTOCTREE).convert("RGBA")
            mask = Image.new("L", (40, 40), 0)
            mp = mask.load()
            for yy in range(40):
                for xx in range(40):
                    if (xx - 19.5) ** 2 + (yy - 19.5) ** 2 <= 19 ** 2:
                        mp[xx, yy] = 255
            src.putalpha(mask)
            cv.ellipse(24, 24 + f % 2, 22, 22, W_)
            cv.paste(src, 4, 4 + f % 2)
        except Exception:
            cv.ellipse(24, 24, 22, 22, W_)
            cv.ellipse(24, 24, 19, 19, H("a8322d"))
        if mood == "hurt":
            cv.line(6, 6, 42, 42, H("ffffff"))
            cv.line(7, 6, 43, 42, H("ffffff"))
        if mood == "spared":
            cv.recolor(lambda p: (min(255, p[0] + 40), min(255, p[1] + 40), min(255, p[2] + 40), p[3]))
        cv.outline()
        return cv
    return draw


def hormiga(kind):
    def draw(mood, f):
        cv = Canvas(48, 56)
        col = H("e0b040") if kind == "trancas" else H("d08a30")
        y = 4 + f % 2
        cv.ellipse(24, y + 10, 11, 10, col)          # cabeza enorme
        cv.ellipse(24, y + 30, 8, 9, shade(col, 0.9))
        cv.ellipse(24, y + 44, 6, 6, shade(col, 0.8))
        cv.line(18, y + 2, 12, y - 3 + f % 2, H("2a2a2a"))
        cv.line(30, y + 2, 36, y - 3 + f % 2, H("2a2a2a"))
        cv.ellipse(19, y + 9, 4, 4, W_)
        cv.ellipse(29, y + 9, 4, 4, W_)
        cv.rect(18, y + 9, 2, 3, EYE)
        cv.rect(28, y + 9, 2, 3, EYE)
        if mood == "hurt":
            cv.rect(20, y + 15, 8, 3, EYE)
        else:
            cv.hline(20, 28, y + 15, EYE)
        for i in range(3):
            cv.line(16, y + 26 + i * 4, 8, y + 30 + i * 4, H("2a2a2a"))
            cv.line(32, y + 26 + i * 4, 40, y + 30 + i * 4, H("2a2a2a"))
        cv.rect(16, y + 22, 16, 3, H("d12f2f") if kind == "trancas" else H("1e5bb8"))  # pajarita
        return finish(cv)
    return draw


MOBS = {
    "silla": silla, "tijera": tijera, "dibujo": dibujo, "pastilla_e": pastilla("e"),
    "pastilla_t": pastilla("t"), "garra": garra, "abanico": abanico, "ladrillo": ladrillo,
    "marine": marine, "carpa": carpa, "papeleta": papeleta, "escano": escano,
    "trancas": hormiga("trancas"), "barrancas": hormiga("barrancas"),
}


# ---------------------------------------------------------------------------- ESPECIALES
def percha(frame, view="down"):
    """El Príncipe Percha: guía del Dark World (una percha con bufanda)."""
    cv = Canvas(26, 44)
    wood = H("c79a5a")
    y = 2 + (frame % 2)
    cv.ellipse(13, y + 4, 3, 3, H("bfbfbf"))           # gancho
    cv.ellipse(13, y + 4, 1.5, 1.5, (0, 0, 0, 0))
    cv.vline(13, y + 7, y + 10, H("bfbfbf"))
    cv.poly([(13, y + 10), (24, y + 18), (2, y + 18)], wood)
    cv.poly([(13, y + 13), (19, y + 17), (7, y + 17)], (0, 0, 0, 0))
    cv.rect(5, y + 18, 16, 16, H("6a3fa0"))            # túnica
    cv.rect(4, y + 18, 18, 3, H("2fa04a"))             # bufanda
    cv.rect(17, y + 21, 3, 7, H("2fa04a"))
    cv.rect(8, y + 34, 3, 5, H("3a2a4a"))
    cv.rect(15, y + 34, 3, 5, H("3a2a4a"))
    if view != "up":
        cv.rect(9, y + 13, 2, 2, EYE)
        cv.rect(15, y + 13, 2, 2, EYE)
    cv.outline()
    return cv


def guagua(frame=0):
    cv = Canvas(120, 56)
    blue = H("1e5bb8")
    cv.rect(2, 8, 116, 38, blue)
    cv.rect(2, 4, 116, 4, H("2a6fd8"))
    for i in range(6):
        cv.rect(10 + i * 17, 12, 13, 12, H("bfe6ff"))
    cv.rect(104, 12, 10, 26, H("bfe6ff"))
    cv.rect(2, 30, 116, 4, H("f2f2f2"))
    text3x5(cv, 30, 36, "GLOBAL", W_)
    text3x5(cv, 70, 36, "GRATIS", H("ffd23f"))
    for x in (20, 92):
        cv.ellipse(x, 47, 7, 7, H("1a1a1a"))
        cv.ellipse(x, 47, 3, 3, H("8a8a8a"))
    if frame % 2:
        cv.rect(116, 40, 2, 3, H("ffd23f"))
    cv.outline()
    return cv


def armario(open_=False):
    cv = Canvas(44, 76)
    wood = H("8a5a2b")
    cv.rect(2, 2, 40, 72, wood)
    cv.rect(4, 4, 36, 68, shade(wood, 0.85))
    if open_:
        cv.rect(4, 4, 36, 68, H("0a0012"))
        for i in range(12):
            cv.put(8 + (i * 7) % 30, 10 + (i * 13) % 56, H("b48cd8"))
        cv.rect(-1, 2, 6, 72, wood)
    else:
        cv.vline(22, 4, 71, H("3a2a1a"))
        cv.rect(18, 36, 2, 6, H("e0c040"))
        cv.rect(24, 36, 2, 6, H("e0c040"))
    cv.outline()
    return cv


def alma(color, frame=0):
    cv = Canvas(16, 16)
    c = H(color)
    cv.rect(2, 3, 5, 5, c)
    cv.rect(9, 3, 5, 5, c)
    cv.rect(3, 2, 3, 1, c)
    cv.rect(10, 2, 3, 1, c)
    cv.tri([(2, 7), (14, 7), (8, 14)], c)
    if frame:
        cv.put(4, 4, W_)
    cv.outline()
    return cv


def blaster(frame=0):
    """Cráneo de lobo que dispara (los 'gaster blasters' de Andrés)."""
    cv = Canvas(48, 40)
    bone = H("f2f2f2")
    cv.ellipse(20, 16, 16, 14, bone)
    cv.tri([(6, 10), (10, 0), (16, 8)], bone)
    cv.tri([(24, 8), (30, 0), (34, 10)], bone)
    cv.rect(26, 18, 20, 8 if frame else 4, bone)
    cv.rect(26, 26 if frame else 22, 20, 6, bone)
    if frame:
        cv.rect(28, 22, 18, 4, H("1a1a1a"))
    cv.ellipse(14, 14, 4, 4, H("1a1a1a"))
    cv.ellipse(26, 14, 4, 4, H("1a1a1a"))
    cv.put(14, 14, H("ff2a2a"))
    cv.put(26, 14, H("ff2a2a"))
    cv.outline()
    return cv


def tijerafang(mood, f):
    """La fursona de Andrés: LORD TIJERAFANG, un lobo narcisista que absorbe almas."""
    cv = Canvas(96, 110)
    fur = H("2a2a2e")
    red = H("8a0000")
    y = 4 + f % 2
    # capa
    cv.poly([(20, y + 34), (76, y + 34), (90, y + 104), (6, y + 104)], red)
    # cuerpo / armadura
    cv.rect(30, y + 34, 36, 40, H("3a3a46"))
    cv.rect(34, y + 40, 28, 10, H("c9a227"))
    cv.rect(32, y + 74, 12, 28, fur)
    cv.rect(52, y + 74, 12, 28, fur)
    # cabeza de lobo
    cv.ellipse(48, y + 20, 16, 14, fur)
    cv.tri([(34, y + 12), (38, y - 2), (44, y + 8)], fur)
    cv.tri([(52, y + 8), (58, y - 2), (62, y + 12)], fur)
    cv.poly([(48, y + 20), (66, y + 24), (64, y + 30), (48, y + 30)], shade(fur, 1.3))
    cv.rect(40, y + 16, 4, 3, H("ff2a2a"))
    cv.rect(52, y + 16, 4, 3, H("ff2a2a"))
    if mood == "hurt":
        cv.rect(40, y + 16, 4, 3, W_)
        cv.rect(52, y + 16, 4, 3, W_)
    # brazos con tijeras
    for side in (-1, 1):
        ax = 48 + side * 26
        cv.rect(ax - 4, y + 36, 8, 24, fur)
        cv.line(ax, y + 60, ax + side * 14, y + 76, H("d9e1e8"))
        cv.line(ax, y + 60, ax + side * 4, y + 80, H("d9e1e8"))
        cv.ellipse(ax, y + 60, 3, 3, H("d12f2f"))
    # almas orbitando
    import math
    cols = ["ff2a2a", "ff9ccf", "ffd23f", "5fbf2f", "6fb8ff", "c77dff"]
    for i, c in enumerate(cols):
        a = f * 0.6 + i * math.pi / 3
        x = 48 + math.cos(a) * 42
        yy = y + 50 + math.sin(a) * 14
        cv.paste(alma(c), x - 8, yy - 8)
    cv.outline()
    return cv


def aroy_big(mood, f):
    """AROY.EXE en forma de jefe: figura enorme con lágrimas de sangre."""
    cv = Canvas(90, 120)
    y = 2 + f % 2
    black = H("0a0a0a")
    cv.poly([(30, y + 40), (60, y + 40), (86, y + 118), (4, y + 118)], black)
    cv.ellipse(45, y + 22, 18, 22, H("f1efe9"))
    # grietas tipo Gaster
    cv.line(36, y + 4, 40, y + 14, H("2a2a2a"))
    cv.line(54, y + 34, 50, y + 42, H("2a2a2a"))
    for ex in (37, 53):
        cv.rect(ex - 3, y + 16, 6, 7, black)
        cv.put(ex, y + 18, H("ffffff") if mood != "angry" else H("ff2a2a"))
        for i in range(30):
            fct = 0.5 + 0.5 * (i / 29)
            cv.put(ex - 1, y + 23 + i, (int(140 * fct + 60), 0, int(14 * fct), 255))
            cv.put(ex, y + 23 + i, (int(200 * fct + 40), int(20 * fct), int(30 * fct), 255))
            cv.put(ex + 1, y + 23 + i, (int(100 * fct + 40), 0, 0, 255))
        cv.ellipse(ex, y + 54, 2, 3, H("7a0008"))
    if mood == "angry":
        cv.rect(38, y + 32, 14, 4, black)
    else:
        cv.line(38, y + 33, 52, y + 31, black)
    # manos con agujero
    for hx in (12, 78):
        cv.ellipse(hx, y + 70, 8, 9, H("f1efe9"))
        cv.ellipse(hx, y + 70, 2.5, 2.5, black)
    text3x5(cv, 30, y + 96, "BECA MEC", H("c9a227"))
    cv.outline()
    return cv


def omega_aroy(mood, f):
    """Forma final de Aroy.exe en la ruta FURRYGRAVE (a lo Omega Flowey): una tele gigante."""
    cv = Canvas(160, 120)
    cv.rect(10, 6, 140, 96, H("2a2a2a"))
    cv.rect(16, 12, 128, 84, H("0a0a0a"))
    import random
    rnd = random.Random(f * 31 + (7 if mood == "hurt" else 0))
    for i in range(500):
        x, yy = rnd.randrange(16, 144), rnd.randrange(12, 96)
        g = rnd.randrange(30, 140)
        cv.put(x, yy, (g, g, g, 255))
    cv.ellipse(80, 50, 30, 34, H("f1efe9"))
    for ex in (68, 92):
        cv.rect(ex - 5, 38, 10, 12, H("0a0a0a"))
        cv.put(ex, 42, H("ff2a2a"))
        for i in range(44):
            cv.vline(ex - 1, 50, 50 + i, H("a0000a"))
            cv.put(ex, 50 + i, H("e0102f"))
    cv.rect(66, 70, 28, 6, H("0a0a0a"))
    for x in range(68, 94, 4):
        cv.rect(x, 70, 2, 3, H("ffffff"))
    for lx in (30, 130):
        cv.rect(lx - 3, 102, 6, 16, H("3a3a3a"))
    text3x5(cv, 52, 104, "SOY EL PUTO AMO", H("ff2a2a"))
    cv.outline()
    return cv


def flowerman(f):
    cv = Canvas(40, 64)
    y = f % 2 * 2
    cols = ["ff5fa2", "ffd23f", "ff8c00", "c77dff", "6fb8ff"]
    import math
    for i, c in enumerate(cols):
        a = i * 2 * math.pi / 5 + f * 0.3
        cv.ellipse(20 + math.cos(a) * 8, 14 + y + math.sin(a) * 8, 6, 6, H(c))
    cv.ellipse(20, 14 + y, 5, 5, H("f2d16b"))
    cv.rect(18, 22 + y, 4, 10, H("2fa04a"))
    cv.rect(12, 30 + y, 16, 18, H("2fa04a"))
    cv.line(12, 32 + y, 4, 24 + (f % 2) * 8, H("2fa04a"))
    cv.line(27, 32 + y, 35, 24 + ((f + 1) % 2) * 8, H("2fa04a"))
    cv.rect(13, 48 + y, 5, 14 - y, H("1f7a3a"))
    cv.rect(22, 48 + y, 5, 14 - y, H("1f7a3a"))
    cv.outline()
    return cv


def caballo(f):
    """El caballo de Abascal (va debajo del sprite del jefe)."""
    cv = Canvas(70, 50)
    br = H("6a4426")
    cv.ellipse(34, 22, 22, 12, br)
    cv.poly([(50, 18), (60, 2), (68, 6), (60, 22)], br)
    cv.rect(62, 2, 2, 2, EYE)
    cv.poly([(56, 4), (52, 14), (48, 10), (54, 2)], H("2a1a10"))
    for i, x in enumerate((16, 24, 42, 50)):
        dy = (2 if (i + f) % 2 else 0)
        cv.rect(x, 30, 4, 18 - dy, br)
        cv.rect(x, 46 - dy, 4, 2, H("1a1a1a"))
    cv.line(12, 18, 4, 30 + f % 2 * 2, H("2a1a10"))
    cv.rect(24, 10, 18, 4, H("5fbf2f"))  # manta verde
    cv.outline()
    return cv


def tele(f):
    """La tele de El Hormiguero (va detrás de Pablo Motos)."""
    cv = Canvas(70, 56)
    cv.rect(2, 2, 66, 46, H("2a2a2a"))
    cv.rect(6, 6, 58, 38, H("1e5bb8") if f % 2 else H("2a6fd8"))
    text3x5(cv, 10, 20, "EL HORMIGUERO", H("ffd23f"))
    cv.rect(30, 48, 10, 6, H("2a2a2a"))
    cv.outline()
    return cv


def soul_heart(color):
    return alma(color)
