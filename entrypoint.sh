#!/bin/sh
if [ ! $FONT_NAME_PREFIX ]; then
    FONT_NAME_PREFIX="Liga $(fc-query /input -f %{family} | fgrep -v "id 0")"
fi

fontforge -lang=py ligaturize.py /input --prefix="$FILE_NAME_PREFIX" --output-dir=/output/ --output-name="$OUTPUT_NAME" 2>&1 \
| fgrep -v 'This contextual rule applies no lookups.' \
| fgrep -v 'Bad device table'