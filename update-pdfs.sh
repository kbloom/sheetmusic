#!/bin/bash


shopt -s globstar

for MSCZ in **/*.mscz ; do
  PDF="${MSCZ/.mscz/.pdf}"
  if [[ "$MSCZ" -nt "$PDF" ]]; then
    echo updating $PDF
    mscore "$MSCZ" -o "$PDF" && gs -o - -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress  "$PDF" | sponge "$PDF"
  fi
done
