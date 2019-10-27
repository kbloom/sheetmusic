#!/bin/bash
SINCE=$1
OUTPUT_DIR=$2

IFS='
'

for x in $(git diff --name-only $SINCE | grep 'mscz$'); do
	mkdir -p $OUTPUT_DIR/$(dirname $x)
	musescore3 "$x" -o "$OUTPUT_DIR/${x/.mscz/.pdf}"
done
