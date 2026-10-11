"""Fichas de personajes: aspecto de cada uno (Light World y Dark World).

En el Dark World ("dark") todos ganan orejitas y cola de animal.
"""

FICHAS = {
    # ------------------------------------------------------------------ BANDO BUENO
    "lucia": dict(
        name="Lucía", skin="claro", hair="4a2f2a", hair_style="messy", eye_color="3a2340",
        outfit=dict(top="b48cd8", hood=True, bottom="3b3b4f", legs="3b3b4f", shoes="f0f0f0"),
        lw_tail=True, tail="fox", tail_color="f0954a", tail_tip="ffffff",
        dark=dict(ears="fox", ear_color="f0954a", tail="fox", tail_color="f0954a", tail_tip="ffffff"),
        outfit_dark=dict(top="7d4fb3", hood=True, bottom="2a2440", legs="2a2440", shoes="f0954a", cape="f0954a"),
        weapon="paw", magic_color="ff7ad9", battle_item="bottle",
        exprs=["neutral", "happy", "smile", "sad", "surprised", "angry", "blush", "crying", "scared", "closed"],
    ),
    "yerover": dict(
        name="Yerover", skin="rosado", hair="f2d16b", hair_style="ponytail_long",
        hat="cap", hat_color="d12f2f",
        outfit=dict(top="ffffff", vest="d12f2f", bottom="3d5fa8", legs="3d5fa8", shoes="2b2b2b"),
        dark=dict(ears="cat", ear_color="f2d16b", tail="cat", tail_color="f2d16b"),
        outfit_dark=dict(top="f4f4f4", vest="b5121b", bottom="263f7a", legs="263f7a", shoes="ffd23f"),
        weapon="fist", magic_color="ffd23f", build="slim",
        exprs=["neutral", "happy", "grin", "smug", "surprised", "angry", "blush", "sad"],
    ),
    "gabriel": dict(
        name="Gabriel", skin="claro", hair="7b3fa0", hair_style="messy",
        outfit=dict(top="4b2a6b", hood=True, bottom="23233a", legs="23233a", shoes="111111", logo="star", logo_color="e7c2ff"),
        dark=dict(ears="dragon", ear_color="9b59b6", tail="dragon", tail_color="9b59b6"),
        outfit_dark=dict(top="5c2d84", jacket="2c2c3c", bottom="1b1b2b", legs="1b1b2b", shoes="111111"),
        weapon="axe", magic_color="d94cff",
        exprs=["neutral", "grin", "smug", "angry", "shout", "surprised", "happy", "sad", "annoyed"],
    ),
    "isra": dict(
        name="Isra", skin="oliva", hair="2a1d16", hair_style="curly", beard="stubble",
        outfit=dict(top="2f6fd6", bottom="3a3a3a", legs="3a3a3a", shoes="ffffff", logo="stripe", logo_color="ffffff"),
        item="can",
        dark=dict(ears="bear", ear_color="6b4a2b", tail="bear", tail_tip="6b4a2b"),
        outfit_dark=dict(top="1f4fb0", bottom="2a2a2a", legs="2a2a2a", shoes="ffffff", cape="ffffff", logo="star", logo_color="ffffff"),
        weapon="bottle", magic_color="5ab4ff",
        exprs=["neutral", "happy", "grin", "sad", "surprised", "closed", "angry", "blush"],
    ),
    "angel": dict(
        name="Ángel", skin="moreno", hair="1b120e", hair_style="long", height="tall", eye_color="2a1a14",
        outfit=dict(top="ff9ccf", hood=True, bottom="1b1b1b", skirt="1b1b1b", legs="ffffff", socks="ff9ccf", socks2="ffffff", shoes="ff5fa2"),
        dark=dict(ears="cat", ear_color="ff9ccf", ear_inner="ffffff", tail="cat", tail_color="ff9ccf"),
        outfit_dark=dict(top="ff7ab8", hood=True, bottom="111111", skirt="111111", legs="ffffff", socks="ff7ab8", socks2="ffffff", shoes="ff5fa2"),
        weapon="fan", magic_color="ff7ab8",
        exprs=["neutral", "happy", "smile", "blush", "surprised", "sad", "angry", "smug", "crying"],
    ),
    "alejandro": dict(
        name="Alejandro", skin="moreno", hair="24160f", hair_style="side",
        outfit=dict(top="f2f2f2", tie="2fa04a", bottom="2b2b2b", legs="2b2b2b", shoes="3a2a2a"),
        dark=dict(ears="jackal", ear_color="c99a5b", tail="jackal", tail_color="c99a5b", tail_tip="2a2a2a"),
        outfit_dark=dict(top="e8e8e8", tie="2fa04a", jacket="3b3b5b", bottom="222222", legs="222222", shoes="2fa04a"),
        weapon="keyboard", magic_color="7dff9b",
        exprs=["neutral", "happy", "smile", "blush", "surprised", "smug", "angry", "sad"],
    ),
    "carmen": dict(
        name="Carmen", skin="claro", hair="a33a22", hair_style="witch", hat="witch", hat_color="1d1626", tall_hat=True,
        outfit=dict(top="2b2036", bottom="2b2036", skirt="3b2a4e", legs="1d1626", shoes="5b2b6b"),
        item="cards",
        dark=dict(ears="cat", ear_color="1d1626", ear_inner="8e3fbf", tail="cat", tail_color="1d1626"),
        outfit_dark=dict(top="3a1f52", bottom="3a1f52", skirt="5b2b80", legs="1d1626", shoes="8e3fbf"),
        weapon="wand", magic_color="c77dff",
        exprs=["neutral", "smug", "happy", "surprised", "sad", "angry", "closed", "grin"],
    ),
    "david": dict(
        name="David", skin="claro", hair="6b4426", hair_style="short", hat="bowler", hat_color="1a1a1a",
        outfit=dict(top="f2f2f2", jacket="1a1a1a", tie="b5121b", bottom="1a1a1a", legs="1a1a1a", shoes="1a1a1a"),
        dark=dict(ears="raccoon", ear_color="7a7a7a", tail="raccoon", tail_color="8a8a8a", tail_tip="2a2a2a"),
        outfit_dark=dict(top="eaeaea", jacket="2a2a3a", tie="b5121b", bottom="1a1a1a", legs="1a1a1a", shoes="b5121b"),
        weapon="ukulele", magic_color="ff4f4f",
        exprs=["neutral", "smile", "happy", "surprised", "sad", "scared", "blush", "annoyed"],
    ),
    "julio": dict(
        name="Julio", skin="marron", hair="141010", hair_style="long",
        outfit=dict(top="2e6fd8", bottom="2a2a2a", legs="2a2a2a", shoes="d12f2f", logo="1", logo_color="ffd23f"),
        item="train",
        dark=dict(ears="dog", ear_color="2e6fd8", tail="dog", tail_color="2e6fd8", hat="chimney"),
        outfit_dark=dict(top="2e6fd8", bottom="1a1a1a", legs="1a1a1a", shoes="d12f2f", logo="1", logo_color="ffd23f", stripe="d12f2f"),
        weapon="whistle", magic_color="7ab8ff",
        exprs=["neutral", "happy", "grin", "sad", "surprised", "blush", "crying", "angry"],
    ),
    "xibin": dict(
        name="Xibin", skin="claro", hair="0f0f12", hair_style="slick", glasses="sun", aura=True,
        outfit=dict(top="1d2340", jacket="1d2340", tie="c9a227", bottom="1d2340", legs="1d2340", shoes="0f0f0f", logo="chain", logo_color="f5cd30"),
        item="briefcase",
        dark=dict(ears="dragon", ear_color="f5cd30", tail="dragon", tail_color="c9a227"),
        weapon="briefcase", magic_color="f5cd30",
        exprs=["neutral", "smug", "grin", "smile", "surprised", "annoyed", "closed", "happy"],
    ),
    # ------------------------------------------------------------------ BANDO MALO
    "pablo": dict(
        name="Pablo", skin="palido", hair="3b3226", hair_style="long", acne=True,
        outfit=dict(top="6b6b6b", hood=True, bottom="2b2b3b", legs="2b2b3b", shoes="4a4a4a"),
        item="phone",
        dark=dict(ears="rat", ear_color="b0a49a", ear_inner="f7a1b8", tail="rat", tail_color="f2a8b0"),
        weapon="phone", magic_color="8fd3ff",
        exprs=["neutral", "smug", "grin", "angry", "shout", "sad", "surprised", "blush", "crying"],
    ),
    "dayron": dict(
        name="Dayron", skin="claro", hair="4b3221", hair_style="curly", glasses="normal",
        outfit=dict(top="a8322d", bottom="34465f", legs="34465f", shoes="ffffff"),
        dark=dict(ears="dog", ear_color="e0b35a", tail="dog", tail_color="e0b35a"),
        outfit_dark=dict(top="8a1f1a", jacket="2a2a2a", bottom="2a3a50", legs="2a3a50", shoes="ffffff"),
        weapon="sticker", magic_color="ff5555",
        exprs=["neutral", "smug", "grin", "angry", "shout", "sad", "surprised", "happy", "crying"],
    ),
    "angelpedro": dict(
        name="Angel Pedro", skin="claro", hair="0d0d10", hair_style="long", height="tall",
        outfit=dict(top="f2c12e", bottom="1a3a8a", legs="1a3a8a", shoes="ffffff", logo="stripe", logo_color="1a3a8a"),
        item="chairleg",
        dark=dict(ears="bull", tail="bull", tail_color="0d0d10"),
        weapon="chair", magic_color="f2c12e",
        exprs=["neutral", "happy", "surprised", "sad", "angry", "closed", "grin"],
    ),
    "andres": dict(
        name="Andrés", skin="claro", hair="5a3b22", hair_style="side",
        outfit=dict(top="2f4f3f", bottom="383838", legs="383838", shoes="1d1d1d"),
        item="scissors",
        dark=dict(ears="wolf", ear_color="2a2a2e", tail="wolf", tail_color="2a2a2e", tail_tip="7a0000"),
        outfit_dark=dict(top="3a3a46", jacket="1d1d26", bottom="1d1d26", legs="1d1d26", shoes="7a0000", cape="7a0000"),
        weapon="scissors", magic_color="ff2a2a",
        exprs=["neutral", "smile", "smug", "angry", "shout", "sad", "blush", "scared", "grin", "dead"],
    ),
    "aridai": dict(
        name="Aridai", skin="claro", hair="2d2d2d", hair_style="bob", hat="headset", hat_color="2b2b2b",
        outfit=dict(top="b7e4ff", hood=True, bottom="ffffff", skirt="ffffff", legs="ffffff", socks="b7e4ff", socks2="ffffff", shoes="b7e4ff"),
        dark=dict(ears="bunny", ear_color="ffffff", tail="bunny", tail_tip="ffffff"),
        exprs=["neutral", "surprised", "blush", "smile", "scared"],
    ),
    # ------------------------------------------------------------------ AROY.EXE
    "aroy": dict(
        name="Aroy.exe", skin="palido", hair="0a0a0a", hair_style="slick", height="tall", blood_tears=True,
        outfit=dict(top="0a0a0a", robe=True, bottom="0a0a0a", shoes="0a0a0a"),
        dark=dict(),
        exprs=["neutral", "angry", "shout", "smug", "grin", "happy", "surprised", "dead"],
    ),
    # ------------------------------------------------------------------ PERSONAJES NUEVOS (hispanos)
    "fernanda": dict(
        name="Fernanda", skin="medio", hair="2a1a12", hair_style="ponytail_long",
        outfit=dict(top="2fa04a", bottom="ffffff", legs="3a3a6a", shoes="d12f2f"),
        dark=dict(ears="fox", ear_color="d98a3a", tail="fox", tail_color="d98a3a", tail_tip="ffffff"),
        exprs=["neutral", "happy", "grin", "surprised", "angry", "smug"],
    ),
    "brayan": dict(
        name="Brayan", skin="medio", hair="e8d36a", hair_style="buzz",
        outfit=dict(top="f2d21b", bottom="1a3a8a", legs="1a3a8a", shoes="ffffff", logo="chain", logo_color="f5cd30"),
        dark=dict(ears="dog", ear_color="e8d36a", tail="dog", tail_color="e8d36a"),
        exprs=["neutral", "grin", "happy", "surprised", "smug"],
    ),
    "profe": dict(
        name="Profe Mari Carmen", skin="claro", hair="9a9a9a", hair_style="bob", glasses="normal",
        outfit=dict(top="7a4a6a", bottom="3a3a3a", skirt="3a3a3a", legs="d9c8b8", shoes="3a2a2a"),
        exprs=["neutral", "annoyed", "angry", "surprised", "smile"],
    ),
    "paco": dict(
        name="Paco el Guagüero", skin="medio", hair="3a2a20", hair_style="short", beard="mustache",
        hat="cap", hat_color="1e5bb8",
        outfit=dict(top="1e5bb8", bottom="1d2a4a", legs="1d2a4a", shoes="111111"),
        dark=dict(ears="dog", ear_color="3a2a20", tail="dog", tail_color="3a2a20"),
        exprs=["neutral", "happy", "grin", "surprised"],
    ),
    "candelaria": dict(
        name="Doña Candelaria", skin="medio", hair="d9d9d9", hair_style="bun",
        outfit=dict(top="2a2a2a", bottom="2a2a2a", skirt="2a2a2a", legs="2a2a2a", shoes="111111"),
        dark=dict(ears="cat", ear_color="d9d9d9", tail="cat", tail_color="d9d9d9"),
        exprs=["neutral", "happy", "angry", "surprised"],
    ),
    # ------------------------------------------------------------------ FAMOSOS (parodias, Darkners)
    "trump": dict(
        name="Donald Trump", skin="naranja", hair="f2d16b", hair_style="side", build="wide",
        outfit=dict(top="ffffff", jacket="1d2340", tie="d12f2f", bottom="1d2340", legs="1d2340", shoes="111111"),
        dark=dict(ears="rat", ear_color="f2d16b", tail="rat", tail_color="f0954a"),
        exprs=["neutral", "angry", "shout", "smug", "sad", "surprised", "dead"],
    ),
    "netanyahu": dict(
        name="Netanyahu", skin="claro", hair="cfcfcf", hair_style="side", build="wide",
        outfit=dict(top="ffffff", jacket="2a2f3a", tie="1f4fb0", bottom="2a2f3a", legs="2a2f3a", shoes="111111"),
        dark=dict(ears="wolf", ear_color="cfcfcf", tail="wolf", tail_color="cfcfcf"),
        exprs=["neutral", "angry", "shout", "smug", "dead"],
    ),
    "abascal": dict(
        name="Santiago Abascal", skin="claro", hair="2a2a2a", hair_style="buzz", beard="full", beard_color="2a2a2a", build="wide",
        outfit=dict(top="4f8a2f", jacket="2f5a1f", bottom="2f2f2f", legs="2f2f2f", shoes="3a2a1a"),
        dark=dict(ears="bull", tail="bull", tail_color="2a2a2a"),
        exprs=["neutral", "angry", "shout", "smug", "sad", "dead"],
    ),
    "vito": dict(
        name="Vito Quiles", skin="claro", hair="2a1d14", hair_style="slick",
        outfit=dict(top="dfe6f0", jacket="3a4a6a", bottom="2a2a3a", legs="2a2a3a", shoes="111111"),
        item="mic",
        dark=dict(ears="rat", ear_color="2a1d14", tail="rat", tail_color="f2a8b0"),
        weapon="mic",
        exprs=["neutral", "grin", "shout", "smug", "surprised", "dead"],
    ),
    "motos": dict(
        name="Pablo Motos", skin="claro", hair="7a6a5a", hair_style="short",
        outfit=dict(top="2a2a2a", jacket="1a1a1a", bottom="1a1a1a", legs="1a1a1a", shoes="111111"),
        dark=dict(ears="rat", ear_color="7a6a5a", tail="rat", tail_color="f2a8b0"),
        exprs=["neutral", "grin", "shout", "smug", "angry", "dead"],
    ),
    "sanchez": dict(
        name="Pedro Sánchez", skin="medio", hair="2a2018", hair_style="side", height="tall",
        outfit=dict(top="ffffff", jacket="3a3f4a", bottom="3a3f4a", legs="3a3f4a", shoes="111111"),
        dark=dict(ears="wolf", ear_color="2a2018", tail="wolf", tail_color="2a2018"),
        exprs=["neutral", "smile", "smug", "happy", "surprised"],
    ),
    "mamdani": dict(
        name="Zohran Mamdani", skin="moreno", hair="1a1210", hair_style="short", beard="stubble",
        outfit=dict(top="ffffff", jacket="23324a", tie="3a5aa0", bottom="23324a", legs="23324a", shoes="111111"),
        dark=dict(ears="cat", ear_color="1a1210", tail="cat", tail_color="1a1210"),
        exprs=["neutral", "smile", "happy", "grin", "surprised"],
    ),
    "iglesias": dict(
        name="Pablo Iglesias", skin="claro", hair="2a1a12", hair_style="ponytail", beard="stubble",
        outfit=dict(top="7a2a3a", bottom="2a3a5a", legs="2a3a5a", shoes="1a1a1a"),
        dark=dict(ears="wolf", ear_color="2a1a12", tail="wolf", tail_color="2a1a12"),
        exprs=["neutral", "smile", "smug", "angry", "happy"],
    ),
    "yolanda": dict(
        name="Yolanda Díaz", skin="claro", hair="e8c87a", hair_style="bob",
        outfit=dict(top="d84a8a", jacket="ffffff", bottom="2a2a3a", legs="2a2a3a", shoes="d84a8a"),
        dark=dict(ears="fox", ear_color="e8c87a", tail="fox", tail_color="e8c87a", tail_tip="ffffff"),
        exprs=["neutral", "smile", "happy", "surprised"],
    ),
    "panavi": dict(
        name="El Pana Vi", skin="moreno", hair="141010", hair_style="curly",
        outfit=dict(top="ffd23f", bottom="1e5bb8", legs="1e5bb8", shoes="d12f2f", logo="star", logo_color="1e5bb8"),
        dark=dict(ears="bear", ear_color="141010", tail="bear", tail_tip="141010"),
        exprs=["neutral", "happy", "grin", "surprised"],
    ),
    "borja": dict(
        name="Borja Iglesias", skin="claro", hair="3a2a20", hair_style="long", beard="full", beard_color="3a2a20", height="tall",
        outfit=dict(top="2fa04a", bottom="ffffff", legs="ffffff", shoes="111111", logo="stripe", logo_color="ffffff"),
        dark=dict(ears="panda", ear_color="1a1a1a", tail="panda", tail_tip="ffffff"),
        exprs=["neutral", "smile", "happy", "grin"],
    ),
    "bellerin": dict(
        name="Héctor Bellerín", skin="medio", hair="1a1210", hair_style="long", beard="stubble",
        outfit=dict(top="c9a27a", jacket="6a4a3a", bottom="3a3a3a", legs="3a3a3a", shoes="ffffff"),
        dark=dict(ears="fox", ear_color="1a1210", tail="fox", tail_color="1a1210", tail_tip="ffffff"),
        exprs=["neutral", "smile", "happy", "smug"],
    ),
    "papa": dict(
        name="Papa Francisco", skin="claro", hair="e8e8e8", hair_style="short", glasses="normal", hat="zucchetto",
        outfit=dict(top="ffffff", robe=True, bottom="ffffff", shoes="2a2a2a", logo="cross", logo_color="c9a227"),
        dark=dict(),
        exprs=["neutral", "smile", "happy", "angry", "closed"],
    ),
    "flowerman": dict(
        name="Flower Man", skin="medio", hair="ff5fa2", hair_style="curly",
        outfit=dict(top="2fa04a", bottom="2fa04a", legs="2fa04a", shoes="2fa04a"),
        dark=dict(),
        exprs=["neutral", "happy"],
    ),
}

# Party jugable (con sprites de combate)
PARTY = ["lucia", "yerover", "gabriel", "isra", "angel", "alejandro", "carmen", "david", "julio", "xibin", "dayron"]

# Personajes que también luchan como jefes (sprite de combate mirando a la izquierda)
BOSSES = ["pablo", "dayron", "angelpedro", "andres", "trump", "netanyahu", "abascal", "vito", "motos", "gabriel",
          "yerover", "angel", "alejandro", "isra", "carmen", "david", "julio", "xibin", "lucia"]
