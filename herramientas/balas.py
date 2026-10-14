"""Sprites originales de proyectiles (balas) para los ataques enemigos."""
from pix import Canvas, hexc as H, shade, text3x5

EYE = H("231a2e")


def c(w, h):
    return Canvas(w, h)


def B():
    b = {}
    x = c(8, 18); x.rect(2, 0, 4, 16, H("9a6232")); x.rect(2, 0, 4, 2, H("c88a52")); x.outline(); b["pata_silla"] = x
    x = c(10, 16); x.line(5, 0, 2, 10, H("d9e1e8")); x.line(5, 0, 8, 10, H("d9e1e8")); x.ellipse(2, 12, 2, 2, H("d12f2f")); x.ellipse(8, 12, 2, 2, H("d12f2f")); x.outline(); b["tijerita"] = x
    x = c(12, 12); x.ellipse(6, 7, 3.5, 3, H("f0954a"));
    for i, xx in enumerate((2, 6, 10)): x.ellipse(xx, 2.5, 1.5, 1.5, H("f0954a"))
    x.outline(); b["huella"] = x
    for nm, col in (("pastilla_e", "ff9ccf"), ("pastilla_t", "6fb8ff")):
        x = c(8, 14); x.ellipse(4, 4, 3, 3, H(col)); x.rect(1, 4, 7, 4, H(col)); x.rect(1, 8, 7, 3, H("ffffff")); x.ellipse(4, 10, 3, 3, H("ffffff")); x.outline(); b[nm] = x
    x = c(12, 11)
    cols = ["e40303", "ff8c00", "ffed00", "008026", "004dff", "750787"]
    x.rect(1, 2, 4, 4, H(cols[0])); x.rect(7, 2, 4, 4, H(cols[1])); x.tri([(1, 5), (11, 5), (6, 10)], H(cols[4])); x.rect(3, 5, 6, 2, H(cols[2])); x.outline(); b["corazon_arcoiris"] = x
    x = c(16, 9); x.rect(1, 1, 14, 7, H("b5523a")); x.hline(1, 14, 4, H("e8d8c0")); x.vline(8, 1, 4, H("e8d8c0")); x.outline(); b["ladrillo"] = x
    x = c(14, 14); x.ellipse(7, 7, 6, 6, H("ffffff")); x.ellipse(7, 7, 4.5, 4.5, H("a8322d")); x.rect(4, 5, 6, 2, H("1b1b1b")); x.outline(); b["sticker"] = x
    x = c(12, 14); x.rect(1, 1, 10, 12, H("ffffff")); x.rect(1, 1, 10, 3, H("5fbf2f")); x.outline(); b["papeleta"] = x
    x = c(14, 14); x.rect(2, 1, 10, 7, H("a3182a")); x.rect(1, 8, 12, 3, H("8a1424")); x.rect(2, 11, 2, 3, H("5a3a1a")); x.rect(10, 11, 2, 3, H("5a3a1a")); x.outline(); b["escano"] = x
    x = c(10, 14); x.rect(1, 1, 8, 12, H("e8dcc0")); x.rect(3, 4, 4, 6, H("8e3fbf")); x.outline(); b["carta"] = x
    x = c(11, 11); x.tri([(5, 0), (7, 4), (3, 4)], H("ffe066")); x.tri([(0, 4), (10, 4), (5, 7)], H("ffe066")); x.tri([(5, 6), (9, 10), (5, 8)], H("ffe066")); x.tri([(5, 6), (1, 10), (5, 8)], H("ffe066")); x.outline(); b["estrella"] = x
    x = c(10, 12); x.ellipse(3, 9, 2.5, 2, H("ffffff")); x.vline(5, 1, 9, H("ffffff")); x.hline(5, 8, 1, H("ffffff")); x.outline(); b["nota"] = x
    x = c(28, 16); x.rect(1, 3, 26, 9, H("2e6fd8")); x.rect(18, 0, 6, 4, H("2b2b2b")); x.ellipse(6, 13, 2.5, 2.5, H("1a1a1a")); x.ellipse(20, 13, 2.5, 2.5, H("1a1a1a")); x.rect(3, 5, 5, 4, H("bfe6ff")); x.ellipse(24, 7, 2, 2, H("e8e8e8")); x.outline(); b["vagon"] = x
    x = c(10, 18); x.rect(4, 6, 2, 11, H("303030")); x.ellipse(5, 4, 3.5, 3.5, H("9a9a9a")); x.outline(); b["microfono"] = x
    x = c(14, 10); x.ellipse(3, 5, 2.5, 2.5, H("e0b040")); x.ellipse(8, 5, 2.5, 2, H("d0a030")); x.ellipse(12, 5, 2, 2, H("c09020"))
    x.line(5, 7, 4, 9, EYE); x.line(9, 7, 10, 9, EYE); x.line(2, 3, 0, 0, EYE); x.outline(); b["hormiga"] = x
    x = c(14, 10); x.ellipse(7, 3, 6, 3, H("c8803a")); x.rect(1, 4, 12, 2, H("5a2a1a")); x.rect(1, 6, 12, 1, H("3fbf3f")); x.ellipse(7, 7, 6, 2, H("d8904a")); x.outline(); b["hamburguesa"] = x
    x = c(16, 8); x.rect(1, 1, 14, 6, H("8fcf8f")); x.ellipse(8, 4, 2, 2, H("4f8f4f")); x.outline(); b["billete"] = x
    x = c(22, 30); x.line(11, 0, 4, 20, H("d9e1e8")); x.line(11, 0, 18, 20, H("d9e1e8")); x.line(12, 0, 5, 20, H("aab4bd")); x.ellipse(5, 24, 4, 4, H("d12f2f")); x.ellipse(17, 24, 4, 4, H("d12f2f")); x.ellipse(5, 24, 2, 2, (0, 0, 0, 0)); x.ellipse(17, 24, 2, 2, (0, 0, 0, 0)); x.outline(); b["tijera_grande"] = x
    x = c(10, 10)
    import random
    r = random.Random(1)
    for i in range(30): x.put(r.randrange(10), r.randrange(10), H(r.choice(["ff2a2a", "2aff6a", "2a6aff", "ffffff"])))
    b["glitch"] = x
    x = c(8, 12); x.ellipse(4, 8, 3, 3, H("c0001a")); x.tri([(1, 7), (7, 7), (4, 0)], H("c0001a")); x.put(3, 7, H("ff8080")); x.outline(); b["lagrima"] = x
    x = c(12, 12); x.ellipse(6, 6, 5, 5, H("9aa4ad")); x.ellipse(6, 7, 3, 3, (0, 0, 0, 0)); x.rect(3, 8, 6, 4, (0, 0, 0, 0)); x.outline(); b["herradura"] = x
    x = c(10, 14); text3x5(x, 3, 3, "?", H("ffffff")); x2 = Canvas(10, 14); x2.paste(x.im.resize((10, 14), 0), 0, 0)
    q = c(10, 14); q.rect(2, 1, 6, 2, H("ffffff")); q.rect(6, 3, 2, 3, H("ffffff")); q.rect(4, 6, 3, 2, H("ffffff")); q.rect(4, 10, 3, 3, H("ffffff")); q.outline(); b["interrogante"] = q
    x = c(14, 16); x.rect(2, 1, 10, 7, H("9a6232")); x.rect(1, 8, 12, 2, H("9a6232")); x.rect(2, 10, 2, 5, H("6a4426")); x.rect(10, 10, 2, 5, H("6a4426")); x.outline(); b["silla_mini"] = x
    x = c(14, 16); x.rect(3, 0, 8, 6, H("c8a46e")); x.rect(4, 2, 6, 2, H("2a8a3a")); x.rect(1, 6, 12, 8, H("c8a46e")); x.outline(); b["marine_mini"] = x
    x = c(10, 9); x.rect(1, 1, 3, 3, H("ff2a2a")); x.rect(6, 1, 3, 3, H("ff2a2a")); x.tri([(1, 3), (9, 3), (5, 8)], H("ff2a2a")); x.outline(); b["corazon"] = x
    x = c(10, 9); x.rect(1, 1, 3, 3, H("ffffff")); x.rect(6, 1, 3, 3, H("ffffff")); x.tri([(1, 3), (9, 3), (5, 8)], H("ffffff")); x.outline(); b["corazon_blanco"] = x
    x = c(10, 10); x.ellipse(5, 5, 4, 4, H("f0d070")); x.ellipse(5, 5, 2, 2, H("fff0a0")); x.outline(); b["moneda"] = x
    x = c(12, 12); x.rect(5, 0, 2, 12, H("c9a227")); x.rect(1, 3, 10, 2, H("c9a227")); x.outline(); b["cruz"] = x
    x = c(16, 16); x.ellipse(8, 8, 7, 7, H("ffffff")); x.ellipse(8, 8, 5, 5, H("ff2a2a")); x.outline(); b["foco"] = x
    x = c(10, 10); x.ellipse(5, 5, 4, 4, H("3c8a3c")); x.rect(4, 0, 2, 3, H("3c8a3c")); x.outline(); b["botella"] = x
    return b
