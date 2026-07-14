#!/bin/bash
# ============================================================================
# Regenera styles-remote.css (bundle sin @import para el CSS remoto de WordCamp)
# Uso:  ./build-css.sh   y luego commit + push para que WordPress lo sincronice.
# ============================================================================
set -e
cd "$(dirname "$0")"

{
  echo "/* =========================================================================="
  echo "   WordPress Campus Connect UVG 2026 — BUNDLE PARA CSS REMOTO (WordCamp)"
  echo "   Archivo GENERADO: no editar a mano. Se regenera concatenando /css."
  echo "   Regenerar con:  ./build-css.sh"
  echo "   ========================================================================== */"
  for f in base buttons header hero about agenda boletos sede patrocinios comunidad faq noticias cta footer wordcamp-overrides; do
    echo ""
    cat "css/$f.css"
  done
} > styles-remote.css

echo "✔ styles-remote.css regenerado ($(wc -l < styles-remote.css | tr -d ' ') lineas)"
