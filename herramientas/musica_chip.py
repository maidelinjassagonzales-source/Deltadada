"""Compone música ORIGINAL estilo chiptune para cada zona del juego.
Cada sección tiene su tempo, tonalidad, escala, acordes, bajo y batería.
Genera deltarune_pcdm/assets/music/<sección>/pcdm_<sección>.ogg (en bucle).

Uso: python3 herramientas/musica_chip.py [sección ...]
No pisa las canciones que ya haya en una carpeta (las de Drive, o las que copie
instalar_musica.py): solo rellena las secciones vacías. Con --forzar las regenera.
"""
import os
import subprocess
import sys
import tempfile
import wave
import zlib

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
MUSIC = os.path.normpath(os.path.join(HERE, "..", "deltarune_pcdm", "assets", "music"))
SR = 32000

SCALES = {
    "mayor": [0, 2, 4, 5, 7, 9, 11],
    "menor": [0, 2, 3, 5, 7, 8, 10],
    "dorica": [0, 2, 3, 5, 7, 9, 10],
    "frigia": [0, 1, 3, 5, 7, 8, 10],
    "armonica": [0, 2, 3, 5, 7, 8, 11],
    "lidia": [0, 2, 4, 6, 7, 9, 11],
    "flamenca": [0, 1, 4, 5, 7, 8, 10],
    "mixolidia": [0, 2, 4, 5, 7, 9, 10],
}

