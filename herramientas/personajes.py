"""Generador procedural de los personajes originales del mod (pixel-art propio).

Cada personaje se describe con una "ficha" (dict) y de ella salen:
  * sprites de mapa (abajo/arriba/izquierda/derecha x 4 frames) Light y Dark World
  * sprites de combate (mirando a la derecha) para el equipo
  * retratos para los diálogos con varias expresiones
En el Dark World todos tienen orejitas y cola de animal.
"""
from pix import Canvas, hexc, shade, OUTLINE

SKIN = {
    "claro": hexc("f6d3b3"), "rosado": hexc("f2c4a8"), "medio": hexc("d9a57c"),
    "moreno": hexc("b97a52"), "marron": hexc("8d5a3b"), "oliva": hexc("e0b48c"),
    "palido": hexc("f1efe9"), "naranja": hexc("f0954a"),
}
EYE = hexc("231a2e")
WHITE = hexc("ffffff")
MOUTH = hexc("7a2a3a")
BLUSH = hexc("ff8aa0", 255)


def C(v):
    if v is None:
        return None
    if isinstance(v, tuple):
        return v
    if v in SKIN:
        return SKIN[v]
    return hexc(v)


# ---------------------------------------------------------------------------
#  Geometría del cuerpo
# ---------------------------------------------------------------------------
class Body:
    """Calcula las coordenadas del cuerpo para un tamaño de lienzo."""

    def __init__(self, spec):
        self.W = 24
        tall = spec.get("height", "normal")
        self.leg = {"short": 5, "normal": 7, "tall": 10, "huge": 12}[tall]
        self.torso = {"short": 9, "normal": 10, "tall": 12, "huge": 13}[tall]
        self.head_h = 14
        self.top_pad = 6 if spec.get("tall_hat") else 4
        self.H = self.top_pad + 2 + self.head_h + 2 + self.torso + self.leg + 2 + 1
        self.y_feet = self.H - 2
        self.y_leg_top = self.y_feet - 1 - self.leg
        self.y_torso_top = self.y_leg_top - self.torso + 1
        self.y_neck = self.y_torso_top - 2
        self.y_head_bot = self.y_neck
        self.y_head_top = self.y_head_bot - self.head_h + 1
        self.cx = 12
        self.wide = spec.get("build", "normal")


# ---------------------------------------------------------------------------
#  Dibujo de piezas
# ---------------------------------------------------------------------------
def draw_tail(cv, spec, b, view, frame):
    t = spec.get("tail")
    if not t:
        return
    col = C(spec.get("tail_color") or spec.get("ear_color") or spec["hair"])
    tip = C(spec.get("tail_tip"))
    y0 = b.y_torso_top + b.torso - 3
    wag = (0, 1, 0, -1)[frame % 4]
    if view in ("down",):
        # asoma por un lado
        x = b.cx + 6
        if t in ("fox", "wolf", "jackal", "raccoon", "dragon"):
            cv.rect(x, y0 - 4 + wag, 3, 6, col)
            if tip:
                cv.rect(x, y0 - 5 + wag, 3, 2, tip)
        elif t in ("cat", "rat", "bull", "dog"):
            cv.rect(x + 1, y0 - 3 + wag, 1, 5, col)
        return
    if view == "up":
        # cola por delante de la espalda
        x = b.cx - 1
        if t in ("fox", "wolf", "jackal", "raccoon"):
            cv.ellipse(x + 1, y0 + 4, 2.2, 3, col)
            if tip:
                cv.rect(x, y0 + 6, 3, 2, tip)
            if t == "raccoon":
                cv.hline(x - 1, x + 3, y0 + 2, shade(col, 0.5))
                cv.hline(x - 1, x + 3, y0 + 4, shade(col, 0.5))
        elif t == "dragon":
            cv.poly([(x - 2, y0), (x + 4, y0), (x + 2, y0 + 9), (x, y0 + 9)], col)
        elif t in ("cat", "rat", "bull", "dog"):
            cv.vline(x + 1, y0, y0 + 7, col)
            cv.put(x + 1 + wag, y0 + 8, col)
            if t == "bull":
                cv.rect(x, y0 + 8, 3, 2, shade(col, 0.6))
        elif t in ("bear", "panda", "bunny"):
            cv.ellipse(x + 1, y0 + 2, 2, 2, tip or col)
        return
    # vistas laterales (derecha): la cola sale hacia la izquierda
    x = b.cx - 6
    if t in ("fox", "wolf", "jackal", "raccoon"):
        cv.ellipse(x - 2, y0 + 1 + wag, 4, 3, col)
        if tip:
            cv.rect(x - 6, y0 + wag, 2, 3, tip)
        if t == "raccoon":
            cv.vline(x - 3, y0 - 1 + wag, y0 + 3 + wag, shade(col, 0.5))
            cv.vline(x - 1, y0 - 1 + wag, y0 + 3 + wag, shade(col, 0.5))
    elif t == "dragon":
        cv.poly([(x + 1, y0 - 1), (x + 1, y0 + 4), (x - 8, y0 + 5 + wag)], col)
    elif t in ("cat", "rat", "bull", "dog"):
        cv.line(x, y0 + 2, x - 4, y0 - 2 + wag, col)
        if t == "bull":
            cv.rect(x - 5, y0 - 3 + wag, 2, 2, shade(col, 0.6))
    elif t in ("bear", "panda", "bunny"):
        cv.ellipse(x, y0 + 1, 1.5, 1.5, tip or col)


def draw_ears(cv, spec, b, view):
    e = spec.get("ears")
    if not e:
        return
    col = C(spec.get("ear_color") or spec["hair"])
    inner = C(spec.get("ear_inner") or "f7a1b8")
    yt = b.y_head_top
    L, R = b.cx - 6, b.cx + 3
    if view in ("left", "right"):
        L, R = b.cx - 3, None
    for x in [v for v in (L, R) if v is not None]:
        if e in ("fox", "cat", "wolf", "jackal"):
            h = 6 if e in ("fox", "jackal") else 5
            cv.tri([(x, yt + 2), (x + 4, yt + 2), (x + 1 + (1 if x == R else 0), yt + 2 - h)], col)
            if view != "up":
                cv.put(x + 2, yt, inner)
                cv.put(x + 2, yt + 1, inner)
        elif e == "dog":
            cv.rect(x - (1 if x == L else -1), yt + 1, 3, 6, col)
        elif e in ("bear", "panda", "raccoon", "rat"):
            r = 2.5 if e != "rat" else 3
            cv.ellipse(x + 1.5, yt + 1, r, r, col)
            if view != "up":
                cv.ellipse(x + 1.5, yt + 1, 1, 1, inner)
        elif e == "bunny":
            cv.rect(x + 1, yt - 7, 3, 9, col)
            if view != "up":
                cv.rect(x + 2, yt - 6, 1, 6, inner)
        elif e == "dragon":
            cv.tri([(x, yt + 2), (x + 3, yt + 2), (x + 3 if x == R else x, yt - 4)], C("e8d9a8"))
        elif e == "bull":
            if x == L:
                cv.line(x + 1, yt + 2, x - 2, yt - 2, C("efe6cf"))
                cv.line(x + 2, yt + 2, x - 1, yt - 2, C("efe6cf"))
            else:
                cv.line(x + 3, yt + 2, x + 6, yt - 2, C("efe6cf"))
                cv.line(x + 2, yt + 2, x + 5, yt - 2, C("efe6cf"))


