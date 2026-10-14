"""Utilidades de pixel-art para generar los sprites originales del mod.

Todo se dibuja a 1x (como los sprites de DELTARUNE); Kristal los escala x2.
"""
from PIL import Image

OUTLINE = (24, 16, 32, 255)


def hexc(h, a=255):
    h = h.lstrip("#")
    return (int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16), a)


def shade(c, f):
    """Oscurece (f<1) o aclara (f>1) un color RGBA."""
    r, g, b, a = c
    if f < 1:
        return (int(r * f), int(g * f), int(b * f), a)
    return (min(255, int(r + (255 - r) * (f - 1))),
            min(255, int(g + (255 - g) * (f - 1))),
            min(255, int(b + (255 - b) * (f - 1))), a)


class Canvas:
    def __init__(self, w, h):
        self.w, self.h = w, h
        self.im = Image.new("RGBA", (w, h), (0, 0, 0, 0))
        self.px = self.im.load()

    def put(self, x, y, c):
        x, y = int(x), int(y)
        if 0 <= x < self.w and 0 <= y < self.h and c is not None:
            if len(c) == 4 and c[3] == 0:
                self.px[x, y] = (0, 0, 0, 0)
            else:
                self.px[x, y] = c

    def get(self, x, y):
        if 0 <= x < self.w and 0 <= y < self.h:
            return self.px[x, y]
        return (0, 0, 0, 0)

    def rect(self, x, y, w, h, c):
        for yy in range(int(y), int(y + h)):
            for xx in range(int(x), int(x + w)):
                self.put(xx, yy, c)

    def hline(self, x0, x1, y, c):
        for xx in range(int(min(x0, x1)), int(max(x0, x1)) + 1):
            self.put(xx, y, c)

    def vline(self, x, y0, y1, c):
        for yy in range(int(min(y0, y1)), int(max(y0, y1)) + 1):
            self.put(x, yy, c)

    def line(self, x0, y0, x1, y1, c):
        x0, y0, x1, y1 = int(x0), int(y0), int(x1), int(y1)
        dx, dy = abs(x1 - x0), -abs(y1 - y0)
        sx = 1 if x0 < x1 else -1
        sy = 1 if y0 < y1 else -1
        err = dx + dy
        while True:
            self.put(x0, y0, c)
            if x0 == x1 and y0 == y1:
                break
            e2 = 2 * err
            if e2 >= dy:
                err += dy
                x0 += sx
            if e2 <= dx:
                err += dx
                y0 += sy

    def ellipse(self, cx, cy, rx, ry, c):
        for yy in range(int(cy - ry) - 1, int(cy + ry) + 2):
            for xx in range(int(cx - rx) - 1, int(cx + rx) + 2):
                if rx <= 0 or ry <= 0:
                    continue
                if ((xx - cx) / rx) ** 2 + ((yy - cy) / ry) ** 2 <= 1.0:
                    self.put(xx, yy, c)

    def tri(self, pts, c):
        (x0, y0), (x1, y1), (x2, y2) = pts
        minx, maxx = int(min(x0, x1, x2)), int(max(x0, x1, x2))
        miny, maxy = int(min(y0, y1, y2)), int(max(y0, y1, y2))

        def sign(ax, ay, bx, by, cx, cy):
            return (ax - cx) * (by - cy) - (bx - cx) * (ay - cy)
        for yy in range(miny, maxy + 1):
            for xx in range(minx, maxx + 1):
                px, py = xx + 0.5, yy + 0.5
                d1 = sign(px, py, x0, y0, x1, y1)
                d2 = sign(px, py, x1, y1, x2, y2)
                d3 = sign(px, py, x2, y2, x0, y0)
                neg = (d1 < 0) or (d2 < 0) or (d3 < 0)
                pos = (d1 > 0) or (d2 > 0) or (d3 > 0)
                if not (neg and pos):
                    self.put(xx, yy, c)

    def poly(self, pts, c):
        # relleno por scanline
        n = len(pts)
        miny = int(min(p[1] for p in pts))
        maxy = int(max(p[1] for p in pts))
        for yy in range(miny, maxy + 1):
            y = yy + 0.5
            xs = []
            for i in range(n):
                xa, ya = pts[i]
                xb, yb = pts[(i + 1) % n]
                if (ya <= y < yb) or (yb <= y < ya):
                    xs.append(xa + (y - ya) * (xb - xa) / (yb - ya))
            xs.sort()
            for i in range(0, len(xs) - 1, 2):
                for xx in range(int(round(xs[i])), int(round(xs[i + 1]))):
                    self.put(xx, yy, c)

    def outline(self, c=OUTLINE, diag=False):
        """Añade un contorno de 1px alrededor de la silueta."""
        src = self.im.copy().load()
        for y in range(self.h):
            for x in range(self.w):
                if src[x, y][3] != 0:
                    continue
                nb = [(1, 0), (-1, 0), (0, 1), (0, -1)]
                if diag:
                    nb += [(1, 1), (-1, -1), (1, -1), (-1, 1)]
                for dx, dy in nb:
                    xx, yy = x + dx, y + dy
                    if 0 <= xx < self.w and 0 <= yy < self.h and src[xx, yy][3] != 0 and src[xx, yy] != c:
                        self.px[x, y] = c
                        break

    def paste(self, other, x, y):
        img = other.im if isinstance(other, Canvas) else other
        self.im.alpha_composite(img, (int(x), int(y)))
        self.px = self.im.load()

    def flip(self):
        c = Canvas(self.w, self.h)
        c.im = self.im.transpose(Image.FLIP_LEFT_RIGHT)
        c.px = c.im.load()
        return c

    def copy(self):
        c = Canvas(self.w, self.h)
        c.im = self.im.copy()
        c.px = c.im.load()
        return c

    def recolor(self, f):
        for y in range(self.h):
            for x in range(self.w):
                p = self.px[x, y]
                if p[3]:
                    self.px[x, y] = f(p)

    def save(self, path):
        import os
        os.makedirs(os.path.dirname(path), exist_ok=True)
        self.im.save(path)


