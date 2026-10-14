#!/bin/bash
# Crea el juego listo para jugar (Kristal + el mod, arranca directamente en DELTARUNE PCDM):
#   descargas/DeltarunePCDM.love          -> Mac / Linux / Android (con LÖVE 11.5 instalado)
#   descargas/DeltarunePCDM-Windows.zip   -> Windows: descomprimir y doble clic en DeltarunePCDM.exe
# Uso: KRISTAL=/ruta/a/Kristal LOVE_WIN=/ruta/a/love-11.5-win64 herramientas/empaquetar.sh
set -e
REPO=$(cd "$(dirname "$0")/.." && pwd)
KRISTAL=${KRISTAL:?Pon KRISTAL=/ruta/a/Kristal}
LOVE_WIN=${LOVE_WIN:?Pon LOVE_WIN=/ruta/a/love-11.5-win64 (carpeta descomprimida)}
OUT="$REPO/descargas"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# 1) Kristal sin lo que no hace falta para jugar
G="$TMP/juego"
mkdir -p "$G"
for f in main.lua conf.lua LICENSE VERSION gamecontrollerdb.txt icon.png assets configs data lib src; do
    cp -r "$KRISTAL/$f" "$G/"
done
mkdir -p "$G/mods"
cp -r "$REPO/deltarune_pcdm" "$G/mods/deltarune_pcdm"
cp "$REPO/deltarune_pcdm/icon.png" "$G/icon.png"

# 2) El menú de Kristal va directo a las partidas de este mod
sed -i 's/^TARGET_MOD = nil/TARGET_MOD = "deltarune_pcdm"/' "$G/src/engine/vendcust.lua"
grep -q '^TARGET_MOD = "deltarune_pcdm"' "$G/src/engine/vendcust.lua"
# las pruebas automáticas (PCDM_TEST) saltan el menú
sed -i 's/^AUTO_MOD_START = false/AUTO_MOD_START = os.getenv("PCDM_TEST") ~= nil/' "$G/src/engine/vendcust.lua"
# nombre propio de la ventana y carpeta de partidas guardadas
sed -i 's/t.identity = "kristal"/t.identity = "deltarune_pcdm"/; s/t.window.title = "Kristal"/t.window.title = "DELTARUNE PCDM"/' "$G/conf.lua"

# 3) .love (un zip con main.lua en la raíz)
mkdir -p "$OUT"
rm -f "$OUT/DeltarunePCDM.love" "$OUT/DeltarunePCDM-Windows.zip"
(cd "$G" && zip -q -9 -r "$OUT/DeltarunePCDM.love" .)

# 4) Windows: love.exe + .love pegados = DeltarunePCDM.exe, con sus DLL
W="$TMP/DeltarunePCDM"
mkdir -p "$W"
cat "$LOVE_WIN/love.exe" "$OUT/DeltarunePCDM.love" > "$W/DeltarunePCDM.exe"
cp "$LOVE_WIN"/*.dll "$W/"
cp "$LOVE_WIN/license.txt" "$W/licencia-love.txt"
cat > "$W/LEEME.txt" <<'EOF'
DELTARUNE PCDM - Capítulo 1: ¡SAL DEL ARMARIO!

1. Haz doble clic en DeltarunePCDM.exe
2. Si Windows dice "Windows protegió su PC": pulsa "Más información" y luego "Ejecutar de todas formas"
   (sale porque el .exe no está firmado, no es un virus).
3. En el menú elige una partida vacía para empezar.

Controles: flechas para moverte, Z o Enter para aceptar, X o Shift para cancelar/correr, C o Ctrl para el menú.
F4 o Alt+Enter: pantalla completa.

Hecho con Kristal (motor de mods de DELTARUNE) y LÖVE 11.5.
EOF
(cd "$TMP" && zip -q -9 -r "$OUT/DeltarunePCDM-Windows.zip" DeltarunePCDM)
ls -la "$OUT"
