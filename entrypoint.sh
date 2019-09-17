#!/bin/sh

ls -la input-fonts

fontforge -lang=py -script build.py 2>&1 \
	| fgrep -v 'This contextual rule applies no lookups.' \
	| fgrep -v 'Bad device table'

ls -la output-fonts