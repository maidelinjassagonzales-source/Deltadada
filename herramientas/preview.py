"""Hoja de contacto para revisar los sprites generados (no hace falta para el mod)."""
import sys
from PIL import Image
from personajes import build_overworld, build_battle, build_portrait
from fichas import FICHAS


def sheet(names, out, scale=3):
    rows = []
    for n in names:
        spec = FICHAS[n]
        imgs = []
        for dark in (False, True):
            for view in ("down", "right", "up", "left"):
                for f in (0, 1):
                    cv, _ = build_overworld(spec, view, f, dark)
                    imgs.append(cv.im)
        for anim in ("idle", "attack", "spell", "hurt", "defend"):
            cv, _ = build_battle(spec, anim, 2 if anim in ("attack", "spell") else 0)
            imgs.append(cv.im)
        for e in spec.get("exprs", [])[:4]:
            imgs.append(build_portrait(spec, e, dark=False).im)
        imgs.append(build_portrait(spec, spec.get("exprs", ["neutral"])[0], dark=True).im)
        rows.append(imgs)
    W = max(sum(i.width + 2 for i in r) for r in rows)
    H = sum(max(i.height for i in r) + 4 for r in rows)
    sh = Image.new("RGBA", (W, H), (60, 70, 90, 255))
    y = 0
    for r in rows:
        x = 0
        for i in r:
            sh.alpha_composite(i, (x, y))
            x += i.width + 2
        y += max(i.height for i in r) + 4
    sh = sh.resize((sh.width * scale, sh.height * scale), Image.NEAREST)
    sh.save(out)


if __name__ == "__main__":
    names = sys.argv[2:] or list(FICHAS.keys())
    sheet(names, sys.argv[1])
