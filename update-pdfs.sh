#!/bin/bash
SINCE=$1
OUTPUT_DIR=$2

IFS='
'

MUSESCORE=mscore
if which musescore3 > /dev/null 2>&1; then
	MUSESCORE=musescore3
fi

for x in $(git diff --name-only $SINCE | grep 'mscz$'); do
	OUTFILE="$OUTPUT_DIR/${x/.mscz/.pdf}"
	mkdir -p $OUTPUT_DIR/$(dirname $x)
	$MUSESCORE "$x" -o "$OUTFILE"
	
	# fix pdfs that are corrupt in ways that xelatex can't handle
	gs -o - -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress  "$OUTFILE" | sponge "$OUTFILE"
done