def head_shape(cv, b, x0, w, skin):
    yt, yb = b.y_head_top, b.y_head_bot
    cv.rect(x0, yt + 1, w, yb - yt - 1, skin)
    cv.rect(x0 + 1, yt, w - 2, 1, skin)
    cv.rect(x0 + 1, yb, w - 2, 1, skin)
    # mejilla sombreada
    cv.vline(x0, yt + 8, yb - 1, shade(skin, 0.88))


def draw_hair_front(cv, spec, b, view, layer):
    """layer: 'back' (detrás de la cabeza) o 'front' (encima)."""
    style = spec.get("hair_style", "short")
    hc = C(spec["hair"])
    hd = shade(hc, 0.75)
    hl = shade(hc, 1.25)
    yt = b.y_head_top
    cx = b.cx
    if view in ("down", "up"):
        x0, x1 = cx - 7, cx + 6  # cabeza de 14
    else:
        x0, x1 = cx - 6, cx + 5  # cabeza de 12
    if layer == "back":
        if style in ("long", "bob", "ponytail_long", "witch"):
            ln = {"long": 12, "bob": 5, "ponytail_long": 10, "witch": 14}[style]
            if view == "up":
                cv.rect(x0 - 1, yt + 2, x1 - x0 + 3, b.head_h + ln - 6, hc)
                cv.vline(x0 + 3, yt + 4, yt + b.head_h + ln - 6, hd)
                cv.vline(x1 - 3, yt + 4, yt + b.head_h + ln - 6, hd)
            elif view == "down":
                cv.rect(x0 - 1, yt + 3, 3, b.head_h + ln - 6, hc)
                cv.rect(x1 - 1, yt + 3, 3, b.head_h + ln - 6, hc)
            else:
                cv.rect(x0 - 2, yt + 2, 7, b.head_h + ln - 6, hc)
        if style in ("ponytail", "ponytail_long") and view != "down":
            if view == "up":
                cv.rect(cx - 2, yt + 9, 4, 9, hc)
                cv.rect(cx - 1, yt + 8, 2, 1, C("d12f2f"))
            else:
                cv.poly([(x0 - 1, yt + 6), (x0 + 2, yt + 5), (x0 - 2, yt + 17), (x0 - 4, yt + 15)], hc)
        if style == "curly" and view != "up":
            for i in range(6):
                cv.ellipse(x0 + i * 2.6, yt + 1, 2.2, 2.2, hc)
        return

    # ---- capa frontal ----
    if view == "up":
        # la nuca: todo pelo
        if style in ("bald",):
            cv.rect(x0, yt, x1 - x0 + 1, 4, hc)
            return
        cv.rect(x0, yt - 1, x1 - x0 + 1, b.head_h - 3, hc)
        cv.rect(x0 + 1, yt - 2, x1 - x0 - 1, 1, hc)
        cv.vline(cx, yt + 1, yt + b.head_h - 5, hd)
        if style == "curly":
            for i in range(6):
                cv.ellipse(x0 + i * 2.6, yt + 1, 2.2, 2.2, hc)
                cv.ellipse(x0 + i * 2.6, yt + 6, 2.2, 2.2, hc)
        if style == "spiky":
            for i in range(4):
                cv.tri([(x0 + i * 3.5, yt), (x0 + i * 3.5 + 3, yt), (x0 + i * 3.5 + 1, yt - 4)], hc)
        if style == "bun":
            cv.ellipse(cx, yt - 3, 3, 3, hc)
        return

    if view == "down":
        if style == "bald":
            cv.rect(x0 + 1, yt, x1 - x0 - 1, 2, hc)
            return
        if style == "buzz":
            cv.rect(x0, yt, x1 - x0 + 1, 3, hc)
            cv.rect(x0 + 1, yt - 1, x1 - x0 - 1, 1, hc)
            return
        # casquete
        cv.rect(x0, yt - 1, x1 - x0 + 1, 5, hc)
        cv.rect(x0 + 1, yt - 2, x1 - x0 - 1, 1, hc)
        cv.hline(x0 + 2, x1 - 3, yt - 1, hl)
        # laterales
        side = {"short": 4, "messy": 5, "long": 9, "bob": 9, "slick": 2, "curly": 6,
                "ponytail": 5, "ponytail_long": 7, "spiky": 4, "bun": 4, "witch": 9, "side": 5}.get(style, 4)
        cv.rect(x0, yt + 3, 2, side, hc)
        cv.rect(x1 - 1, yt + 3, 2, side, hc)
        # flequillo
        if style in ("short", "messy", "ponytail", "ponytail_long", "bun", "long", "bob", "witch"):
            for i in range(x0 + 2, x1 - 1, 3):
                cv.rect(i, yt + 4, 2, 2 if style != "messy" else 3, hc)
        if style == "side":
            cv.poly([(x0, yt + 3), (x1, yt + 3), (x0 + 3, yt + 7)], hc)
        if style == "messy":
            for i in range(x0, x1, 3):
                cv.put(i + 1, yt - 3, hc)
        if style == "spiky":
            for i in range(4):
                cv.tri([(x0 + i * 3.5, yt), (x0 + i * 3.5 + 3, yt), (x0 + i * 3.5 + 1, yt - 4)], hc)
        if style == "curly":
            for i in range(6):
                cv.ellipse(x0 + i * 2.6, yt + 0.5, 2.2, 2.2, hc)
            cv.ellipse(x0, yt + 5, 2, 3, hc)
            cv.ellipse(x1, yt + 5, 2, 3, hc)
        if style == "bun":
            cv.ellipse(cx, yt - 3, 3, 3, hc)
        if style == "slick":
            cv.hline(x0 + 2, x1 - 2, yt + 1, hl)
        return

    # vista lateral derecha
    if style == "bald":
        cv.rect(x0 + 1, yt, x1 - x0 - 2, 2, hc)
        return
    if style == "buzz":
        cv.rect(x0, yt, x1 - x0, 3, hc)
        cv.rect(x0, yt + 3, 3, 3, hc)
        return
    cv.rect(x0, yt - 1, x1 - x0 + 1, 5, hc)
    cv.rect(x0 + 1, yt - 2, x1 - x0 - 1, 1, hc)
    cv.rect(x0, yt + 3, 5, 6 if style not in ("long", "bob", "witch") else 10, hc)
    if style in ("short", "messy", "ponytail", "ponytail_long", "bun", "long", "bob", "side", "witch"):
        cv.rect(x1 - 2, yt + 3, 3, 3, hc)
    if style == "spiky":
        for i in range(3):
            cv.tri([(x0 + i * 4, yt), (x0 + i * 4 + 3, yt), (x0 + i * 4 + 4, yt - 4)], hc)
    if style == "curly":
        for i in range(5):
            cv.ellipse(x0 + i * 2.6, yt + 0.5, 2.2, 2.2, hc)
        cv.ellipse(x0, yt + 5, 2.5, 3, hc)
    if style == "messy":
        for i in range(x0, x1, 3):
            cv.put(i + 1, yt - 3, hc)
    if style == "bun":
        cv.ellipse(x0 + 2, yt - 2, 3, 3, hc)
    cv.hline(x0 + 2, x1 - 2, yt - 1, hl)


