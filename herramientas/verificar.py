"""Verificador estático del mod: comprueba que todas las referencias existen.
Uso: python3 herramientas/verificar.py [ruta_a_Kristal]
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
MOD = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm"))
KRISTAL = sys.argv[1] if len(sys.argv) > 1 else None
errors = []


def files(base, ext=".lua"):
    out = []
    for r, _, fs in os.walk(base):
        for f in fs:
            if f.endswith(ext):
                out.append(os.path.join(r, f))
    return out


def rel_ids(base, ext):
    ids = set()
    for f in files(base, ext):
        ids.add(os.path.relpath(f, base)[: -len(ext)].replace(os.sep, "/"))
    return ids


S = os.path.join(MOD, "scripts")
A = os.path.join(MOD, "assets")

# --- registro de ids
cutscene_funcs = {}
for f in files(os.path.join(S, "world", "cutscenes")):
    group = os.path.relpath(f, os.path.join(S, "world", "cutscenes"))[:-4]
    src = open(f, encoding="utf-8").read()
    names = set(re.findall(r"^\s{4}([a-zA-Z_0-9]+)\s*=\s*(?:function|student\()", src, re.M))
    # funciones añadidas dinámicamente (amigos del muro)
    for m in re.finditer(r'M\["amigo_" \.\. id\]', src):
        names |= {"amigo_" + x for x in re.findall(r'^\s{4}(\w+)\s*=\s*"', src, re.M)}
    cutscene_funcs[group] = names

def class_ids(path):
    ids = set()
    for f in files(path):
        src = open(f, encoding="utf-8").read()
        m = re.search(r'Class\(\w+,\s*"([^"]+)"\)', src)
        ids.add(m.group(1) if m else os.path.relpath(f, path)[:-4].replace(os.sep, "/"))
    return ids

encounters = class_ids(os.path.join(S, "battle", "encounters"))
enemies = class_ids(os.path.join(S, "battle", "enemies"))
waves = class_ids(os.path.join(S, "battle", "waves"))
actors = class_ids(os.path.join(S, "data", "actors"))
items = class_ids(os.path.join(S, "data", "items"))
spells = class_ids(os.path.join(S, "data", "spells"))
party = class_ids(os.path.join(S, "data", "party"))
maps = rel_ids(os.path.join(S, "world", "maps"), ".lua")
sprites = rel_ids(os.path.join(A, "sprites"), ".png")
sounds = rel_ids(os.path.join(A, "sounds"), ".wav") | rel_ids(os.path.join(A, "sounds"), ".ogg")
music_dirs = set()

k_items, k_sprites, k_sounds = set(), set(), set()
if KRISTAL:
    k_items = class_ids(os.path.join(KRISTAL, "data", "items"))
    k_sprites = rel_ids(os.path.join(KRISTAL, "assets", "sprites"), ".png")
    k_sounds = rel_ids(os.path.join(KRISTAL, "assets", "sounds"), ".wav") | rel_ids(os.path.join(KRISTAL, "assets", "sounds"), ".ogg")

all_items = items | k_items
all_sprites = sprites | k_sprites
all_sounds = sounds | k_sounds


def sprite_exists(path):
    if path in all_sprites:
        return True
    # animaciones: path_1, path_01
    return any(s.startswith(path + "_") for s in all_sprites)


# --- actores: retratos disponibles
actor_portrait = {}
for f in files(os.path.join(S, "data", "actors")):
    src = open(f, encoding="utf-8").read()
    m = re.search(r'Class\(Actor,\s*"([^"]+)"\)', src)
    p = re.search(r'self.portrait_path = "([^"]+)"', src)
    if m:
        actor_portrait[m.group(1)] = p.group(1) if p else None


def check_cutscene_ref(ref, where):
    if "." not in ref:
        errors.append("%s: cutscene sin grupo '%s'" % (where, ref))
        return
    g, n = ref.split(".", 1)
    if g not in cutscene_funcs:
        errors.append("%s: grupo de cutscene inexistente '%s'" % (where, ref))
    elif n not in cutscene_funcs[g]:
        errors.append("%s: cutscene inexistente '%s'" % (where, ref))


# --- mapas
for f in files(os.path.join(S, "world", "maps")):
    src = open(f, encoding="utf-8").read()
    where = os.path.relpath(f, MOD)
    for ref in re.findall(r'\["cutscene"\] = "([^"]+)"', src):
        check_cutscene_ref(ref, where)
    for ref in re.findall(r'\["encounter"\] = "([^"]+)"', src):
        if ref not in encounters:
            errors.append("%s: encounter inexistente '%s'" % (where, ref))
    for ref in re.findall(r'\["actor"\] = "([^"]+)"', src):
        if ref not in actors:
            errors.append("%s: actor inexistente '%s'" % (where, ref))
    for ref in re.findall(r'\["map"\] = "([^"]+)"', src):
        if ref not in maps:
            errors.append("%s: mapa inexistente '%s'" % (where, ref))
    for ref in re.findall(r'\["texture"\] = "([^"]+)"', src):
        if not sprite_exists(ref):
            errors.append("%s: textura inexistente '%s'" % (where, ref))
    for ref in re.findall(r'\["item"\] = "([^"]+)"', src):
        if ref not in all_items:
            errors.append("%s: objeto inexistente '%s'" % (where, ref))

# --- código Lua
for f in files(S):
    src = open(f, encoding="utf-8").read()
    where = os.path.relpath(f, MOD)
    for ref in re.findall(r'(?:startEncounter|Game:encounter)\("([^"]+)"', src):
        if ref not in encounters:
            errors.append("%s: encounter inexistente '%s'" % (where, ref))
    for ref in re.findall(r'Boss\.fight\(c,\s*"([^"]+)"', src):
        if ref not in encounters:
            errors.append("%s: encounter inexistente '%s'" % (where, ref))
    for ref in re.findall(r'(?:gotoCutscene|startCutscene)\("([^"]+)"', src):
        check_cutscene_ref(ref, where)
    for ref in re.findall(r'addEnemy\("([^"]+)"', src):
        if ref not in enemies:
            errors.append("%s: enemigo inexistente '%s'" % (where, ref))
    for ref in re.findall(r'(?:loadMap|switchPOV\(c, \{[^}]*\},)\s*\(?\s*"([^"]+)"', src):
        if ref not in maps:
            errors.append("%s: mapa inexistente '%s'" % (where, ref))
    for ref in re.findall(r'addItem\("([^"]+)"', src):
        if ref not in all_items:
            errors.append("%s: objeto inexistente '%s'" % (where, ref))
    for ref in re.findall(r'(?:addSpell)\("([^"]+)"', src):
        if ref not in spells:
            errors.append("%s: hechizo inexistente '%s'" % (where, ref))
    for ref in re.findall(r'playSound\("([^"]+)"', src):
        if ref not in all_sounds:
            errors.append("%s: sonido inexistente '%s'" % (where, ref))
    for ref in re.findall(r'(?:Sprite|setSprite|getTexture)\("([^"]+)"', src):
        if "/" in ref and not ref.endswith("_") and not ref.endswith("/") and not sprite_exists(ref):
            errors.append("%s: sprite inexistente '%s'" % (where, ref))
    for ref in re.findall(r'spawnNPC\("([^"]+)"', src):
        if ref not in actors:
            errors.append("%s: actor inexistente '%s'" % (where, ref))
    for ref in re.findall(r'setActor\("([^"]+)"', src):
        if ref not in actors:
            errors.append("%s: actor inexistente '%s'" % (where, ref))
    for ref in re.findall(r'(?:setParty)\(\{([^}]*)\}', src):
        for pid in re.findall(r'"([^"]+)"', ref):
            if pid not in party:
                errors.append("%s: miembro de equipo inexistente '%s'" % (where, pid))
    # retratos: c:text(texto, "cara", "actor")
    for face, actor in re.findall(r'c:text\([^\n]*?,\s*"(\w+)",\s*"(\w+)"', src):
        if actor in ("L", "G"):
            continue
        if actor not in actor_portrait:
            errors.append("%s: actor de diálogo inexistente '%s'" % (where, actor))
            continue
        pp = actor_portrait[actor]
        if pp and not sprite_exists(pp + "/" + face):
            errors.append("%s: retrato inexistente '%s/%s'" % (where, pp, face))
    # retratos con variables locales: c:text(..., "cara", X) con local X = "actor"
    locals_ = dict(re.findall(r'local (\w+) = "(\w+)"', src))
    for m in re.finditer(r'local (\w+), (\w+), (\w+)(?:, (\w+))? = "(\w+)", "(\w+)", "(\w+)"(?:, "(\w+)")?', src):
        names = [m.group(i) for i in (1, 2, 3, 4)]
        vals = [m.group(i) for i in (5, 6, 7, 8)]
        for n, v in zip(names, vals):
            if n and v:
                locals_[n] = v
    for face, var in re.findall(r'c:text\([^\n]*?,\s*"(\w+)",\s*([A-Z]{1,2})\)', src):
        actor = locals_.get(var)
        if not actor:
            continue
        pp = actor_portrait.get(actor)
        if pp and not sprite_exists(pp + "/" + face):
            errors.append("%s: retrato inexistente '%s/%s'" % (where, pp, face))

# --- enemigos: waves y sprites de balas
for f in files(os.path.join(S, "battle", "enemies")):
    src = open(f, encoding="utf-8").read()
    where = os.path.relpath(f, MOD)
    for blk in re.findall(r'waves = \{([^}]*)\}', src):
        for w in re.findall(r'"([^"]+)"', blk):
            if w not in waves:
                errors.append("%s: oleada inexistente '%s'" % (where, w))
    for blk in re.findall(r'(?:sprites|bullet_sprites) = \{([^}]*)\}', src):
        for b in re.findall(r'"([^"]+)"', blk):
            if not sprite_exists("bullets/" + b):
                errors.append("%s: bala inexistente '%s'" % (where, b))
    m = re.search(r'super\.init\(self, "([^"]+)"\)', src)
    if m and m.group(1) not in actors:
        errors.append("%s: actor de enemigo inexistente '%s'" % (where, m.group(1)))

# --- mod.json
import json
mj = json.load(open(os.path.join(MOD, "mod.json")))
for inv in ("lightInventory", "darkInventory"):
    for cat in mj.get(inv, {}).values():
        for it in cat:
            if it not in all_items:
                errors.append("mod.json: objeto inexistente '%s'" % it)
for who, eq in mj.get("equipment", {}).items():
    for it in [eq.get("weapon")] + eq.get("armor", []):
        if it and it not in all_items:
            errors.append("mod.json: equipo inexistente '%s'" % it)
for pid in mj.get("party", []):
    if pid not in party:
        errors.append("mod.json: equipo inexistente '%s'" % pid)
if mj.get("map") not in maps:
    errors.append("mod.json: mapa inicial inexistente")

# --- recompensas
pcdm = open(os.path.join(S, "globals", "PCDM.lua"), encoding="utf-8").read()
blk = re.search(r"PCDM.KILL_REWARDS = \{(.*?)\n\}", pcdm, re.S)
for it in re.findall(r'= "([^"]+)"', blk.group(1)):
    if it not in all_items:
        errors.append("PCDM.lua: recompensa inexistente '%s'" % it)

if errors:
    print("\n".join(sorted(set(errors))))
    print("ERRORES:", len(set(errors)))
    sys.exit(1)
print("Todo OK: %d cutscenes, %d encounters, %d enemigos, %d actores, %d mapas" % (
    sum(len(v) for v in cutscene_funcs.values()), len(encounters), len(enemies), len(actors), len(maps)))
