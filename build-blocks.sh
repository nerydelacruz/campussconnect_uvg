#!/bin/bash
# ============================================================================
# Genera los archivos wordpress-bloque-*.html listos para pegar en WordPress:
#  - Quita <head>, comentarios HTML y etiquetas de documento
#  - Convierte acentos y emojis a entidades HTML (a prueba de problemas
#    de codificacion al copiar/pegar)
# Uso:  ./build-blocks.sh
# ============================================================================
set -e
cd "$(dirname "$0")"

gen () {
  src="$1"; out="$2"
  perl -0777 -pe '
    s/<head>.*?<\/head>//s;
    s/<!--.*?-->//gs;
    s/<\/?(!DOCTYPE[^>]*|html[^>]*|body)>//gi;
    s/<script src="scripts.js"><\/script>//g;
    s/^\s*\n//gm;
  ' "$src" | python3 -c "
import sys
text = sys.stdin.read()
out = []
for ch in text:
    out.append(ch if ord(ch) < 128 else '&#%d;' % ord(ch))
sys.stdout.write(''.join(out))
" > "$out"
  echo "✔ $out"
}

gen index-parte-1.html      wordpress-bloque-1.html
gen index-parte-2.html      wordpress-bloque-2.html
gen cuenta-wordpress.html   wordpress-bloque-cuenta.html
