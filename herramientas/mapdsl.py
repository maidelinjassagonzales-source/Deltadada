"""Mini-DSL para construir mapas de Kristal (formato Tiled exportado a Lua)."""
import os

T = 40  # tamaño del tile en el mundo (los tiles de 20px se dibujan x2)

LEGEND = {
    ".": 0, ",": 1, ":": 2, "=": 3, "#": 4, "W": 5, "P": 6, "V": 7, " ": 8,
    "d": 9, "l": 10, "p": 11, "r": 12, "f": 13, "_": 14, "~": 15,
    "A": 16, "B": 18, "C": 20, "E": 22,
}
SOLID_CHARS = set("#WPV dlp_~ABCE+")
BIG = {"A": 16, "B": 18, "C": 20, "E": 22}


def lua_value(v, ind=0):
    pad = "  " * ind
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        return repr(v)
    if isinstance(v, str):
        return '"' + v.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"'
    if isinstance(v, dict):
        if not v:
            return "{}"
        parts = []
        for k, val in v.items():
            parts.append(pad + "  " + '["%s"] = ' % k + lua_value(val, ind + 1))
        return "{\n" + ",\n".join(parts) + "\n" + pad + "}"
    if isinstance(v, (list, tuple)):
        if not v:
            return "{}"
        if all(isinstance(x, (int, float)) for x in v):
            return "{ " + ", ".join(repr(x) for x in v) + " }"
        return "{\n" + ",\n".join(pad + "  " + lua_value(x, ind + 1) for x in v) + "\n" + pad + "}"
    if v is None:
        return "nil"
    raise TypeError(v)