def draw_hat(cv, spec, b, view):
    hat = spec.get("hat")
    if not hat:
        return
    yt = b.y_head_top
    cx = b.cx
    col = C(spec.get("hat_color", "222222"))
    if hat == "cap":
        cv.rect(cx - 7, yt - 3, 14, 5, col)
        cv.hline(cx - 5, cx + 4, yt - 3, shade(col, 1.2))
        if view == "down":
            cv.rect(cx - 6, yt + 2, 12, 1, shade(col, 0.6))
            cv.rect(cx - 2, yt - 2, 3, 3, C("ffffff"))  # logo
        elif view == "right":
            cv.rect(cx + 4, yt + 1, 5, 2, shade(col, 0.7))
        elif view == "up":
            cv.rect(cx - 2, yt + 1, 4, 1, shade(col, 0.6))
    elif hat == "witch":
        cv.rect(cx - 9, yt + 1, 18, 2, col)
        cv.poly([(cx - 6, yt + 1), (cx + 5, yt + 1), (cx + 3, yt - 7), (cx - 3, yt - 7)], col)
        cv.tri([(cx - 3, yt - 7), (cx + 3, yt - 7), (cx + 6, yt - 11)], col)
        cv.rect(cx - 6, yt - 1, 12, 2, C("8e3fbf"))
    elif hat == "bowler":
        cv.rect(cx - 8, yt + 1, 16, 2, col)
        cv.ellipse(cx, yt - 1, 6, 4, col)
    elif hat == "zucchetto":
        cv.ellipse(cx, yt, 5, 2, C("ffffff"))
    elif hat == "headset":
        cv.rect(cx - 8, yt + 6, 2, 5, col)
        cv.rect(cx + 6, yt + 6, 2, 5, col)
        cv.hline(cx - 7, cx + 6, yt - 2, col)
        if view == "down":
            cv.line(cx + 7, yt + 10, cx + 3, yt + 13, col)
    elif hat == "chimney":
        cv.rect(cx - 2, yt - 6, 5, 6, C("2b2b2b"))
        cv.rect(cx - 3, yt - 7, 7, 2, C("c9a227"))
    elif hat == "cowboy":
        cv.rect(cx - 9, yt + 1, 18, 2, col)
        cv.rect(cx - 5, yt - 4, 10, 6, col)
    elif hat == "crown":
        for i in range(4):
            cv.tri([(cx - 6 + i * 3, yt), (cx - 3 + i * 3, yt), (cx - 4.5 + i * 3, yt - 4)], C("f5cd30"))
        cv.rect(cx - 6, yt - 1, 12, 2, C("f5cd30"))
    elif hat == "beret":
        cv.ellipse(cx, yt - 1, 7, 3, col)
    elif hat == "helmet":
        cv.rect(cx - 8, yt - 3, 16, 8, col)
        cv.rect(cx - 8, yt - 4, 16, 1, shade(col, 1.3))
        if view == "down":
            cv.rect(cx - 5, yt + 6, 10, 2, C("c0392b"))


def draw_face_small(cv, spec, b, view, mood="normal"):
    skin = C(spec["skin"])
    yt = b.y_head_top
    cx = b.cx
    ey = yt + 7
    eye_c = C(spec.get("eye_color", "231a2e"))
    if view == "down":
        ex = [cx - 4, cx + 2]
        for x in ex:
            if mood == "closed":
                cv.hline(x, x + 1, ey + 1, eye_c)
            else:
                cv.rect(x, ey, 2, 2, eye_c)
        if spec.get("blood_tears"):
            for x in ex:
                cv.vline(x, ey + 2, ey + 9, C("b0001a"))
                cv.vline(x + 1, ey + 2, ey + 6, C("e0102f"))
        g = spec.get("glasses")
        if g:
            gc = C(spec.get("glasses_color", "1b1b1b"))
            if g == "sun":
                cv.rect(cx - 6, ey - 1, 12, 3, gc)
            else:
                for x in ex:
                    cv.rect(x - 1, ey - 1, 4, 4, None)
                    cv.hline(x - 1, x + 2, ey - 1, gc)
                    cv.hline(x - 1, x + 2, ey + 2, gc)
                    cv.vline(x - 1, ey - 1, ey + 2, gc)
                    cv.vline(x + 2, ey - 1, ey + 2, gc)
                cv.hline(cx - 1, cx + 1, ey, gc)
        if spec.get("beard"):
            bc = C(spec.get("beard_color") or spec["hair"])
            if spec["beard"] == "full":
                cv.rect(cx - 6, ey + 4, 12, 4, bc)
                cv.rect(cx - 4, ey + 8, 8, 1, bc)
                cv.hline(cx - 2, cx + 1, ey + 5, skin)
            elif spec["beard"] == "stubble":
                for x in range(cx - 5, cx + 5, 2):
                    cv.put(x, ey + 7, shade(skin, 0.7))
                    cv.put(x + 1, ey + 8, shade(skin, 0.7))
            elif spec["beard"] == "mustache":
                cv.rect(cx - 3, ey + 4, 6, 1, bc)
        if spec.get("acne"):
            cv.put(cx - 5, ey + 4, C("d0645c"))
            cv.put(cx + 4, ey + 3, C("d0645c"))
        if spec.get("blush"):
            cv.put(cx - 5, ey + 3, BLUSH)
            cv.put(cx + 4, ey + 3, BLUSH)
    elif view == "right":
        x = cx + 3
        if mood == "closed":
            cv.hline(x, x + 1, ey + 1, eye_c)
        else:
            cv.rect(x, ey, 2, 2, eye_c)
        if spec.get("blood_tears"):
            cv.vline(x, ey + 2, ey + 9, C("b0001a"))
        g = spec.get("glasses")
        if g:
            gc = C(spec.get("glasses_color", "1b1b1b"))
            if g == "sun":
                cv.rect(x - 1, ey - 1, 5, 3, gc)
            else:
                cv.hline(x - 1, x + 2, ey - 1, gc)
                cv.hline(x - 1, x + 2, ey + 2, gc)
                cv.vline(x + 2, ey - 1, ey + 2, gc)
                cv.hline(x - 4, x - 1, ey, gc)
        if spec.get("beard"):
            bc = C(spec.get("beard_color") or spec["hair"])
            if spec["beard"] == "full":
                cv.rect(cx - 1, ey + 4, 7, 4, bc)
            elif spec["beard"] == "mustache":
                cv.rect(cx + 3, ey + 4, 3, 1, bc)
        cv.put(cx + 6, ey + 3, shade(skin, 0.85))  # nariz


def limb_color(spec, part):
    o = spec.get("outfit", {})
    if part == "arm":
        return C(o.get("sleeve") or o.get("top") or "777777")
    if part == "leg":
        return C(o.get("legs") or o.get("bottom") or "333355")
    return C(o.get(part) or "777777")


