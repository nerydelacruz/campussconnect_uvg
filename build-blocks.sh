#!/bin/bash
# ============================================================================
# Genera los wordpress-bloque-*.html a partir de las FUENTES UNICAS:
#   landing.html          -> wordpress-bloque-1.html + wordpress-bloque-2.html
#                            (se parte en el marcador CAMPTIX)
#
# Limpieza aplicada a cada bloque:
#   - quita <head>, comentarios HTML y etiquetas de documento
#   - convierte acentos/emojis a entidades HTML (a prueba de codificacion)
# Uso:  ./build-blocks.sh
# ============================================================================
set -e
cd "$(dirname "$0")"

clean () {
  perl -0777 -pe '
    s/<head>.*?<\/head>//s;
    s/<!--.*?-->//gs;
    s/<\/?(!DOCTYPE[^>]*|html[^>]*|body)>//gi;
    s/^\s*\n//gm;
  ' | python3 -c "
import sys
text = sys.stdin.read()
sys.stdout.write(''.join(ch if ord(ch) < 128 else '&#%d;' % ord(ch) for ch in text))
"
}

# --- landing: partir en el marcador CAMPTIX ---
awk '/================== CAMPTIX ==================/{exit} {print}' landing.html | clean > wordpress-bloque-1.html
awk 'f{print} /================== CAMPTIX ==================/{f=1}' landing.html | clean > wordpress-bloque-2.html
echo "✔ wordpress-bloque-1.html"
echo "✔ wordpress-bloque-2.html"
