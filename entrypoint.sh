#!/bin/sh
ls -la

fontforge -lang=py ligaturize.py /input --prefix="$FILE_NAME_PREFIX" --output-dir=/output/ --output-name="$OUTPUT_NAME" 2>&1 \
| fgrep -v 'This contextual rule applies no lookups.' \
| fgrep -v 'Bad device table'