# bpm, tónica (MIDI), escala, acordes A, acordes B, pasos por compás (16 = 4/4, 12 = 6/8),
# bajo, batería, arpegio, colchón (pad), ancho de pulso de la melodía, octava de la melodía, densidad
SECCIONES = {
    "intro":            dict(bpm=70,  root=57, scale="menor",    A=[0, 5, 3, 4], B=[5, 3, 0, 4], steps=16, bass="drone", drums="nada",     arp=False, pad=True,  duty=0.5,   oct=0,  dens=0.25),
    "casa_pablo":       dict(bpm=84,  root=50, scale="dorica",   A=[0, 3, 0, 4], B=[5, 3, 6, 4], steps=16, bass="walk",  drums="shuffle",  arp=False, pad=True,  duty=0.25,  oct=0,  dens=0.45),
    "casa_lucia":       dict(bpm=112, root=60, scale="mayor",    A=[0, 5, 3, 4], B=[3, 4, 5, 4], steps=16, bass="pulse", drums="suave",    arp=True,  pad=False, duty=0.125, oct=12, dens=0.6),
    "calle":            dict(bpm=118, root=62, scale="mixolidia", A=[0, 6, 3, 0], B=[3, 4, 6, 4], steps=16, bass="walk", drums="basica",   arp=False, pad=False, duty=0.25,  oct=0,  dens=0.6),
    "instituto":        dict(bpm=104, root=65, scale="mayor",    A=[0, 3, 4, 0], B=[5, 1, 4, 4], steps=16, bass="root8", drums="basica",   arp=True,  pad=False, duty=0.25,  oct=0,  dens=0.55),
    "aula":             dict(bpm=92,  root=64, scale="dorica",   A=[0, 3, 0, 3], B=[5, 6, 3, 4], steps=16, bass="pulse", drums="escasa",   arp=False, pad=True,  duty=0.125, oct=0,  dens=0.4),
    "patio":            dict(bpm=128, root=67, scale="mayor",    A=[0, 4, 5, 3], B=[0, 4, 3, 4], steps=16, bass="root8", drums="basica",   arp=True,  pad=False, duty=0.25,  oct=0,  dens=0.65),
    "casa_andres":      dict(bpm=76,  root=52, scale="frigia",   A=[0, 1, 0, 6], B=[3, 1, 5, 0], steps=16, bass="drone", drums="escasa",   arp=True,  pad=True,  duty=0.5,   oct=0,  dens=0.35),
    "fiestas_pino":     dict(bpm=138, root=60, scale="mixolidia", A=[0, 3, 4, 0], B=[6, 3, 4, 4], steps=12, bass="pulse", drums="rumba",  arp=True,  pad=False, duty=0.25,  oct=12, dens=0.7),
    "combate_light":    dict(bpm=150, root=57, scale="menor",    A=[0, 5, 6, 4], B=[0, 3, 6, 4], steps=16, bass="gallop", drums="combate", arp=False, pad=False, duty=0.5,   oct=0,  dens=0.7),
    "caida":            dict(bpm=60,  root=62, scale="lidia",    A=[0, 1, 0, 1], B=[3, 1, 4, 0], steps=16, bass="drone", drums="nada",     arp=True,  pad=True,  duty=0.125, oct=12, dens=0.2),
    "llanuras":         dict(bpm=120, root=55, scale="dorica",   A=[0, 3, 6, 3], B=[5, 6, 3, 4], steps=16, bass="root8", drums="basica",   arp=True,  pad=False, duty=0.25,  oct=12, dens=0.6),
    "bosque":           dict(bpm=100, root=52, scale="menor",    A=[0, 5, 6, 0], B=[3, 5, 4, 4], steps=16, bass="pulse", drums="escasa",   arp=True,  pad=True,  duty=0.5,   oct=0,  dens=0.45),
    "plato":            dict(bpm=126, root=58, scale="lidia",    A=[0, 1, 0, 4], B=[3, 2, 1, 4], steps=16, bass="walk",  drums="shuffle",  arp=True,  pad=False, duty=0.25,  oct=12, dens=0.65),
    "cortijo":          dict(bpm=132, root=52, scale="flamenca", A=[0, 6, 5, 0], B=[3, 6, 5, 0], steps=12, bass="pulse", drums="rumba",    arp=True,  pad=False, duty=0.25,  oct=0,  dens=0.65),
    "muro":             dict(bpm=108, root=53, scale="menor",    A=[0, 5, 2, 4], B=[0, 6, 4, 4], steps=16, bass="root8", drums="marcha",   arp=False, pad=True,  duty=0.5,   oct=0,  dens=0.55),
    "torre_aroy":       dict(bpm=90,  root=49, scale="armonica", A=[0, 5, 1, 4], B=[0, 3, 5, 4], steps=16, bass="drone", drums="escasa",   arp=True,  pad=True,  duty=0.5,   oct=0,  dens=0.4),
    "combate":          dict(bpm=160, root=57, scale="menor",    A=[0, 0, 5, 6], B=[3, 6, 4, 4], steps=16, bass="gallop", drums="combate", arp=True,  pad=False, duty=0.5,   oct=0,  dens=0.75),
    "jefe":             dict(bpm=168, root=52, scale="armonica", A=[0, 5, 3, 4], B=[0, 1, 6, 4], steps=16, bass="gallop", drums="combate", arp=True,  pad=False, duty=0.25,  oct=0,  dens=0.8),
    "jefe_vito":        dict(bpm=150, root=59, scale="mixolidia", A=[0, 6, 3, 4], B=[0, 6, 5, 4], steps=16, bass="root8", drums="combate", arp=True,  pad=False, duty=0.25,  oct=0,  dens=0.75),
    "jefe_angelpedro":  dict(bpm=140, root=48, scale="menor",    A=[0, 0, 5, 6], B=[3, 3, 4, 4], steps=16, bass="gallop", drums="combate", arp=False, pad=True,  duty=0.5,   oct=12, dens=0.6),
    "jefe_abascal":     dict(bpm=144, root=52, scale="flamenca", A=[0, 6, 5, 0], B=[3, 6, 5, 0], steps=12, bass="gallop", drums="rumba",   arp=True,  pad=False, duty=0.5,   oct=0,  dens=0.75),
    "jefe_pablo":       dict(bpm=130, root=50, scale="dorica",   A=[0, 3, 0, 4], B=[5, 3, 6, 4], steps=16, bass="walk",   drums="shuffle", arp=True,  pad=True,  duty=0.25,  oct=0,  dens=0.7),
    "jefe_trump":       dict(bpm=152, root=53, scale="mayor",    A=[0, 3, 4, 0], B=[0, 5, 1, 4], steps=16, bass="root8",  drums="marcha",  arp=True,  pad=True,  duty=0.25,  oct=0,  dens=0.75),
    "jefe_netanyahu":   dict(bpm=158, root=55, scale="armonica", A=[0, 5, 3, 4], B=[5, 1, 4, 4], steps=16, bass="gallop", drums="combate", arp=True,  pad=False, duty=0.5,   oct=0,  dens=0.8),
    "jefe_aroy":        dict(bpm=172, root=49, scale="frigia",   A=[0, 1, 0, 6], B=[3, 1, 6, 0], steps=16, bass="gallop", drums="combate", arp=True,  pad=True,  duty=0.5,   oct=0,  dens=0.8),
    "jefe_andres":      dict(bpm=176, root=50, scale="armonica", A=[0, 3, 4, 0], B=[5, 1, 4, 4], steps=16, bass="gallop", drums="combate", arp=True,  pad=True,  duty=0.25,  oct=12, dens=0.85),
    "papa_francisco":   dict(bpm=96,  root=60, scale="mayor",    A=[0, 4, 5, 3], B=[0, 3, 4, 0], steps=16, bass="pulse", drums="suave",    arp=False, pad=True,  duty=0.5,   oct=12, dens=0.45),
    "tienda":           dict(bpm=100, root=65, scale="mayor",    A=[0, 5, 1, 4], B=[3, 2, 1, 4], steps=16, bass="walk",  drums="shuffle",  arp=False, pad=True,  duty=0.125, oct=0,  dens=0.5),
    "final_neutral":    dict(bpm=80,  root=57, scale="menor",    A=[0, 5, 2, 6], B=[3, 0, 4, 4], steps=16, bass="pulse", drums="nada",     arp=True,  pad=True,  duty=0.25,  oct=0,  dens=0.35),
    "final_verdadero":  dict(bpm=112, root=62, scale="mayor",    A=[0, 4, 5, 3], B=[3, 4, 5, 4], steps=16, bass="root8", drums="basica",   arp=True,  pad=True,  duty=0.25,  oct=12, dens=0.6),
    "final_furrygrave": dict(bpm=66,  root=53, scale="menor",    A=[0, 5, 3, 4], B=[0, 1, 0, 4], steps=16, bass="drone", drums="nada",     arp=False, pad=True,  duty=0.5,   oct=0,  dens=0.25),
    "ruta_furrygrave":  dict(bpm=58,  root=50, scale="frigia",   A=[0, 1, 0, 1], B=[0, 6, 1, 0], steps=16, bass="drone", drums="nada",     arp=True,  pad=True,  duty=0.125, oct=12, dens=0.15),
}