def draw_body(cv, spec, b, view, pose):
    """Torso, brazos y piernas."""
    o = spec.get("outfit", {})
    top = C(o.get("top", "777777"))
    top_d = shade(top, 0.8)
    bottom = C(o.get("bottom", "333355"))
    legs_c = C(o.get("legs") or o.get("bottom", "333355"))
    shoes = C(o.get("shoes", "3a2a2a"))
    skin = C(spec["skin"])
    sleeve = C(o.get("sleeve") or o.get("top", "777777"))
    cx = b.cx
    bob = pose.get("bob", 0)
    tt = b.y_torso_top + bob
    lt = b.y_leg_top
    lf = b.y_feet
    skirt = o.get("skirt")
    robe = o.get("robe")
    wide = 1 if b.wide == "wide" else 0
    lstep = pose.get("legs", "stand")

    def leg(x, lift, color, w=3, dx=0):
        y0 = lt + (1 if skirt else 0)
        y1 = lf - 2 - lift
        cv.rect(x + dx, y0, w, y1 - y0 + 1, color)
        cv.rect(x + dx, y1 + 1, w + (1 if view == "right" else 0), 2, shoes)

    if view in ("down", "up"):
        # piernas
        if not robe:
            ll = 1 if lstep == "walkA" else 0
            rl = 1 if lstep == "walkB" else 0
            leg(cx - 4, ll, legs_c)
            leg(cx + 1, rl, legs_c)
            if o.get("socks"):
                sc = C(o["socks"])
                sc2 = C(o.get("socks2", "ffffff"))
                for xx, lift in ((cx - 4, ll), (cx + 1, rl)):
                    for yy in range(lt + 3, lf - 2 - lift + 1):
                        cv.hline(xx, xx + 2, yy, sc if (yy // 2) % 2 == 0 else sc2)
        # torso
        tw = 10 + wide * 2
        tx = cx - tw // 2
        if robe:
            cv.rect(tx - 1, tt, tw + 2, lf - tt - 1, top)
            cv.rect(cx - 3, lf - 1, 2, 1, shoes)
            cv.rect(cx + 1, lf - 1, 2, 1, shoes)
        else:
            cv.rect(tx, tt, tw, b.torso, top)
            cv.vline(tx + tw - 1, tt + 1, tt + b.torso - 1, top_d)
            # cintura/pantalón
            cv.rect(tx, tt + b.torso - 2, tw, 2, bottom)
        if skirt:
            cv.poly([(tx, tt + b.torso - 2), (tx + tw, tt + b.torso - 2), (tx + tw + 2, lt + 4), (tx - 2, lt + 4)], C(skirt))
        if o.get("cape") and view == "up":
            cv.rect(tx - 2, tt, tw + 4, b.torso + b.leg - 2, C(o["cape"]))
        # detalles del frente
        if view == "down":
            if o.get("jacket"):
                jc = C(o["jacket"])
                cv.rect(tx, tt, 3, b.torso - 1, jc)
                cv.rect(tx + tw - 3, tt, 3, b.torso - 1, jc)
            if o.get("vest"):
                vc = C(o["vest"])
                cv.rect(tx, tt, 3, b.torso - 2, vc)
                cv.rect(tx + tw - 3, tt, 3, b.torso - 2, vc)
            if o.get("tie"):
                cv.rect(cx - 1, tt, 2, 6, C(o["tie"]))
                cv.put(cx - 1, tt + 6, C(o["tie"]))
            if o.get("logo"):
                lc = C(o.get("logo_color", "ffffff"))
                if o["logo"] == "star":
                    cv.tri([(cx - 2, tt + 5), (cx + 2, tt + 5), (cx, tt + 2)], lc)
                    cv.tri([(cx - 2, tt + 3), (cx + 2, tt + 3), (cx, tt + 6)], lc)
                elif o["logo"] == "1":
                    cv.vline(cx, tt + 2, tt + 6, lc)
                    cv.put(cx - 1, tt + 3, lc)
                elif o["logo"] == "heart":
                    cv.rect(cx - 2, tt + 3, 2, 2, lc)
                    cv.rect(cx + 1, tt + 3, 2, 2, lc)
                    cv.rect(cx - 1, tt + 4, 3, 2, lc)
                    cv.put(cx, tt + 6, lc)
                elif o["logo"] == "stripe":
                    cv.rect(tx, tt + 4, tw, 2, lc)
                elif o["logo"] == "chain":
                    for i in range(-3, 4):
                        cv.put(cx + i, tt + 2 + abs(i) // 2, lc)
                elif o["logo"] == "cross":
                    cv.vline(cx, tt + 2, tt + 7, lc)
                    cv.hline(cx - 2, cx + 2, tt + 4, lc)
            if o.get("hood"):
                cv.put(cx - 2, tt + 1, C("ffffff"))
                cv.put(cx + 1, tt + 1, C("ffffff"))
                cv.vline(cx - 2, tt + 2, tt + 4, C("ffffff"))
                cv.vline(cx + 1, tt + 2, tt + 4, C("ffffff"))
        # brazos
        arm_y = tt + 1
        al = pose.get("armL", 0)
        ar = pose.get("armR", 0)
        alen = b.torso - 2
        cv.rect(tx - 2, arm_y + al, 2, alen - 2, sleeve)
        cv.rect(tx - 2, arm_y + al + alen - 2, 2, 2, skin)
        cv.rect(tx + tw, arm_y + ar, 2, alen - 2, shade(sleeve, 0.85))
        cv.rect(tx + tw, arm_y + ar + alen - 2, 2, 2, skin)
        if o.get("cape") and view == "down":
            cv.rect(tx - 3, tt, 1, b.torso + 3, C(o["cape"]))
            cv.rect(tx + tw + 2, tt, 1, b.torso + 3, C(o["cape"]))
        # objeto en la mano
        item = spec.get("item")
        if item and view == "down" and pose.get("show_item", True):
            draw_item_small(cv, item, tx + tw + 1, arm_y + ar + alen - 1)
        # cuello
        cv.rect(cx - 2, b.y_neck + bob, 4, 2, skin)
        return

    # ---- lateral (derecha) ----
    tw = 8 + wide * 2
    tx = cx - tw // 2
    if not robe:
        if lstep == "stand":
            leg(cx - 2, 0, shade(legs_c, 0.8))
            leg(cx - 1, 0, legs_c)
        elif lstep == "walkA":
            leg(cx - 4, 0, shade(legs_c, 0.8))
            leg(cx + 1, 1, legs_c)
        elif lstep == "walkB":
            leg(cx + 1, 0, shade(legs_c, 0.8))
            leg(cx - 4, 1, legs_c)
        elif lstep == "wide":
            leg(cx - 5, 0, shade(legs_c, 0.8))
            leg(cx + 2, 0, legs_c)
        elif lstep == "crouch":
            leg(cx - 4, 2, shade(legs_c, 0.8))
            leg(cx + 1, 2, legs_c)
        if o.get("socks"):
            sc = C(o["socks"])
            sc2 = C(o.get("socks2", "ffffff"))
            for yy in range(lt + 3, lf - 2):
                for xx in range(cx - 5, cx + 5):
                    p = cv.get(xx, yy)
                    if p[3] and p[:3] in (legs_c[:3], shade(legs_c, 0.8)[:3]):
                        cv.put(xx, yy, sc if (yy // 2) % 2 == 0 else sc2)
    if o.get("cape"):
        cv.poly([(tx - 1, tt), (tx + 3, tt), (tx - 1, tt + b.torso + b.leg - 3), (tx - 5, tt + b.torso + b.leg - 3)], C(o["cape"]))
    if robe:
        cv.rect(tx - 1, tt, tw + 2, lf - tt - 1, top)
        cv.rect(cx, lf - 1, 4, 1, shoes)
    else:
        cv.rect(tx, tt, tw, b.torso, top)
        cv.rect(tx, tt + b.torso - 2, tw, 2, bottom)
    if skirt:
        cv.poly([(tx, tt + b.torso - 2), (tx + tw, tt + b.torso - 2), (tx + tw + 2, lt + 4), (tx - 2, lt + 4)], C(skirt))
    if o.get("vest"):
        cv.rect(tx + tw - 3, tt, 3, b.torso - 2, C(o["vest"]))
    if o.get("jacket"):
        cv.rect(tx, tt, tw - 2, b.torso - 1, C(o["jacket"]))
    if o.get("tie"):
        cv.rect(tx + tw - 1, tt, 1, 5, C(o["tie"]))
    if o.get("hood"):
        cv.rect(tx, tt - 1, 3, 3, shade(top, 0.85))
    cv.rect(cx - 1, b.y_neck + bob, 3, 2, skin)
    # brazo (frontal)
    arm = pose.get("arm", "down")
    ay = tt + 1
    alen = b.torso - 2
    hand = None
    if arm == "down":
        cv.rect(cx - 1, ay, 3, alen - 2, sleeve)
        hand = (cx - 1, ay + alen - 2)
        cv.rect(cx - 1, ay + alen - 2, 3, 2, skin)
    elif arm == "swingF":
        cv.poly([(cx - 1, ay), (cx + 2, ay), (cx + 5, ay + alen - 2), (cx + 2, ay + alen - 1)], sleeve)
        cv.rect(cx + 3, ay + alen - 2, 3, 2, skin)
        hand = (cx + 3, ay + alen - 2)
    elif arm == "swingB":
        cv.poly([(cx - 1, ay), (cx + 2, ay), (cx - 2, ay + alen - 1), (cx - 5, ay + alen - 2)], sleeve)
        cv.rect(cx - 5, ay + alen - 2, 3, 2, skin)
        hand = (cx - 5, ay + alen - 2)
    elif arm == "forward":
        cv.rect(cx - 1, ay, 9, 3, sleeve)
        cv.rect(cx + 8, ay, 2, 3, skin)
        hand = (cx + 8, ay)
    elif arm == "up":
        cv.rect(cx, ay - alen + 1, 3, alen, sleeve)
        cv.rect(cx, ay - alen - 1, 3, 2, skin)
        hand = (cx, ay - alen - 1)
    elif arm == "upfwd":
        cv.poly([(cx - 1, ay + 1), (cx + 2, ay), (cx + 8, ay - 7), (cx + 6, ay - 9)], sleeve)
        cv.rect(cx + 7, ay - 10, 2, 2, skin)
        hand = (cx + 7, ay - 10)
    elif arm == "back":
        cv.rect(cx - 7, ay, 8, 3, sleeve)
        cv.rect(cx - 9, ay, 2, 3, skin)
        hand = (cx - 9, ay)
    elif arm == "mouth":
        cv.poly([(cx - 1, ay), (cx + 2, ay), (cx + 5, ay - 2), (cx + 4, ay - 4)], sleeve)
        cv.rect(cx + 4, ay - 5, 2, 2, skin)
        hand = (cx + 4, ay - 5)
    elif arm == "guard":
        cv.rect(cx, ay, 6, 3, sleeve)
        cv.rect(cx + 5, ay - 3, 2, 4, skin)
        hand = (cx + 5, ay - 3)
    return hand


def draw_item_small(cv, item, x, y, angle="hold"):
    """Objetos pequeños en la mano (vistas de mapa)."""
    if item == "phone":
        cv.rect(x, y - 2, 2, 3, C("202020"))
        cv.put(x, y - 2, C("5ad1ff"))
    elif item == "scissors":
        cv.line(x, y, x + 2, y - 4, C("cfd6dd"))
        cv.line(x + 2, y, x, y - 4, C("cfd6dd"))
        cv.put(x, y + 1, C("d12f2f"))
        cv.put(x + 2, y + 1, C("d12f2f"))
    elif item == "can":
        cv.rect(x, y - 2, 2, 3, C("e0c040"))
    elif item == "train":
        cv.rect(x - 1, y - 1, 4, 3, C("2e6fd8"))
        cv.put(x, y - 2, C("202020"))
    elif item == "mic":
        cv.rect(x, y - 3, 1, 4, C("303030"))
        cv.rect(x - 1, y - 5, 3, 2, C("909090"))
    elif item == "cards":
        cv.rect(x, y - 2, 3, 3, C("e8dcc0"))
        cv.put(x + 1, y - 1, C("8e3fbf"))
    elif item == "chairleg":
        cv.rect(x, y - 5, 2, 7, C("8a5a2b"))
    elif item == "briefcase":
        cv.rect(x - 1, y, 4, 3, C("5a3a1a"))
    elif item == "bottle":
        cv.rect(x, y - 3, 2, 4, C("3c8a3c"))
    elif item == "plush":
        cv.ellipse(x + 1, y - 1, 2, 2, C("f0954a"))


def build_overworld(spec, view, frame, dark):
    """Devuelve un Canvas con el sprite de mapa."""
    s = dict(spec)
    if dark:
        s.update(spec.get("dark", {}))
        if "outfit_dark" in spec:
            s["outfit"] = spec["outfit_dark"]
    else:
        for k in ("ears", "tail"):
            if not spec.get("lw_" + k):
                s.pop(k, None)
    b = Body(s)
    cv = Canvas(b.W, b.H)
    legs = ["stand", "walkA", "stand", "walkB"][frame % 4]
    bob = 1 if frame % 2 == 1 else 0
    if view in ("down", "up"):
        pose = {"legs": legs, "bob": 0,
                "armL": (1 if legs == "walkB" else 0) if view == "down" else 0,
                "armR": (1 if legs == "walkA" else 0) if view == "down" else 0}
    else:
        pose = {"legs": legs, "bob": 0,
                "arm": {"stand": "down", "walkA": "swingB", "walkB": "swingF"}[legs]}
    vview = "right" if view == "left" else view
    # capas traseras
    if vview != "up":
        draw_tail(cv, s, b, vview, frame)
    draw_hair_front(cv, s, b, vview, "back")
    hand = draw_body(cv, s, b, vview, pose)
    if vview == "up":
        draw_tail(cv, s, b, vview, frame)
    # cabeza
    skin = C(s["skin"])
    if vview in ("down", "up"):
        head_shape(cv, b, b.cx - 7, 14, skin)
    else:
        head_shape(cv, b, b.cx - 6, 12, skin)
    if vview != "up":
        draw_face_small(cv, s, b, vview)
    draw_hair_front(cv, s, b, vview, "front")
    draw_ears(cv, s, b, vview)
    draw_hat(cv, s, b, vview)
    if vview == "right" and s.get("item") and hand:
        draw_item_small(cv, s["item"], hand[0] + 2, hand[1] + 1)
    if s.get("aura") and frame % 2 == 0:
        cv.put(2, b.y_torso_top, C("ffe066"))
        cv.put(b.W - 3, b.y_torso_top + 6, C("ffe066"))
    cv.outline()
    if bob:
        # rebote al andar: desplaza todo 1px hacia abajo excepto los pies
        nc = Canvas(cv.w, cv.h)
        nc.paste(cv.im.crop((0, 0, cv.w, b.y_leg_top + 1)), 0, 1)
        nc.paste(cv.im.crop((0, b.y_leg_top + 1, cv.w, cv.h)), 0, b.y_leg_top + 1)
        cv = nc
    if view == "left":
        cv = cv.flip()
    return cv, b


# ---------------------------------------------------------------------------
#  Combate (mirando a la derecha)
# ---------------------------------------------------------------------------
BATTLE_PAD_L, BATTLE_PAD_T, BATTLE_W_EXTRA, BATTLE_H_EXTRA = 18, 12, 40, 14


def draw_weapon(cv, kind, hand, phase, col=None):
    """Armas/objetos grandes de combate. phase 0..3 para animar golpes."""
    if not hand or not kind:
        return
    hx, hy = hand
    if kind == "paw":  # zarpa de peluche gigante (Lucía)
        c = C("f0954a")
        cv.ellipse(hx + 4, hy - 1, 4, 4, c)
        for i in range(3):
            cv.ellipse(hx + 2 + i * 3, hy - 5, 1.3, 1.3, C("ffd9c0"))
        cv.ellipse(hx + 5, hy, 2, 1.6, C("ffd9c0"))
    elif kind == "fist":  # puño de Terry con energía
        cv.rect(hx + 1, hy - 1, 4, 4, C("f2c4a8"))
        cv.rect(hx + 1, hy - 1, 4, 1, C("d12f2f"))
        if phase >= 2:
            for i in range(3):
                cv.line(hx + 6 + i * 2, hy - 3 + i * 2, hx + 9 + i * 2, hy - 3 + i * 2, C("ffd23f"))
    elif kind == "axe":  # hacha morada fan de Susie (Gabriel)
        cv.line(hx + 1, hy + 3, hx + 1 + (6 if phase else 0), hy - 9, C("6b4a2b"))
        ax = hx + 1 + (6 if phase else 0)
        cv.poly([(ax - 1, hy - 10), (ax + 6, hy - 13), (ax + 7, hy - 5), (ax, hy - 7)], C("b57edc"))
        cv.line(ax + 6, hy - 13, ax + 7, hy - 5, C("ffffff"))
    elif kind == "bottle":
        cv.rect(hx + 1, hy - 5, 3, 7, C("3c8a3c"))
        cv.rect(hx + 2, hy - 7, 1, 2, C("3c8a3c"))
        cv.rect(hx + 1, hy - 3, 3, 2, C("f3e3a0"))
    elif kind == "fan":  # abanico (Ángel)
        cols = ["e40303", "ff8c00", "ffed00", "008026", "004dff", "750787"]
        for i, cc in enumerate(cols):
            cv.line(hx + 1, hy, hx + 1 + (i - 2) * 2, hy - 8, C(cc))
    elif kind == "keyboard":  # teclado (Alejandro)
        cv.rect(hx, hy - 2, 10, 4, C("2a2a2a"))
        for i in range(4):
            cv.put(hx + 1 + i * 2, hy - 1, C("bbbbbb"))
    elif kind == "wand":  # varita (Carmen)
        cv.line(hx + 1, hy + 2, hx + 6, hy - 7, C("4a2a1a"))
        cv.ellipse(hx + 6, hy - 8, 1.5, 1.5, C("ffe066"))
    elif kind == "ukulele":  # David
        cv.ellipse(hx + 2, hy + 1, 3, 2.5, C("c27c3e"))
        cv.line(hx + 3, hy - 1, hx + 9, hy - 6, C("5a3a1a"))
    elif kind == "whistle":  # silbato de tren (Julio)
        cv.rect(hx + 1, hy - 1, 5, 3, C("c9a227"))
        if phase >= 1:
            cv.ellipse(hx + 9, hy - 4, 2.5, 2, C("dddddd"))
    elif kind == "briefcase":  # maletín (Xibin)
        cv.rect(hx, hy, 7, 5, C("5a3a1a"))
        cv.rect(hx + 2, hy - 1, 3, 1, C("c9a227"))
    elif kind == "scissors":
        L = 9 if phase else 6
        cv.line(hx + 1, hy, hx + 1 + L, hy - 3, C("d9e1e8"))
        cv.line(hx + 1, hy, hx + 1 + L, hy + 2, C("d9e1e8"))
        cv.ellipse(hx, hy - 1, 1.5, 1.5, C("d12f2f"))
        cv.ellipse(hx, hy + 2, 1.5, 1.5, C("d12f2f"))
    elif kind == "chair":
        cv.rect(hx - 2, hy - 8, 8, 2, C("8a5a2b"))
        cv.rect(hx - 2, hy - 6, 2, 8, C("8a5a2b"))
        cv.rect(hx + 4, hy - 6, 2, 8, C("8a5a2b"))
        cv.rect(hx - 2, hy - 14, 2, 6, C("8a5a2b"))
    elif kind == "mic":
        cv.rect(hx + 1, hy - 2, 2, 6, C("303030"))
        cv.ellipse(hx + 2, hy - 4, 2.5, 2.5, C("9a9a9a"))
    elif kind == "phone":
        cv.rect(hx + 1, hy - 4, 3, 5, C("202020"))
        cv.rect(hx + 2, hy - 3, 1, 3, C("5ad1ff"))
    elif kind == "cards":
        for i in range(3):
            cv.rect(hx + i * 2, hy - 4 + i, 3, 5, C("e8dcc0"))
            cv.put(hx + 1 + i * 2, hy - 2 + i, C("8e3fbf"))
    elif kind == "sticker":
        cv.ellipse(hx + 3, hy - 2, 3.5, 3.5, C("ffffff"))
        cv.ellipse(hx + 3, hy - 2, 2.5, 2.5, C("d12f2f"))


BATTLE_ANIMS = {
    # nombre: lista de poses (frames)
    "idle": [dict(legs="stand", arm="down", bob=0), dict(legs="stand", arm="down", bob=0, breathe=1),
             dict(legs="stand", arm="down", bob=0, breathe=1), dict(legs="stand", arm="down", bob=0)],
    "attack": [dict(legs="wide", arm="back", w=0), dict(legs="wide", arm="up", w=1),
               dict(legs="wide", arm="upfwd", w=2), dict(legs="wide", arm="forward", w=3),
               dict(legs="wide", arm="forward", w=3), dict(legs="stand", arm="swingF", w=0)],
    "attackready": [dict(legs="wide", arm="back", w=0)],
    "act": [dict(legs="stand", arm="swingF"), dict(legs="stand", arm="forward"),
            dict(legs="stand", arm="up"), dict(legs="stand", arm="up")],
    "actready": [dict(legs="stand", arm="guard")],
    "actend": [dict(legs="stand", arm="swingF"), dict(legs="stand", arm="down")],
    "spell": [dict(legs="wide", arm="up", sparkle=1), dict(legs="wide", arm="up", sparkle=2),
              dict(legs="wide", arm="upfwd", sparkle=3), dict(legs="wide", arm="forward", sparkle=3)],
    "spellready": [dict(legs="wide", arm="up", sparkle=1)],
    "item": [dict(legs="stand", arm="forward", show_item=1), dict(legs="stand", arm="mouth", show_item=1),
             dict(legs="stand", arm="mouth", show_item=1)],
    "itemready": [dict(legs="stand", arm="forward", show_item=1)],
    "defend": [dict(legs="crouch", arm="guard", crouch=1), dict(legs="crouch", arm="guard", crouch=2)],
    "hurt": [dict(legs="wide", arm="back", hurt=1)],
    "defeat": [dict(defeat=1)],
    "victory": [dict(legs="stand", arm="up"), dict(legs="stand", arm="up", bob=-1)],
}


def build_battle(spec, anim, frame, dark=True):
    s = dict(spec)
    if dark:
        s.update(spec.get("dark", {}))
        if "outfit_dark" in spec:
            s["outfit"] = spec["outfit_dark"]
    b = Body(s)
    W, H = b.W + BATTLE_W_EXTRA, b.H + BATTLE_H_EXTRA
    body = Canvas(b.W + 20, b.H)  # margen para brazos
    pose = BATTLE_ANIMS[anim][frame]
    if pose.get("defeat"):
        # tumbado en el suelo
        st, _ = build_overworld(s, "right", 0, dark)
        rot = st.im.rotate(90, expand=True)
        cv = Canvas(W, H)
        cv.paste(rot, BATTLE_PAD_L - 6, BATTLE_PAD_T + b.H - rot.height)
        return cv, b
    # cuerpo lateral: dibujamos con el centro desplazado para dejar espacio
    inner = Canvas(b.W, b.H)
    ib = b
    if s.get("tail"):
        draw_tail(inner, s, ib, "right", frame)
    draw_hair_front(inner, s, ib, "right", "back")
    hand = draw_body(inner, s, ib, "right", {"legs": pose.get("legs", "stand"), "arm": pose.get("arm", "down"),
                                              "bob": pose.get("bob", 0)})
    skin = C(s["skin"])
    head_shape(inner, ib, ib.cx - 6, 12, skin)
    draw_face_small(inner, s, ib, "right", "closed" if pose.get("hurt") else "normal")
    draw_hair_front(inner, s, ib, "right", "front")
    draw_ears(inner, s, ib, "right")
    draw_hat(inner, s, ib, "right")
    cv = Canvas(W, H)
    ox, oy = BATTLE_PAD_L, BATTLE_PAD_T
    weapon = s.get("weapon")
    show = pose.get("show_item") or anim in ("attack", "attackready", "idle")
    wcv = Canvas(W, H)
    if weapon and hand and anim in ("attack", "attackready", "idle", "victory"):
        draw_weapon(wcv, weapon, (hand[0] + ox, hand[1] + oy), pose.get("w", 0))
    if pose.get("show_item") and hand:
        draw_weapon(wcv, s.get("battle_item", "bottle"), (hand[0] + ox, hand[1] + oy), 0)
    cv.paste(inner, ox, oy + (2 if pose.get("crouch") else 0) + (1 if pose.get("breathe") else 0) * 0)
    if pose.get("breathe"):
        # respiración: la parte de arriba baja 1px
        top = cv.im.crop((0, 0, W, oy + b.y_torso_top + 3))
        cv2 = Canvas(W, H)
        cv2.paste(cv.im.crop((0, oy + b.y_torso_top + 3, W, H)), 0, oy + b.y_torso_top + 3)
        cv2.paste(top, 0, 1)
        cv = cv2
    cv.paste(wcv, 0, 0)
    if pose.get("hurt"):
        cv.im = cv.im.rotate(-8, center=(ox + 12, oy + b.H), resample=0)
        cv.px = cv.im.load()
    cv.outline()
    sp = pose.get("sparkle")
    if sp:
        mc = C(s.get("magic_color", "ffe066"))
        for i in range(sp + 1):
            x = ox + 16 + i * 5
            y = oy + 4 - (i * 3) % 7
            cv.put(x, y, mc)
            cv.put(x - 1, y, shade(mc, 0.8))
            cv.put(x + 1, y, shade(mc, 0.8))
            cv.put(x, y - 1, shade(mc, 0.8))
            cv.put(x, y + 1, shade(mc, 0.8))
    return cv, b


# ---------------------------------------------------------------------------
#  Retratos de diálogo
# ---------------------------------------------------------------------------
def build_portrait(spec, expr, dark=False):
    s = dict(spec)
    if dark:
        s.update(spec.get("dark", {}))
    else:
        for k in ("ears", "tail"):
            if not spec.get("lw_" + k):
                s.pop(k, None)
    s = dict(s)
    s["glasses_saved"] = s.get("glasses")
    s["glasses"] = None
    s["beard_saved"] = s.get("beard")
    s["beard"] = None
    s["blood_saved"] = s.get("blood_tears")
    s["blood_tears"] = None
    b = Body(s)
    small = Canvas(b.W, b.H)
    draw_hair_front(small, s, b, "down", "back")
    skin = C(s["skin"])
    head_shape(small, b, b.cx - 7, 14, skin)
    o = s.get("outfit", {})
    # hombros
    small.rect(b.cx - 8, b.y_neck + 1, 16, 6, C(o.get("top", "777777")))
    if o.get("tie"):
        small.rect(b.cx - 1, b.y_neck + 1, 2, 6, C(o["tie"]))
    if o.get("jacket"):
        small.rect(b.cx - 8, b.y_neck + 1, 5, 6, C(o["jacket"]))
        small.rect(b.cx + 3, b.y_neck + 1, 5, 6, C(o["jacket"]))
    small.rect(b.cx - 2, b.y_neck, 4, 2, skin)
    draw_hair_front(small, s, b, "down", "front")
    draw_ears(small, s, b, "down")
    draw_hat(small, s, b, "down")
    top = max(0, b.y_head_top - (12 if s.get("hat") in ("witch",) else 8))
    crop = small.im.crop((0, top, 24, min(b.H, b.y_neck + 7)))
    big = crop.resize((crop.width * 2, crop.height * 2), resample=0)
    cv = Canvas(52, 54)
    ox = (52 - big.width) // 2
    oy = 54 - big.height
    cv.paste(big, ox, oy)
    # coordenadas de la cara en el lienzo grande
    hy = oy + (b.y_head_top - top) * 2
    cx = ox + b.cx * 2
    ey = hy + 13
    lx, rx = cx - 8, cx + 4
    ec = C(s.get("eye_color", "231a2e"))

    def eye(x, kind):
        if kind == "closed":
            cv.hline(x, x + 3, ey + 2, ec)
        elif kind == "happy":
            cv.hline(x, x + 3, ey + 1, ec)
            cv.put(x, ey + 2, ec)
            cv.put(x + 3, ey + 2, ec)
        elif kind == "wide":
            cv.rect(x, ey - 1, 4, 5, WHITE)
            cv.rect(x + 1, ey, 2, 3, ec)
        elif kind == "sad":
            cv.rect(x, ey, 4, 4, WHITE)
            cv.rect(x + 1, ey + 1, 2, 3, ec)
        elif kind == "angry":
            cv.rect(x, ey + 1, 4, 3, WHITE)
            cv.rect(x + 1, ey + 1, 2, 3, ec)
        elif kind == "dead":
            cv.line(x, ey, x + 3, ey + 3, ec)
            cv.line(x + 3, ey, x, ey + 3, ec)
        else:
            cv.rect(x, ey, 4, 4, WHITE)
            cv.rect(x + 1, ey, 2, 4, ec)
            cv.put(x + 1, ey, WHITE)

    def brows(kind):
        bc = shade(C(s["hair"]), 0.6)
        if kind == "angry":
            cv.line(lx, ey - 4, lx + 4, ey - 2, bc)
            cv.line(rx + 4, ey - 4, rx, ey - 2, bc)
        elif kind == "sad":
            cv.line(lx, ey - 2, lx + 4, ey - 4, bc)
            cv.line(rx + 4, ey - 2, rx, ey - 4, bc)
        elif kind == "up":
            cv.hline(lx, lx + 3, ey - 5, bc)
            cv.hline(rx, rx + 3, ey - 5, bc)
        elif kind == "smug":
            cv.hline(lx, lx + 3, ey - 3, bc)
            cv.line(rx, ey - 5, rx + 4, ey - 4, bc)
        else:
            cv.hline(lx, lx + 3, ey - 3, bc)
            cv.hline(rx, rx + 3, ey - 3, bc)

    my = ey + 10

    def mouth(kind):
        if kind == "smile":
            cv.hline(cx - 3, cx + 2, my, MOUTH)
            cv.put(cx - 4, my - 1, MOUTH)
            cv.put(cx + 3, my - 1, MOUTH)
        elif kind == "grin":
            cv.rect(cx - 4, my - 1, 8, 3, MOUTH)
            cv.hline(cx - 3, cx + 2, my - 1, WHITE)
        elif kind == "open":
            cv.rect(cx - 2, my - 1, 4, 4, MOUTH)
        elif kind == "frown":
            cv.hline(cx - 3, cx + 2, my, MOUTH)
            cv.put(cx - 4, my + 1, MOUTH)
            cv.put(cx + 3, my + 1, MOUTH)
        elif kind == "smirk":
            cv.hline(cx - 2, cx + 2, my, MOUTH)
            cv.put(cx + 3, my - 1, MOUTH)
        elif kind == "teeth":
            cv.rect(cx - 4, my - 1, 8, 3, WHITE)
            cv.hline(cx - 4, cx + 3, my, MOUTH)
        elif kind == "wavy":
            for i in range(-3, 4):
                cv.put(cx + i, my + (i % 2), MOUTH)
        else:
            cv.hline(cx - 2, cx + 1, my, MOUTH)

    EXPR = {
        "neutral": ("normal", "normal", "flat"),
        "happy": ("happy", "up", "smile"),
        "smile": ("normal", "normal", "smile"),
        "grin": ("normal", "up", "grin"),
        "angry": ("angry", "angry", "teeth"),
        "annoyed": ("angry", "angry", "flat"),
        "sad": ("sad", "sad", "frown"),
        "surprised": ("wide", "up", "open"),
        "smug": ("normal", "smug", "smirk"),
        "blush": ("happy", "up", "wavy"),
        "crying": ("closed", "sad", "frown"),
        "scared": ("wide", "sad", "wavy"),
        "closed": ("closed", "normal", "smile"),
        "dead": ("dead", "normal", "open"),
        "shout": ("angry", "angry", "open"),
    }
    e_eye, e_brow, e_mouth = EXPR.get(expr, EXPR["neutral"])
    eye(lx, e_eye)
    eye(rx, e_eye)
    brows(e_brow)
    if s.get("beard_saved") == "full":
        bc = C(s.get("beard_color") or s["hair"])
        cv.rect(cx - 11, ey + 6, 22, 9, bc)
        cv.rect(cx - 8, ey + 15, 16, 2, bc)
        mouth(e_mouth)
    elif s.get("beard_saved") == "mustache":
        bc = C(s.get("beard_color") or s["hair"])
        mouth(e_mouth)
        cv.rect(cx - 5, my - 3, 10, 2, bc)
    elif s.get("beard_saved") == "stubble":
        for x in range(cx - 9, cx + 9, 2):
            for y in range(ey + 8, ey + 14, 2):
                cv.put(x + (y // 2) % 2, y, shade(skin, 0.75))
        mouth(e_mouth)
    else:
        mouth(e_mouth)
    if expr in ("blush",) or s.get("blush"):
        cv.rect(lx - 1, ey + 6, 3, 1, BLUSH)
        cv.rect(rx + 2, ey + 6, 3, 1, BLUSH)
    if expr == "crying":
        cv.vline(lx + 1, ey + 3, ey + 9, C("8fd3ff"))
        cv.vline(rx + 2, ey + 3, ey + 9, C("8fd3ff"))
    if s.get("blood_saved"):
        # lágrimas de sangre "hiperrealistas": degradado rojo oscuro con brillo
        for x0 in (lx + 1, rx + 1):
            for i in range(16):
                f = 0.55 + 0.45 * (i / 15)
                cv.put(x0, ey + 4 + i, (int(150 * f + 60), int(4 * f), int(18 * f), 255))
                cv.put(x0 + 1, ey + 4 + i, (int(110 * f + 40), 0, int(10 * f), 255))
                if i % 5 == 2:
                    cv.put(x0 - 1, ey + 4 + i, (200, 40, 50, 255))
            cv.ellipse(x0 + 0.5, ey + 21, 1.6, 2, (120, 0, 10, 255))
            cv.put(x0, ey + 20, (255, 140, 140, 255))
    g = s.get("glasses_saved")
    if g:
        gc = C(s.get("glasses_color", "1b1b1b"))
        if g == "sun":
            cv.rect(lx - 2, ey - 1, 18, 6, gc)
            cv.hline(lx - 1, lx + 2, ey, C("6a6a6a"))
        else:
            for x in (lx, rx):
                cv.hline(x - 2, x + 5, ey - 2, gc)
                cv.hline(x - 2, x + 5, ey + 5, gc)
                cv.vline(x - 2, ey - 2, ey + 5, gc)
                cv.vline(x + 5, ey - 2, ey + 5, gc)
            cv.hline(lx + 6, rx - 3, ey, gc)
    if s.get("acne"):
        cv.put(lx - 2, ey + 8, C("d0645c"))
        cv.put(rx + 5, ey + 7, C("d0645c"))
        cv.put(cx + 6, ey + 10, C("d0645c"))
    cv.outline()
    return cv
