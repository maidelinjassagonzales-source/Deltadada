"""Abascal MONTADO a caballo: junta los sprites de combate de Abascal con el caballo
(mirando hacia el equipo, a la izquierda) en un solo sprite por fotograma.
Crea assets/sprites/chars/abascal/caballo/*.png y el actor "abascal_caballo".
Uso: python3 herramientas/abascal_caballo.py  (también lo llama generar_todo.py)
"""
import os

from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
MOD = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm"))
SPR = os.path.join(MOD, "assets", "sprites")
SRC = os.path.join(SPR, "chars", "abascal", "boss")
DST = os.path.join(SPR, "chars", "abascal", "caballo")

W, H = 80, 72                 # lienzo del sprite combinado
HORSE_X, HORSE_Y = 5, 22      # dónde va el caballo (70x50) dentro del lienzo
RIDER_DX, RIDER_DY = 6, -8    # desplazamiento de Abascal para que quede en la silla
WAIST = 41                    # fila (en el sprite de Abascal) donde empiezan las piernas
PANTS = (0x2f, 0x2f, 0x2f, 255)
BOOT = (0x3a, 0x2a, 0x1a, 255)
OUTLINE = (0x14, 0x10, 0x18, 255)


def horse(frame):
    im = Image.open(os.path.join(SPR, "objects", "caballo_%d.png" % frame)).convert("RGBA")
    return im.transpose(Image.FLIP_LEFT_RIGHT)  # que mire hacia el equipo


def compose(rider, frame_index):
    cv = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    # el caballo, con las patas alternando
    cv.alpha_composite(horse(1 + frame_index % 2), (HORSE_X, HORSE_Y))
    # Abascal encima, sentado en la silla: solo de cintura para arriba
    top = rider.crop((0, 0, rider.width, WAIST))
    cv.alpha_composite(top, (RIDER_DX, RIDER_DY))
    # una pierna colgando por el costado del caballo, con su bota
    lx = RIDER_DX + 34
    ly = RIDER_DY + WAIST
    for y in range(ly - 1, ly + 9):
        for x in range(lx - 1, lx + 4):
            cv.putpixel((x, y), OUTLINE)
    for y in range(ly, ly + 6):
        for x in range(lx, lx + 3):
            cv.putpixel((x, y), PANTS)
    for y in range(ly + 6, ly + 8):
        for x in range(lx - 1, lx + 3):
            cv.putpixel((x, y), BOOT)
    return cv


ACTOR = '''-- Generado por herramientas/abascal_caballo.py (sprites originales)
-- Abascal montado a caballo (sprite de combate combinado)
local actor, super = Class(Actor, "abascal_caballo")

function actor:init()
    super.init(self)
    self.name = "Santiago Abascal"
    self.width = %d
    self.height = %d
    self.hitbox = {6, %d, %d, 12}
    self.soul_offset = {%d, %d}
    self.color = {1, 1, 1}
    self.path = "chars/abascal/caballo"
    self.default = "idle"
    self.voice = "abascal"
    self.portrait_path = "face/abascal_dw"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 1/6, true},
        ["hurt"] = {"hurt", 1, false},
        ["spared"] = {"victory", 1/10, false},
        ["attack"] = {"attack", 1/15, false, next="idle"},
        ["spell"] = {"spell", 1/12, false, next="idle"},
        ["defeat"] = {"defeat", 1, false},
        ["act"] = {"act", 1/12, false, next="idle"},
        ["frozen"] = {"hurt", 1, false},
    }
    self.offsets = {
    }
end

return actor
''' % (W, H, H - 14, W - 12, W // 2, H // 2)


# En el mapa del Cortijo también va a caballo (mirando hacia donde llega el equipo)
ACTOR_MAPA = '''-- Generado por herramientas/abascal_caballo.py (sprites originales)
-- Abascal montado a caballo en el mapa del Cortijo
local actor, super = Class(Actor, "abascal_montado")

function actor:init()
    super.init(self)
    self.name = "Santiago Abascal"
    self.width = %d
    self.height = %d
    self.hitbox = {10, %d, %d, 14}
    self.color = {1, 1, 1}
    self.path = "chars/abascal/caballo"
    self.default = "idle"
    self.voice = "abascal"
    self.portrait_path = "face/abascal_dw"
    self.portrait_offset = {-6, -2}
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 1/4, true},
    }
    self.offsets = {
    }
end

return actor
''' % (W, H, H - 16, W - 20)


def main():
    os.makedirs(DST, exist_ok=True)
    n = 0
    for f in sorted(os.listdir(SRC)):
        if not f.endswith(".png"):
            continue
        rider = Image.open(os.path.join(SRC, f)).convert("RGBA")
        idx = int(f.rsplit("_", 1)[1][:-4]) if "_" in f else 1
        compose(rider, idx).save(os.path.join(DST, f))
        n += 1
    with open(os.path.join(MOD, "scripts", "data", "actors", "abascal_caballo.lua"), "w", encoding="utf-8") as fh:
        fh.write(ACTOR)
    with open(os.path.join(MOD, "scripts", "data", "actors", "abascal_montado.lua"), "w", encoding="utf-8") as fh:
        fh.write(ACTOR_MAPA)
    print("abascal a caballo:", n, "fotogramas")


if __name__ == "__main__":
    main()
