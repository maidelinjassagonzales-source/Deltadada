"""Genera TODOS los assets originales del mod y los actores de Kristal.

Uso:  python3 herramientas/generar_todo.py
(Requiere Pillow.)  Escribe en deltarune_pcdm/assets y deltarune_pcdm/scripts/data/actors.
"""
import math
import os
import struct
import sys
import wave
import random

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from PIL import Image  # noqa: E402

from pix import Canvas, hexc, shade  # noqa: E402
from personajes import build_overworld, build_battle, build_portrait, BATTLE_ANIMS, BATTLE_PAD_L, BATTLE_PAD_T, Body  # noqa: E402
from fichas import FICHAS, PARTY, BOSSES  # noqa: E402
import enemigos as EN  # noqa: E402
import tiles as TL  # noqa: E402
import font5x7  # noqa: E402

ROOT = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm"))
SPR = os.path.join(ROOT, "assets", "sprites")
ACT = os.path.join(ROOT, "scripts", "data", "actors")
REPO = os.path.normpath(os.path.join(HERE, ".."))


def save(img, rel):
    p = os.path.join(SPR, rel + ".png")
    os.makedirs(os.path.dirname(p), exist_ok=True)
    (img.im if isinstance(img, Canvas) else img).save(p)


def lua_str(s):
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


VOICE_FREQ = {
    "lucia": (620, "square"), "yerover": (560, "square"), "gabriel": (300, "saw"), "isra": (360, "square"),
    "angel": (700, "tri"), "alejandro": (480, "tri"), "carmen": (520, "sine"), "david": (420, "tri"),
    "julio": (390, "square"), "xibin": (260, "saw"), "pablo": (330, "saw"), "dayron": (280, "square"),
    "angelpedro": (240, "tri"), "andres": (350, "sine"), "aridai": (760, "sine"), "aroy": (110, "saw"),
    "trump": (200, "saw"), "netanyahu": (220, "square"), "abascal": (180, "square"), "vito": (450, "saw"),
    "motos": (400, "square"), "sanchez": (330, "sine"), "mamdani": (380, "tri"), "iglesias": (300, "tri"),
    "yolanda": (540, "sine"), "panavi": (340, "square"), "borja": (310, "tri"), "bellerin": (360, "sine"),
    "papa": (250, "sine"), "fernanda": (600, "tri"), "brayan": (420, "square"), "profe": (500, "sine"),
    "paco": (280, "tri"), "candelaria": (460, "sine"), "percha": (650, "tri"), "flowerman": (520, "sine"),
}