class Map:
    def __init__(self, mid, w, h, theme, name, music=None, light=False, fill=".", border=None, bg=None):
        self.id = mid
        self.w, self.h = w, h
        self.theme = theme
        self.name = name
        self.music = music
        self.light = light
        self.grid = [[fill] * w for _ in range(h)]
        self.over = {}  # (x,y) -> tile id para la capa de decoración
        self.objects = []
        self.markers = {}
        self.extra_collision = []
        self.no_collision = set()
        self.border = border
        self.bg = bg
        self.props = {}

    # ----------------------------------------------------------------- tiles
    def set(self, x, y, c):
        if 0 <= x < self.w and 0 <= y < self.h:
            self.grid[y][x] = c

    def rect(self, x, y, w, h, c):
        for yy in range(y, y + h):
            for xx in range(x, x + w):
                self.set(xx, yy, c)

    def row(self, y, s, x=0):
        for i, c in enumerate(s):
            self.set(x + i, y, c)

    def box(self, x, y, w, h, floor=".", top="#", face="W", face_rows=1):
        """Habitación: paredes alrededor y suelo dentro."""
        self.rect(x, y, w, h, top)
        self.rect(x + 1, y + 1, w - 2, face_rows, face)
        self.rect(x + 1, y + 1 + face_rows, w - 2, h - 2 - face_rows, floor)

    def big(self, x, y, c):
        self.set(x, y, c)
        self.set(x + 1, y, "+")
        self.set(x, y + 1, "+")
        self.set(x + 1, y + 1, "+")

    def walkable(self, x, y):
        self.no_collision.add((x, y))

    # ----------------------------------------------------------------- objetos
    def _obj(self, otype, name, x, y, w, h, props):
        self.objects.append(dict(type=otype, name=name, x=x, y=y, w=w, h=h, props=props))

    def npc(self, tx, ty, actor, cutscene=None, facing="down", turn=True, text=None, name="npc", **kw):
        p = {"actor": actor, "facing": facing, "turn": turn}
        if cutscene:
            p["cutscene"] = cutscene
        if text:
            if isinstance(text, str):
                p["text"] = text
            else:
                for i, t in enumerate(text):
                    p["text%d" % (i + 1)] = t
        p.update(kw)
        self._obj("npc", name, tx * T, ty * T + 16, T, T, p)
        return self

    def npc_named(self, uname, tx, ty, actor, cutscene=None, facing="down", **kw):
        p = {"actor": actor, "facing": facing, "turn": kw.pop("turn", True)}
        if cutscene:
            p["cutscene"] = cutscene
        p.update(kw)
        self._obj("npc", uname, tx * T, ty * T + 16, T, T, p)

    def interact(self, tx, ty, cutscene=None, w=1, h=1, text=None, solid=False, **kw):
        p = {}
        if cutscene:
            p["cutscene"] = cutscene
        if text:
            if isinstance(text, str):
                p["text"] = text
            else:
                for i, t in enumerate(text):
                    p["text%d" % (i + 1)] = t
        if solid:
            p["solid"] = True
        p.update(kw)
        self._obj("interactable", "interactable", tx * T, ty * T, w * T, h * T, p)

    def trans(self, tx, ty, w, h, map_, marker, facing=None, **kw):
        p = {"map": map_, "marker": marker}
        if facing:
            p["facing"] = facing
        p.update(kw)
        self._obj("transition", "transition", tx * T, ty * T, w * T, h * T, p)

    def script(self, tx, ty, w, h, cutscene, once=True, **kw):
        p = {"cutscene": cutscene, "once": once}
        p.update(kw)
        self._obj("script", "script", tx * T, ty * T, w * T, h * T, p)

    def save(self, tx, ty, **kw):
        self._obj("savepoint", "savepoint", tx * T, ty * T, T, T, dict(kw))

    def chest(self, tx, ty, item=None, money=None, **kw):
        p = dict(kw)
        if item:
            p["item"] = item
        if money:
            p["money"] = money
        self._obj("chest", "chest", tx * T, ty * T, T, T, p)

    def enemy(self, tx, ty, actor, encounter, **kw):
        p = {"actor": actor, "encounter": encounter}
        p.update(kw)
        self._obj("enemy", "enemy", tx * T, ty * T + 16, T, T, p)

    def event(self, etype, tx, ty, w=1, h=1, name=None, **kw):
        self._obj(etype, name or etype, tx * T, ty * T, w * T, h * T, dict(kw))

    def marker(self, name, tx, ty):
        self.markers[name] = (tx * T + T // 2, ty * T + T - 4)

    # ----------------------------------------------------------------- exportar
    def collisions(self):
        solid = [[(self.grid[y][x] in SOLID_CHARS and (x, y) not in self.no_collision) for x in range(self.w)]
                 for y in range(self.h)]
        rects = []
        used = [[False] * self.w for _ in range(self.h)]
        for y in range(self.h):
            x = 0
            while x < self.w:
                if solid[y][x] and not used[y][x]:
                    x2 = x
                    while x2 + 1 < self.w and solid[y][x2 + 1] and not used[y][x2 + 1]:
                        x2 += 1
                    y2 = y
                    ok = True
                    while ok and y2 + 1 < self.h:
                        for xx in range(x, x2 + 1):
                            if not solid[y2 + 1][xx] or used[y2 + 1][xx]:
                                ok = False
                                break
                        if ok:
                            y2 += 1
                    for yy in range(y, y2 + 1):
                        for xx in range(x, x2 + 1):
                            used[yy][xx] = True
                    rects.append((x * T, y * T, (x2 - x + 1) * T, (y2 - y + 1) * T))
                    x = x2 + 1
                else:
                    x += 1
        return rects + self.extra_collision

    def tile_layers(self):
        base, deco = [], []
        floor_tile = 0
        for y in range(self.h):
            for x in range(self.w):
                c = self.grid[y][x]
                gid_base = 0
                gid_deco = 0
                if c == " ":
                    gid_base = 0
                elif c in BIG:
                    gid_base = floor_tile + 1
                    gid_deco = BIG[c] + 1
                elif c == "+":
                    gid_base = floor_tile + 1
                    gid_deco = 0
                elif c in ("d", "l", "p", "r", "f"):
                    gid_base = floor_tile + 1
                    gid_deco = LEGEND[c] + 1
                else:
                    gid_base = LEGEND[c] + 1
                base.append(gid_base)
                deco.append(gid_deco)
        # rellenar las partes de los objetos grandes
        for y in range(self.h):
            for x in range(self.w):
                c = self.grid[y][x]
                if c in BIG:
                    t = BIG[c]
                    for dx, dy, add in ((0, 0, 0), (1, 0, 1), (0, 1, 8), (1, 1, 9)):
                        xx, yy = x + dx, y + dy
                        if 0 <= xx < self.w and 0 <= yy < self.h:
                            deco[yy * self.w + xx] = t + add + 1
        return base, deco

    def to_lua(self):
        base, deco = self.tile_layers()
        nid = [1]

        def next_id():
            nid[0] += 1
            return nid[0]

        def tilelayer(name, data, lid):
            rows = []
            for y in range(self.h):
                rows.append("        " + ", ".join(str(v) for v in data[y * self.w:(y + 1) * self.w]))
            return """    {
      type = "tilelayer", x = 0, y = 0, width = %d, height = %d, id = %d, name = "%s",
      class = "", visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {}, encoding = "lua",
      data = {
%s
      }
    }""" % (self.w, self.h, lid, name, ",\n".join(rows))

        def objgroup(name, objs, lid):
            items = []
            for o in objs:
                items.append("""        {
          id = %d, name = %s, type = %s, shape = "rectangle",
          x = %d, y = %d, width = %d, height = %d, rotation = 0, visible = true,
          properties = %s
        }""" % (next_id(), lua_value(o["name"]), lua_value(o["type"]), o["x"], o["y"], o["w"], o["h"],
                        lua_value(o["props"], 4)))
            return """    {
      type = "objectgroup", draworder = "topdown", id = %d, name = "%s", class = "",
      visible = true, opacity = 1, offsetx = 0, offsety = 0, parallaxx = 1, parallaxy = 1,
      properties = {},
      objects = {
%s
      }
    }""" % (lid, name, ",\n".join(items))

        coll = [dict(name="", type="", x=r[0], y=r[1], w=r[2], h=r[3], props={}) for r in self.collisions()]
        objs = []
        for o in self.objects:
            oo = dict(o)
            oo["type"] = o["type"]
            oo["name"] = o["name"] or o["type"]
            objs.append(oo)
        marks = [dict(name=k, type="", x=v[0], y=v[1], w=0, h=0, props={}) for k, v in self.markers.items()]
        props = {"name": self.name}
        if self.music:
            props["music"] = self.music
        if self.light:
            props["light"] = True
        if self.border:
            props["border"] = self.border
        props.update(self.props)
        bg = ""
        if self.bg:
            bg = "  backgroundcolor = { %d, %d, %d },\n" % self.bg
        return """-- Generado por herramientas/mapas.py
return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.12.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = %d,
  height = %d,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = %d,
%s  properties = %s,
  tilesets = {
    {
      name = "%s",
      firstgid = 1,
      filename = "%s/tilesets/%s.tsx",
      exportfilename = "%s/tilesets/%s.lua"
    }
  },
  layers = {
%s,
%s,
%s,
%s,
%s
  }
}
""" % (self.w, self.h, 9999, bg, lua_value(props, 1), self.theme,
       self._rel(), self.theme, self._rel(), self.theme,
       tilelayer("tiles", base, 1), tilelayer("decoration", deco, 2),
       objgroup("collision", coll, 3), objgroup("objects", objs, 4), objgroup("markers", marks, 5))

    def _rel(self):
        depth = self.id.count("/") + 1
        return "/".join([".."] * depth)

    def write(self, root):
        p = os.path.join(root, "scripts", "world", "maps", self.id + ".lua")
        os.makedirs(os.path.dirname(p), exist_ok=True)
        with open(p, "w", encoding="utf-8") as f:
            f.write(self.to_lua())