# ----------------------------------------------------------------- síntesis
def freq(m):
    return 440.0 * 2 ** ((m - 69) / 12.0)


def env(n, a=0.005, d=0.08, s=0.6, r=0.05):
    e = np.ones(n) * s
    na, nd, nr = int(a * SR), int(d * SR), int(r * SR)
    na = min(na, n)
    e[:na] = np.linspace(0, 1, na, endpoint=False) if na else e[:na]
    nd = min(nd, n - na)
    if nd > 0:
        e[na:na + nd] = np.linspace(1, s, nd, endpoint=False)
    nr = min(nr, n)
    if nr > 0:
        e[n - nr:] *= np.linspace(1, 0, nr)
    return e


def pulse(f, n, duty):
    ph = (np.arange(n) * f / SR) % 1.0
    return np.where(ph < duty, 1.0, -1.0)


def tri(f, n):
    ph = (np.arange(n) * f / SR) % 1.0
    return 2 * np.abs(2 * ph - 1) - 1


def noise(n, rate=SR):
    hold = max(1, SR // rate)
    base = np.random.RandomState(n).uniform(-1, 1, n // hold + 2)
    return np.repeat(base, hold)[:n]


def kick(n):
    t = np.arange(n) / SR
    f = 120 * np.exp(-t * 30) + 45
    ph = np.cumsum(f) / SR
    return np.sin(2 * np.pi * ph) * np.exp(-t * 18)


def snare(n):
    t = np.arange(n) / SR
    return (noise(n, 16000) * 0.8 + np.sin(2 * np.pi * 190 * t) * 0.3) * np.exp(-t * 22)


def hat(n):
    t = np.arange(n) / SR
    return noise(n, SR) * np.exp(-t * 90)


def clap(n):
    t = np.arange(n) / SR
    e = np.exp(-t * 40) + 0.5 * np.exp(-np.maximum(t - 0.012, 0) * 40) * (t > 0.012)
    return noise(n, 12000) * e * 0.6


# ----------------------------------------------------------------- composición
class Song:
    def __init__(self, name, spec):
        self.name = name
        self.s = spec
        self.rng = np.random.RandomState(zlib.crc32(name.encode()))  # siempre la misma canción
        self.scale = SCALES[spec["scale"]]
        # un paso = una semicorchea (16 pasos = 4/4; 12 pasos = 6/8)
        self.step = 60.0 / spec["bpm"] / 4
        self.bars = spec["A"] * 2 + spec["B"] * 2   # 16 compases
        self.nsteps = len(self.bars) * spec["steps"]
        self.n = int(self.nsteps * self.step * SR)
        self.tail = int(SR * 1.0)
        self.buf = {k: np.zeros(self.n + self.tail) for k in ("lead", "arp", "bass", "drums", "pad")}

    def degree(self, d, octave=0):
        o, i = divmod(d, 7)
        return self.s["root"] + self.scale[i] + 12 * (o + octave)

    def chord(self, d):
        return [self.degree(d), self.degree(d + 2), self.degree(d + 4)]

    def put(self, ch, step, length_steps, wavefn, vol):
        i0 = int(step * self.step * SR)
        n = max(32, int(length_steps * self.step * SR))
        self.buf[ch][i0:i0 + n] += wavefn(n) * vol

    # --- melodía: motivos de 2 compases que se repiten y varían
    def melody(self):
        st = self.s["steps"]
        dens = self.s["dens"]
        motifs = []
        for _ in range(3):
            rhythm = []
            for k in range(st * 2):
                strong = (k % (st // 4 if st == 16 else 3)) == 0
                p = dens * (1.4 if strong else 0.6)
                rhythm.append(self.rng.rand() < p)
            rhythm[0] = True
            moves = [int(m) for m in self.rng.choice([-2, -1, -1, 0, 1, 1, 2, 3, -3], st * 2)]
            motifs.append((rhythm, moves))
        plan = [0, 0, 1, 2, 0, 0, 1, 2]   # forma de la frase (en pares de compases)
        cur = 7
        for b in range(0, len(self.bars), 2):
            rhythm, moves = motifs[plan[(b // 2) % len(plan)]]
            last_pair = (b // 2) % 4 == 3
            for k in range(st * 2):
                if not rhythm[k]:
                    continue
                bar = b + k // st
                deg = self.bars[bar]
                tones = [deg, deg + 2, deg + 4, deg + 7]
                cur += moves[k]
                strong = (k % st) in (0, st // 2)
                if strong:
                    cur = min(tones, key=lambda t: abs(t - cur))
                cur = max(3, min(13, cur))
                ln = 1
                while k + ln < st * 2 and not rhythm[k + ln] and ln < 4:
                    ln += 1
                if last_pair and k >= st * 2 - 4:
                    cur = 7 if k == st * 2 - 4 else cur
                m = self.degree(cur, octave=0) + self.s["oct"]
                f = freq(m)
                duty = self.s["duty"]
                self.put("lead", b * st + k, ln * 0.9,
                         lambda n, f=f, duty=duty: pulse(f, n, duty) * env(n, 0.004, 0.06, 0.55, 0.03), 1.0)

    def bassline(self):
        st = self.s["steps"]
        style = self.s["bass"]
        for b, deg in enumerate(self.bars):
            root = self.degree(deg, octave=-2)
            fifth = self.degree(deg + 4, octave=-2)
            third = self.degree(deg + 2, octave=-2)
            if style == "drone":
                notes = [(0, st, root)]
            elif style == "root8":
                notes = [(k, 2, root if k % 4 == 0 else root + (12 if k % 8 == 6 else 0)) for k in range(0, st, 2)]
            elif style == "pulse":
                notes = [(k, 3, root if (k // (st // 4)) % 2 == 0 else fifth) for k in range(0, st, st // 4)]
            elif style == "walk":
                seq = [root, third, fifth, root + 12] if st == 16 else [root, fifth, root + 12]
                notes = [(i * (st // len(seq)), st // len(seq), m) for i, m in enumerate(seq)]
            else:  # gallop (combates)
                notes = []
                for k in range(0, st, 4):
                    m = root if k < st // 2 else (fifth if b % 2 else root + 12)
                    notes += [(k, 1, m), (k + 1, 1, m), (k + 2, 2, m)]
            for k, ln, m in notes:
                f = freq(m)
                self.put("bass", b * st + k, ln * 0.95, lambda n, f=f: tri(f, n) * env(n, 0.003, 0.05, 0.8, 0.02), 1.0)

    def harmony(self):
        st = self.s["steps"]
        for b, deg in enumerate(self.bars):
            ch = self.chord(deg)
            if self.s["arp"]:
                order = ch + [ch[1] + 12, ch[0] + 12, ch[2]]
                for k in range(st):
                    m = order[k % len(order)] + 12
                    f = freq(m)
                    self.put("arp", b * st + k, 0.9, lambda n, f=f: pulse(f, n, 0.125) * env(n, 0.002, 0.04, 0.3, 0.02), 1.0)
            if self.s["pad"]:
                for m in ch:
                    f = freq(m)
                    self.put("pad", b * st, st, lambda n, f=f: (tri(f, n) * 0.7 + pulse(f * 1.003, n, 0.5) * 0.3) * env(n, 0.25, 0.4, 0.7, 0.3), 1.0)

    def drumline(self):
        st = self.s["steps"]
        style = self.s["drums"]
        if style == "nada":
            return
        for b in range(len(self.bars)):
            hits = []
            if style == "basica":
                hits = [(0, "k"), (st // 2, "k"), (st // 4, "s"), (3 * st // 4, "s")] + [(k, "h") for k in range(0, st, 2)]
            elif style == "suave":
                hits = [(0, "k"), (st // 2, "s")] + [(k, "h") for k in range(0, st, 4)]
            elif style == "escasa":
                hits = [(0, "k")] + ([(st // 2 + 2, "h")] if b % 2 else [])
            elif style == "shuffle":
                hits = [(0, "k"), (10, "k"), (4, "s"), (12, "s")] + [(k, "h") for k in (0, 3, 4, 7, 8, 11, 12, 15)]
            elif style == "combate":
                hits = [(k, "k") for k in (0, 6, 8, 11)] + [(4, "s"), (12, "s")] + [(k, "h") for k in range(st)]
                if b % 4 == 3:
                    hits += [(k, "s") for k in (13, 14, 15)]
            elif style == "marcha":
                hits = [(0, "k"), (8, "k"), (4, "s"), (12, "s"), (14, "s"), (15, "s")] + [(k, "h") for k in range(0, st, 2)]
            elif style == "rumba":   # 6/8 con palmas
                hits = [(0, "k"), (6, "k")] + [(k, "c") for k in (2, 4, 7, 9, 11)] + [(k, "h") for k in range(0, st, 2)]
            for k, kind in hits:
                if k >= st:
                    continue
                fn, vol, ln = {"k": (kick, 1.0, 3), "s": (snare, 0.7, 2), "h": (hat, 0.25, 1), "c": (clap, 0.8, 2)}[kind]
                self.put("drums", b * st + k, ln, fn, vol)

    def render(self):
        self.melody()
        self.bassline()
        self.harmony()
        self.drumline()
        mix = (self.buf["lead"] * 0.20 + self.buf["arp"] * 0.07 + self.buf["bass"] * 0.30 +
               self.buf["drums"] * 0.32 + self.buf["pad"] * 0.06)
        # bucle sin cortes: la cola del final se suma al principio
        out = mix[:self.n].copy()
        out[:self.tail] += mix[self.n:self.n + self.tail]
        peak = np.max(np.abs(out)) or 1
        return (out / peak * 0.85 * 32767).astype(np.int16)


def write_ogg(samples, path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as tmp:
        wav = tmp.name
    with wave.open(wav, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(samples.tobytes())
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", wav, "-c:a", "libvorbis", "-q:a", "3", path], check=True)
    os.remove(wav)


def has_audio(d):
    return os.path.isdir(d) and any(f.lower().endswith((".ogg", ".mp3", ".wav", ".flac")) for f in os.listdir(d))


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    force = "--forzar" in sys.argv
    for name, spec in SECCIONES.items():
        if args and name not in args:
            continue
        d = os.path.join(MUSIC, name)
        target = os.path.join(d, "pcdm_%s.ogg" % name)
        if has_audio(d) and not (force and os.path.exists(target)):
            print("  %-17s (ya tiene música, no se toca)" % name)
            continue
        song = Song(name, spec)
        write_ogg(song.render(), target)
        print("  %-17s %3d bpm %-9s %5.1fs" % (name, spec["bpm"], spec["scale"], song.n / SR))


if __name__ == "__main__":
    main()