def gen_voice(name, freq, kind):
    """Pitidos de voz originales (como los de los textos de DELTARUNE)."""
    rate = 22050
    dur = 0.055
    n = int(rate * dur)
    frames = []
    for i in range(n):
        t = i / rate
        ph = (t * freq) % 1.0
        if kind == "square":
            v = 1.0 if ph < 0.5 else -1.0
        elif kind == "saw":
            v = 2 * ph - 1
        elif kind == "tri":
            v = 4 * abs(ph - 0.5) - 1
        else:
            v = math.sin(2 * math.pi * ph)
        env = min(1.0, i / 60) * (1 - i / n) ** 1.5
        frames.append(struct.pack("<h", int(v * env * 9000)))
    p = os.path.join(ROOT, "assets", "sounds", "voice", name + ".wav")
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with wave.open(p, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(rate)
        w.writeframes(b"".join(frames))


def gen_sfx():
    """Efectos de sonido originales sintetizados."""
    rate = 22050

    def write(name, samples):
        p = os.path.join(ROOT, "assets", "sounds", name + ".wav")
        os.makedirs(os.path.dirname(p), exist_ok=True)
        with wave.open(p, "wb") as w:
            w.setnchannels(1)
            w.setsampwidth(2)
            w.setframerate(rate)
            w.writeframes(b"".join(struct.pack("<h", max(-32767, min(32767, int(s * 30000)))) for s in samples))

    rnd = random.Random(3)
    # golpe de silla rota
    write("pcdm_silla", [rnd.uniform(-1, 1) * (1 - i / 6000) ** 3 for i in range(6000)])
    # chu-chu de tren
    s = []
    for k in range(2):
        for i in range(5000):
            t = i / rate
            s.append((math.sin(2 * math.pi * 520 * t) + math.sin(2 * math.pi * 660 * t)) * 0.4 * (1 - i / 5000))
        s += [0] * 1500
    write("pcdm_chuchu", s)
    # glitch de Aroy
    s = []
    for i in range(9000):
        s.append(rnd.choice([-1, 1]) * 0.6 if (i // 300) % 2 == 0 else math.sin(i * 0.3) * 0.5)
    write("pcdm_glitch", s)
    # "momento incómodo": grillos
    s = []
    for i in range(int(rate * 1.6)):
        t = i / rate
        chirp = 1 if (t * 6) % 1 < 0.15 else 0
        s.append(math.sin(2 * math.pi * 4200 * t) * 0.25 * chirp)
    write("pcdm_grillos", s)
    # aplauso lento (cada palmada es un ruido corto)
    s = []
    for k in range(4):
        s += [rnd.uniform(-1, 1) * (1 - i / 1500) ** 4 for i in range(1500)]
        s += [0] * int(rate * 0.7)
    write("pcdm_aplauso", s)
    # tijeretazo
    s = []
    for i in range(3000):
        t = i / rate
        s.append((rnd.uniform(-1, 1) * 0.5 + math.sin(2 * math.pi * 2400 * t) * 0.5) * (1 - i / 3000) ** 2)
    write("pcdm_tijera", s)
    # bocina de guagua
    s = []
    for i in range(int(rate * 0.6)):
        t = i / rate
        s.append((math.sin(2 * math.pi * 330 * t) + math.sin(2 * math.pi * 415 * t)) * 0.35)
    write("pcdm_bocina", s)
    # trago / hipo
    s = []
    for i in range(4000):
        t = i / rate
        s.append(math.sin(2 * math.pi * (200 + i * 0.1) * t) * (1 - i / 4000))
    write("pcdm_trago", s)
    # sonido de "furry" (uwu): barrido agudo
    s = []
    for i in range(7000):
        t = i / rate
        f = 900 + 600 * math.sin(t * 30)
        s.append(math.sin(2 * math.pi * f * t) * 0.4 * (1 - i / 7000))
    write("pcdm_uwu", s)


def head_icon(spec, dark=True, hurt=False):
    """Iconos de cabeza (menú y combate) a partir del sprite frontal."""
    cv, b = build_overworld(spec, "down", 0, dark)
    top = max(0, b.y_head_top - 6)
    crop = cv.im.crop((0, top, b.W, b.y_neck + 1))
    out = Image.new("RGBA", (29, 24), (0, 0, 0, 0))
    c2 = crop.copy()
    if c2.height > 24:
        c2 = c2.crop((0, c2.height - 24, c2.width, c2.height))
    out.alpha_composite(c2, ((29 - c2.width) // 2, 24 - c2.height))
    if hurt:
        px = out.load()
        for y in range(out.height):
            for x in range(out.width):
                r, g, bb, a = px[x, y]
                if a:
                    px[x, y] = (min(255, r + 60), g // 2, bb // 2, a)
    menu = out.resize((25, 20), Image.NEAREST)
    return out, menu


ACTION_ICONS = {}


def action_icons():
    """Iconos genéricos de acción (originales)."""
    H = hexc
    icons = {}
    # espada
    c = Canvas(32, 24)
    c.line(6, 18, 22, 4, H("e8e8e8"))
    c.line(7, 18, 23, 4, H("bfbfbf"))
    c.line(5, 13, 11, 19, H("c9a227"))
    c.rect(3, 19, 3, 3, H("8a5a2b"))
    c.outline()
    icons["attack"] = c
    # actuar (bocadillo)
    c = Canvas(32, 24)
    c.ellipse(16, 10, 11, 7, H("ffffff"))
    c.tri([(10, 15), (14, 15), (8, 21)], H("ffffff"))
    for x in (11, 16, 21):
        c.rect(x, 9, 2, 2, H("e08a2a"))
    c.outline()
    icons["act"] = c
    # magia (estrella)
    c = Canvas(32, 24)
    c.tri([(16, 2), (20, 12), (12, 12)], H("ff7ad9"))
    c.tri([(6, 9), (26, 9), (16, 16)], H("ff7ad9"))
    c.tri([(16, 12), (24, 22), (16, 17)], H("ff7ad9"))
    c.tri([(16, 12), (8, 22), (16, 17)], H("ff7ad9"))
    c.outline()
    icons["spell"] = c
    # objeto (bolsa)
    c = Canvas(32, 24)
    c.ellipse(16, 14, 9, 8, H("c8955a"))
    c.rect(12, 3, 8, 5, H("a8754a"))
    c.outline()
    icons["item"] = c
    # perdonar (corazón amarillo)
    c = Canvas(32, 24)
    c.paste(EN.alma("ffd23f").im.resize((24, 24), Image.NEAREST), 4, 0)
    icons["spare"] = c
    # defender (escudo)
    c = Canvas(32, 24)
    c.poly([(8, 3), (24, 3), (24, 12), (16, 21), (8, 12)], H("4a7ab0"))
    c.rect(15, 5, 2, 12, H("ffffff"))
    c.outline()
    icons["defend"] = c
    return icons


def write_actor(aid, name, path, default, w, h, portrait, voice, battle=False, extra_anims=None,
                offsets=None, color=(1, 1, 1), battle_offset=(-BATTLE_PAD_L, -BATTLE_PAD_T), flip=None):
    hb = "{%d, %d, %d, %d}" % (3, h - 14, w - 6, 12)
    lines = [
        "-- Generado por herramientas/generar_todo.py (sprites originales)",
        'local actor, super = Class(Actor, %s)' % lua_str(aid),
        "",
        "function actor:init()",
        "    super.init(self)",
        "    self.name = %s" % lua_str(name),
        "    self.width = %d" % w,
        "    self.height = %d" % h,
        "    self.hitbox = %s" % hb,
        "    self.soul_offset = {%d, %d}" % (w // 2, int(h * 0.55)),
        "    self.color = {%s, %s, %s}" % color,
        "    self.path = %s" % lua_str(path),
        "    self.default = %s" % lua_str(default),
        "    self.voice = %s" % (lua_str(voice) if voice else "nil"),
        "    self.portrait_path = %s" % (lua_str(portrait) if portrait else "nil"),
        "    self.portrait_offset = {-6, -2}",
        "    self.can_blush = false",
    ]
    if flip:
        lines.append("    self.flip = %s" % lua_str(flip))
    lines.append("    self.talk_sprites = {}")
    lines.append("    self.animations = {")
    if battle:
        lines += [
            '        ["battle/idle"]         = {"battle/idle", 1/6, true},',
            '        ["battle/attack"]       = {"battle/attack", 1/15, false},',
            '        ["battle/act"]          = {"battle/act", 1/15, false},',
            '        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},',
            '        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},',
            '        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},',
            '        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},',
            '        ["battle/act_ready"]    = {"battle/actready", 0.2, true},',
            '        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},',
            '        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},',
            '        ["battle/defend_ready"] = {"battle/defend", 1/15, false},',
            '        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},',
            '        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},',
            '        ["battle/defeat"]       = {"battle/defeat", 1/15, false},',
            '        ["battle/swooned"]      = {"battle/defeat", 1/15, false},',
            '        ["battle/transition"]   = {"walk/right_1", 1/15, false},',
            '        ["battle/intro"]        = {"battle/attack", 1/15, true},',
            '        ["battle/victory"]      = {"battle/victory", 1/10, false},',
        ]
    for k, v in (extra_anims or {}).items():
        lines.append('        [%s] = %s,' % (lua_str(k), v))
    lines.append("    }")
    lines.append("    self.offsets = {")
    if battle:
        for anim in BATTLE_ANIMS:
            lines.append('        ["battle/%s"] = {%d, %d},' % (anim, battle_offset[0], battle_offset[1]))
    for k, v in (offsets or {}).items():
        lines.append('        [%s] = {%d, %d},' % (lua_str(k), v[0], v[1]))
    lines.append("    }")
    lines.append("end")
    lines.append("")
    lines.append("return actor")
    p = os.path.join(ACT, aid + ".lua")
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


def export_character(cid, spec):
    for dark in (False, True):
        sub = "dark" if dark else "light"
        b = None
        for view in ("down", "up", "left", "right"):
            for fr in range(4):
                cv, b = build_overworld(spec, view, fr, dark)
                save(cv, "chars/%s/%s/walk/%s_%d" % (cid, sub, view, fr + 1))
        # poses extra para escenas
        st, _ = build_overworld(spec, "down", 0, dark)
        fallen = st.im.rotate(90, expand=True)
        save(fallen, "chars/%s/%s/fallen" % (cid, sub))
        all_exprs = ["neutral", "happy", "smile", "grin", "angry", "annoyed", "sad", "surprised", "smug", "blush",
                     "crying", "scared", "closed", "shout", "dead"]
        for e in all_exprs:
            save(build_portrait(spec, e, dark=dark), "face/%s%s/%s" % (cid, "_dw" if dark else "", e))
        battle = cid in PARTY or cid in BOSSES
        if battle and dark:
            for anim, frames in BATTLE_ANIMS.items():
                for i in range(len(frames)):
                    cv, _ = build_battle(spec, anim, i, True)
                    save(cv, "chars/%s/dark/battle/%s_%d" % (cid, anim, i + 1))
        voice = cid if cid in VOICE_FREQ else None
        aid = cid if dark else cid + "_lw"
        write_actor(
            aid, spec["name"], "chars/%s/%s" % (cid, sub), "walk", b.W, b.H,
            "face/%s%s" % (cid, "_dw" if dark else ""), voice, battle=(battle and dark),
            extra_anims={"fallen": '{"fallen", 1, false}'},
            offsets={"fallen": (-(b.H - b.W) // 2, b.H - b.W - 2)},
        )
    if cid in BOSSES:
        # versión jefe: sprites de combate mirando a la izquierda
        for anim, frames in BATTLE_ANIMS.items():
            for i in range(len(frames)):
                cv, b = build_battle(spec, anim, i, True)
                save(cv.flip(), "chars/%s/boss/%s_%d" % (cid, anim, i + 1))
        cv, b = build_battle(spec, "idle", 0, True)
        w, h = cv.w, cv.h
        anims = {
            "idle": '{"idle", 1/6, true}', "hurt": '{"hurt", 1, false}', "spared": '{"victory", 1/10, false}',
            "attack": '{"attack", 1/15, false, next="idle"}', "spell": '{"spell", 1/12, false, next="idle"}',
            "defeat": '{"defeat", 1, false}', "act": '{"act", 1/12, false, next="idle"}',
            "frozen": '{"hurt", 1, false}',
        }
        write_actor(cid + "_boss", spec["name"], "chars/%s/boss" % cid, "idle", w, h,
                    "face/%s_dw" % cid, cid if cid in VOICE_FREQ else None, battle=False, extra_anims=anims)
    if cid in PARTY:
        icons = action_icons()
        head, menu = head_icon(spec, True)
        hh, _ = head_icon(spec, True, hurt=True)
        save(head, "party/%s/icon/head" % cid)
        save(hh, "party/%s/icon/head_hurt" % cid)
        for k, v in icons.items():
            save(v, "party/%s/icon/%s" % (cid, k))
        save(menu, "party/%s/head" % cid)
        lhead, lmenu = head_icon(spec, False)
        save(lmenu, "party/%s/head_lw" % cid)
        save(font5x7.render(spec["name"]), "party/%s/name" % cid)


def export_enemies():
    for eid, fn in EN.MOBS.items():
        save(fn("normal", 0), "enemies/%s/idle_1" % eid)
        save(fn("normal", 1), "enemies/%s/idle_2" % eid)
        save(fn("hurt", 0), "enemies/%s/hurt" % eid)
        save(fn("spared", 0), "enemies/%s/spared" % eid)
        im = fn("normal", 0)
        write_actor(eid, eid, "enemies/%s" % eid, "idle", im.w, im.h, None, None,
                    extra_anims={"idle": '{"idle", 0.35, true}', "hurt": '{"hurt", 1, false}',
                                 "spared": '{"spared", 1, false}', "frozen": '{"hurt", 1, false}'})
    stickers = [("sticker1", "1.webp"), ("sticker2", "2.webp"), ("sticker3", "Sin título.webp")]
    for sid, fname in stickers:
        fn = EN.sticker_from(os.path.join(REPO, fname))
        save(fn("normal", 0), "enemies/%s/idle_1" % sid)
        save(fn("normal", 1), "enemies/%s/idle_2" % sid)
        save(fn("hurt", 0), "enemies/%s/hurt" % sid)
        save(fn("spared", 0), "enemies/%s/spared" % sid)
        write_actor(sid, "Sticker de Dayron", "enemies/%s" % sid, "idle", 48, 48, None, None,
                    extra_anims={"idle": '{"idle", 0.35, true}', "hurt": '{"hurt", 1, false}',
                                 "spared": '{"spared", 1, false}', "frozen": '{"hurt", 1, false}'})
    # jefes especiales
    specials = {
        "tijerafang": EN.tijerafang, "aroy_big": EN.aroy_big, "omega_aroy": EN.omega_aroy,
    }
    for sid, fn in specials.items():
        for fr in range(4):
            save(fn("normal", fr), "bosses/%s/idle_%d" % (sid, fr + 1))
        save(fn("hurt", 0), "bosses/%s/hurt" % sid)
        save(fn("angry", 0), "bosses/%s/angry" % sid)
        im = fn("normal", 0)
        write_actor(sid, sid, "bosses/%s" % sid, "idle", im.w, im.h, None, "aroy" if "aroy" in sid else "andres",
                    extra_anims={"idle": '{"idle", 0.2, true}', "hurt": '{"hurt", 1, false}',
                                 "spared": '{"idle", 0.2, true}', "angry": '{"angry", 1, false}',
                                 "frozen": '{"hurt", 1, false}'})
    # objetos
    for fr in range(2):
        save(EN.guagua(fr), "objects/guagua_%d" % (fr + 1))
        save(EN.flowerman(fr), "objects/flowerman_%d" % (fr + 1))
        save(EN.caballo(fr), "objects/caballo_%d" % (fr + 1))
        save(EN.tele(fr), "objects/tele_%d" % (fr + 1))
        save(EN.blaster(fr), "objects/blaster_%d" % (fr + 1))
    save(EN.espejo(), "objects/espejo")
    save(EN.sillas_apiladas(), "objects/sillas_apiladas")
    save(EN.sticker_dorado(0), "objects/sticker_dorado_1")
    save(EN.sticker_dorado(1), "objects/sticker_dorado_2")
    save(EN.trono_armario(), "objects/trono_armario")
    for nm, txt, col in (("taberna", "TABERNA", "7a2a3a"), ("tacos", "TACOS FER", "2fa04a"), ("modas", "MODAS SHANGHAI", "c9a227"),
                         ("plato", "EL HORMIGUERO", "1e5bb8"), ("casablanca", "CASA BLANCA", "b5523a"), ("teror", "TEROR", "2f6a2f"),
                         ("instituto", "IES PCDM", "4a7ab0")):
        save(EN.cartel(txt, col), "objects/cartel_" + nm)
    save(EN.armario(False), "objects/armario_cerrado")
    save(EN.armario(True), "objects/armario_abierto")
    for name, col in (("roja", "ff2a2a"), ("rosa", "ff9ccf"), ("amarilla", "ffd23f"), ("verde", "5fbf2f"),
                      ("azul", "6fb8ff"), ("morada", "c77dff"), ("naranja", "ff8c00"), ("blanca", "ffffff"),
                      ("negra", "3a3a3a"), ("cian", "4fe0e0")):
        save(EN.alma(col), "objects/alma_%s" % name)
    # Percha (guía): 4 direcciones
    for d in ("down", "up", "left", "right"):
        for fr in range(4):
            save(EN.percha(fr, d), "chars/percha/walk/%s_%d" % (d, fr + 1))
    write_actor("percha", "Príncipe Percha", "chars/percha", "walk", 26, 44, "face/percha", "percha")
    # retrato de la Percha
    for e in ("neutral", "happy", "surprised", "sad"):
        cv = Canvas(52, 54)
        big = EN.percha(0).im.resize((52, 88), Image.NEAREST).crop((0, 0, 52, 54))
        cv.paste(big, 0, 0)
        if e == "happy":
            cv.rect(18, 26, 16, 2, hexc("231a2e"))
        elif e == "surprised":
            cv.rect(23, 27, 6, 5, hexc("231a2e"))
        elif e == "sad":
            cv.rect(18, 30, 16, 2, hexc("231a2e"))
        save(cv, "face/percha/%s" % e)


def export_tilesets():
    for theme in TL.THEMES:
        cv = TL.make_tileset(theme)
        save(cv, "tilesets/%s" % theme)
        lua = """return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  name = "%s",
  class = "",
  tilewidth = 20,
  tileheight = 20,
  spacing = 0,
  margin = 0,
  columns = 8,
  image = "../../../assets/sprites/tilesets/%s.png",
  imagewidth = 160,
  imageheight = 80,
  objectalignment = "unspecified",
  tilerendersize = "grid",
  fillmode = "stretch",
  tileoffset = { x = 0, y = 0 },
  grid = { orientation = "orthogonal", width = 40, height = 40 },
  properties = {},
  wangsets = {},
  tilecount = 32,
  tiles = {}
}
""" % (theme, theme)
        p = os.path.join(ROOT, "scripts", "world", "tilesets", theme + ".lua")
        os.makedirs(os.path.dirname(p), exist_ok=True)
        with open(p, "w") as f:
            f.write(lua)


def export_misc():
    H = hexc
    # logo del mod
    from pix import text3x5
    cv = Canvas(160, 40)
    text3x5(cv, 4, 4, "DELTARUNE", H("ffffff"))
    text3x5(cv, 4, 14, "PCDM", H("ff7ad9"))
    text3x5(cv, 4, 26, "SAL DEL ARMARIO", H("b48cd8"))
    big = cv.im.resize((480, 120), Image.NEAREST)
    big.save(os.path.join(ROOT, "logo.png"))
    ic = EN.alma("ff7ad9").im.resize((32, 32), Image.NEAREST)
    ic.save(os.path.join(ROOT, "icon.png"))
    # fondo del menú de Kristal (preview)
    bg = Image.new("RGBA", (320, 240), (20, 10, 30, 255))
    px = bg.load()
    rnd = random.Random(4)
    for _ in range(300):
        px[rnd.randrange(320), rnd.randrange(240)] = (255, 122, 217, 255)
    bg.save(os.path.join(ROOT, "bg.png"))
    # "Good boy" de Aroy y título
    t = Canvas(120, 16)
    text3x5(t, 2, 5, "GOOD BOY", H("ffd23f"))
    save(t.im.resize((480, 64), Image.NEAREST), "ui/goodboy")
    # Viñeta de pensamiento
    t = Canvas(16, 16)
    t.ellipse(8, 8, 6, 5, H("ffffff"))
    t.outline()
    save(t, "ui/pensamiento")


if __name__ == "__main__":
    for vid, (fq, kind) in VOICE_FREQ.items():
        gen_voice(vid, fq, kind)
    gen_sfx()
    for cid, spec in FICHAS.items():
        export_character(cid, spec)
        print("personaje", cid)
    export_enemies()
    export_tilesets()
    export_misc()
    import balas
    for k, v in balas.B().items():
        save(v, "bullets/%s" % k)
    import abascal_caballo
    abascal_caballo.main()
    print("OK")