def crop_to_content(img, pad=0):
    bbox = img.getbbox()
    if not bbox:
        return img
    x0, y0, x1, y1 = bbox
    return img.crop((max(0, x0 - pad), max(0, y0 - pad), min(img.width, x1 + pad), min(img.height, y1 + pad)))


# Fuente de píxeles 3x5 para letreros dentro de los sprites
FONT3x5 = {
    "A": ["010", "101", "111", "101", "101"], "B": ["110", "101", "110", "101", "110"],
    "C": ["011", "100", "100", "100", "011"], "D": ["110", "101", "101", "101", "110"],
    "E": ["111", "100", "110", "100", "111"], "F": ["111", "100", "110", "100", "100"],
    "G": ["011", "100", "101", "101", "011"], "H": ["101", "101", "111", "101", "101"],
    "I": ["111", "010", "010", "010", "111"], "J": ["001", "001", "001", "101", "010"],
    "K": ["101", "101", "110", "101", "101"], "L": ["100", "100", "100", "100", "111"],
    "M": ["101", "111", "111", "101", "101"], "N": ["110", "101", "101", "101", "101"],
    "O": ["010", "101", "101", "101", "010"], "P": ["110", "101", "110", "100", "100"],
    "Q": ["010", "101", "101", "011", "001"], "R": ["110", "101", "110", "101", "101"],
    "S": ["011", "100", "010", "001", "110"], "T": ["111", "010", "010", "010", "010"],
    "U": ["101", "101", "101", "101", "111"], "V": ["101", "101", "101", "101", "010"],
    "W": ["101", "101", "111", "111", "101"], "X": ["101", "101", "010", "101", "101"],
    "Y": ["101", "101", "010", "010", "010"], "Z": ["111", "001", "010", "100", "111"],
    "0": ["111", "101", "101", "101", "111"], "1": ["010", "110", "010", "010", "111"],
    "2": ["110", "001", "010", "100", "111"], "3": ["110", "001", "010", "001", "110"],
    "4": ["101", "101", "111", "001", "001"], "5": ["111", "100", "110", "001", "110"],
    "6": ["011", "100", "111", "101", "111"], "7": ["111", "001", "010", "010", "010"],
    "8": ["111", "101", "111", "101", "111"], "9": ["111", "101", "111", "001", "110"],
    "!": ["010", "010", "010", "000", "010"], "?": ["110", "001", "010", "000", "010"],
    ".": ["000", "000", "000", "000", "010"], "-": ["000", "000", "111", "000", "000"],
    " ": ["000", "000", "000", "000", "000"], "+": ["000", "010", "111", "010", "000"],
    "Ñ": ["111", "000", "110", "101", "101"], "#": ["101", "111", "101", "111", "101"],
    "%": ["101", "001", "010", "100", "101"], ":": ["000", "010", "000", "010", "000"],
    "/": ["001", "001", "010", "100", "100"], "'": ["010", "010", "000", "000", "000"],
}


def text3x5(cv, x, y, s, c, spacing=1):
    cx = x
    for ch in s.upper():
        g = FONT3x5.get(ch, FONT3x5[" "])
        for j, row in enumerate(g):
            for i, bit in enumerate(row):
                if bit == "1":
                    cv.put(cx + i, y + j, c)
        cx += 3 + spacing
    return cx


def text_width3x5(s, spacing=1):
    return len(s) * (3 + spacing) - spacing
