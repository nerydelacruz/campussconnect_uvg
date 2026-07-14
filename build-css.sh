#!/bin/bash
# ============================================================================
# Regenera styles-remote.css: bundle para el "CSS remoto" de WordCamp.
#  - Concatena los modulos de /css en orden
#  - RESUELVE las variables CSS a valores literales (el sanitizador de
#    WordCamp elimina var(--...), por eso el bundle no puede usarlas)
# Uso:  ./build-css.sh   y luego commit + push + "Actualizar" en WordPress.
# ============================================================================
set -e
cd "$(dirname "$0")"

OUT=styles-remote.css

{
  echo "/* =========================================================================="
  echo "   WordPress Campus Connect UVG 2026 — BUNDLE PARA CSS REMOTO (WordCamp)"
  echo "   Archivo GENERADO por build-css.sh: no editar a mano."
  echo "   Variables CSS resueltas a literales (el sanitizador las elimina)."
  echo "   ========================================================================== */"
  for f in base buttons header hero about agenda boletos sede patrocinios comunidad faq noticias cta footer wordcamp-overrides; do
    echo ""
    cat "css/$f.css"
  done
} > "$OUT"

# --- resolver variables (orden: nombres largos primero) ---
perl -pi -e '
  s/var\(--sticker-shadow-sm\)/3px 3px 0 #14231A/g;
  s/var\(--sticker-shadow\)/5px 5px 0 #14231A/g;
  s/var\(--sticker-border\)/2px solid #14231A/g;
  s/var\(--canvas-soft\)/#F2ECDF/g;
  s/var\(--canvas\)/#FAF5EC/g;
  s/var\(--ink-soft\)/#4C5C50/g;
  s/var\(--ink\)/#14231A/g;
  s/var\(--forest-soft\)/#16522F/g;
  s/var\(--forest\)/#0E3A22/g;
  s/var\(--green-bright\)/#2FBF5C/g;
  s/var\(--green-pale\)/#DEEFE0/g;
  s/var\(--green\)/#159A3A/g;
  s/var\(--terracota\)/#D95B2B/g;
  s/var\(--gold-soft\)/#FFD43B/g;
  s/var\(--gold\)/#F0A402/g;
  s/var\(--wp-blue\)/#21759B/g;
  s/var\(--font-display\)/"Bricolage Grotesque","Rubik",system-ui,sans-serif/g;
  s/var\(--font-body\)/"Public Sans","Manrope",system-ui,sans-serif/g;
  s/var\(--font-mono\)/"IBM Plex Mono","Fira Code",monospace/g;
  s/var\(--wrap\)/1160px/g;
  s/var\(--radius\)/22px/g;
' "$OUT"

# comprobacion: no deben quedar var() sin resolver
LEFT=$(grep -c 'var(--' "$OUT" || true)
echo "✔ $OUT regenerado ($(wc -l < "$OUT" | tr -d ' ') lineas, var() sin resolver: $LEFT)"
