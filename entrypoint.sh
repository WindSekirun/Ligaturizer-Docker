#!/bin/sh

ls -la
ls -la input-fonts
ls -la fonts

ls -la /usr/local/src/input-fonts

fontforge -lang=py -script build.py 2>&1 \
	| fgrep -v 'This contextual rule applies no lookups.' \
	| fgrep -v 'Bad device table'

ls -la output-fonts