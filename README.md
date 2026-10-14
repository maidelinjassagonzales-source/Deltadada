# DELTARUNE PCDM — Capítulo 1: ¡SAL DEL ARMARIO!

Mod de **DELTARUNE + UNDERTALE** unidos, hecho para **[Kristal](https://github.com/KristalTeam/Kristal)**
(el motor de mods de DELTARUNE). No es un juego aparte: usa los menús, el TP, las magias, el ACTUAR
y el PERDONAR de DELTARUNE, y en el Mundo Claro los combates son al estilo UNDERTALE
(LUCHAR / ACTUAR / OBJETO / PIEDAD, con el alma roja en la caja).

Todos los sprites, retratos, enemigos, balas, mapas y efectos de sonido son **originales**, dibujados
píxel a píxel con los scripts de `herramientas/`.

> ⚠️ Humor muy bruto, lenguaje malsonante y parodia política. Es una broma entre amigos.

---

## 🎮 Jugar YA (sin instalar nada)

**Windows:** descarga [DeltarunePCDM-Windows.zip](https://github.com/maidelinjassagonzales-source/Deltadada/raw/refs/heads/claude/deltarune-undertale-mod-h21jsh/descargas/DeltarunePCDM-Windows.zip),
descomprímelo y haz doble clic en **`DeltarunePCDM.exe`**. En el menú, *Start game*.
Si Windows dice "Windows protegió su PC": *Más información* → *Ejecutar de todas formas*
(sale porque el .exe no está firmado).

**Mac / Linux / Android:** instala [LÖVE 11.5](https://love2d.org) y abre
[DeltarunePCDM.love](https://github.com/maidelinjassagonzales-source/Deltadada/raw/refs/heads/claude/deltarune-undertale-mod-h21jsh/descargas/DeltarunePCDM.love) con él.

Ya lleva dentro el motor (Kristal), el mod y la música. **F4** o **Alt+Enter**: pantalla completa.

---

## Instalación como mod de Kristal (para quien ya use Kristal)

1. Descarga Kristal: <https://github.com/KristalTeam/Kristal/releases> (o el código fuente y
   [LÖVE 11.5](https://love2d.org)).
2. Abre Kristal una vez y pulsa **"Open mods folder"** en el menú (en Windows suele ser
   `%APPDATA%\kristal\mods`).
3. Copia la carpeta **`deltarune_pcdm`** de este repositorio dentro de esa carpeta `mods`.
4. Abre Kristal y elige **DELTARUNE PCDM**.

### Música

Ya vienen incluidas las canciones de la carpeta de Drive `deltarunekdadas`:

| Canción | Dónde suena |
|---|---|
| `assets/music/aroy/aroy_habla.mp3` | Cada vez que habla Aroy.exe |
| `assets/music/jefe_gabriel/gabriel.mp3` | La pelea contra Gabriel |
| `assets/music/jefe_motos/pablo_motos_revert.ogg` | La pelea contra Pablo Motos: ya viene **invertida** y el mod la pone **slowed** al reproducirla |
| `assets/sounds/Dayron.ogg` | De fondo en la pelea Gabriel vs Dayron, con eco, reverb y distorsión que van cambiando |

El resto de partes del juego busca su canción en `deltarune_pcdm/assets/music/<sección>/`, y si no hay
nada usa la que trae Kristal. Para meter la música de **DELTARUNE y UNDERTALE** desde tus juegos
instalados:

```
python3 herramientas/instalar_musica.py --deltarune "RUTA/A/DELTARUNE" --undertale "RUTA/A/Undertale"
```

La lista de secciones está en `deltarune_pcdm/assets/music/LEEME.txt`.

### Controles

| Tecla | Acción |
|---|---|
| Flechas | Moverse / elegir |
| Z o Enter | Aceptar / hablar |
| X o Shift | Cancelar / correr |
| C o Ctrl | Menú |

---

## La historia

**Mundo Claro (estilo UNDERTALE).** Empieza con Aroy.exe hablándote directamente. Luego vas saltando
de punto de vista entre personajes: Pablo y sus bots de Instagram, Lucía despertándose, la calle,
el pasillo del instituto (el tarot de Carmen y el **¡¡¡MOMENTO INCÓMODO!!!** de Xibin), la clase
donde Pablo suelta *"atrévete, te, te, sal del clóset"*… y acaba metido en el armario, el patio con
Gabriel contra Dayron, la casa de Andrés (y lo que esconde) e Isra en las Fiestas del Pino.
Los pensamientos entre paréntesis dejan caer de qué bando es cada uno.

**Mundo Oscuro (estilo DELTARUNE).** Al abrir el armario del aula caéis al Dark World: todos con orejas
y cola. Llanuras del Armario → Bosque de Tijeras → Plató del Hormiguero → Cortijo de la Reconquista →
El Muro → Torre de Aroy.exe. Solo se controla al **bando bueno**; el equipo va cambiando por escenas.
Las **Guaguas Global** están fuera de servicio hasta casi el final: cuando el grupo se reúne en
**El Muro**, Zohran Mamdani consigue el presupuesto y desde cualquier parada puedes volver a las zonas
que ya has visitado.

### Equipo y magias (TP)

| Personaje | Magias |
|---|---|
| Lucía | FurryShock, Abrazo Furro, **FURRYGRAVE** |
| Yerover | Power Geyser, Buster Wolf (main Terry) |
| Gabriel | Retramonguer Buster, Cura Mierdera, Discurso Retra |
| Isra | Chupito, Cúpula de Hierro, Capitán Israel |
| Ángel | Beca Universal, Zuzu, Expropiación |
| Alejandro | JakoSherry, Canon Kralsei, Hidden in the Sand |
| Carmen | Tirada de Tarot, Profecía |
| David | Riff de Will Wood, Indie Desconocido, Ruta de Tally Hall |
| Julio | CHU-CHU, Arepazo, Thomas y sus Amigos |
| Xibin | Rizz, Gacha Hoyoverse, Momento Incómodo |

### Rutas y finales

- **Final neutral** — perdonas (ACTUAR / PIEDAD) a algún jefe del bando malo. Todos vuelven al
  Mundo Claro… y les da pena volver.
- **Final verdadero** — matas a **todo** el bando malo: Pablo, Angel Pedro, Vito Quiles,
  Pablo Motos (y luego a Trancas y Barrancas, que vienen a vengarle), Abascal, Trump
  (y luego a Netanyahu, que viene a vengar a su Donald) y Dayron. Cada muerte del bando malo
  te da una recompensa. En la Torre aparece el verdadero jefe final… y cuando todo parece
  perdido llega ayuda de donde menos te lo esperas.
- **Ruta FURRYGRAVE** — hay un **sticker dorado de Dayron** escondido en un rincón de las Llanuras.
  Aroy.exe te va a pedir tres veces que no lo toques. Si lo haces, pasas a controlar a Dayron.
  En vez de "Continuar" solo te queda **MILA ES GOD**.

---

## Para desarrolladores (`herramientas/`)

| Script | Qué hace |
|---|---|
| `generar_todo.py` | Dibuja todos los sprites, retratos, enemigos, balas, tilesets, voces y efectos |
| `mapas.py` | Genera los 24 mapas (formato Tiled-Lua) desde un mini-lenguaje en Python |
| `fuente_plain.py` | Añade tildes, ñ y ¿¡ a la fuente de los bocadillos de diálogo |
| `instalar_musica.py` | Coloca la música en `assets/music/<sección>/` |
| `verificar.py` | Comprueba que existen todas las referencias (cinemáticas, mapas, sprites, objetos…) |
| `probar.sh` | Lanza el mod sin pantalla con pruebas automáticas y saca capturas |
| `empaquetar.sh` | Crea `descargas/` (el .exe de Windows y el .love listos para jugar) |

```
pip install pillow
python3 herramientas/generar_todo.py && python3 herramientas/mapas.py
python3 herramientas/verificar.py /ruta/a/Kristal
KRISTAL=/ruta/a/Kristal herramientas/probar.sh combates 1800
```

Pruebas disponibles (`deltarune_pcdm/scripts/tests.lua`): `humo`, `ut`, `mapas`, `historia_lw`,
`aula`, `patio`, `andres_pino`, `dark_world`, `combates` (con `PCDM_COMBATE=<encuentro>` para
probar uno solo).
