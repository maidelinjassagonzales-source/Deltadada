#!/bin/bash
# Lanza Kristal en modo prueba sin pantalla: herramientas/probar.sh <test> [segundos]
# Requiere: KRISTAL=/ruta/a/Kristal, love y xvfb-run.
TEST=${1:-humo}
TIME=${2:-60}
KRISTAL=${KRISTAL:-/tmp/claude-0/-home-user-Deltadada/52f71480-7636-5657-b64c-a02e9504d8d0/scratchpad/ext/Kristal}
SAVE=$HOME/.local/share/love/kristal
rm -rf "$SAVE/pcdm_shots" "$SAVE/saves/deltarune_pcdm"
REPO=$(cd "$(dirname "$0")/.." && pwd)
rm -rf "$KRISTAL/mods/deltarune_pcdm"
cp -r "$REPO/deltarune_pcdm" "$KRISTAL/mods/deltarune_pcdm"
cd "$KRISTAL" && PCDM_TEST=$TEST SDL_AUDIODRIVER=dummy timeout $TIME xvfb-run -a -s "-screen 0 1280x960x24" love . --mod deltarune_pcdm --auto-mod-start --disable-stdout-buffer 2>&1 | grep -v "^AL lib\|^ALSA\|Could not open device" | tail -${TAIL:-60}
echo "exit: ${PIPESTATUS[0]}"
ls "$SAVE/pcdm_shots" 2>/dev/null
