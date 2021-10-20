#!/bin/sh
# (c) Rudy Dellomas III, GPLv3. See LICENSE file at root of repository.

# Use ANSI escape codes to colourise tashk.
# obv. assumes that these escape codes work
# NOTES:
# - this has to be done BEFORE piping to nl (use -p)
# - awk might be more robust.
#   m4 won't work because the todotxt spec is strict and m4 macro names
#   can't contain parens

bblack='[1;30m'
bred='[1;31m'
bgreen='[1;32m'
byellow='[1;33m'
bblue='[1;34m'
bmagenta='[1;35m'
bcyan='[1;36m'
bwhite='[1;37m'

green='[0;32m'
magenta='[0;35m'
white='[0;37m'

strike='[9m'

clr='[0m'
sed "
	# projects + contexts
	# <<<ATTR>>> will be replaced with appropriate terminal attributes
	s/ \(+[[:graph:]]*\)/ $magenta\1<<<ATTR>>>/g
	s/ \(@[[:graph:]]*\)/ $green\1<<<ATTR>>>/g

	# reset attributes
	/^(A)/s/<<<ATTR>>>/${bred}/g
	/^(B)/s/<<<ATTR>>>/${byellow}/g
	/^(C)/s/<<<ATTR>>>/${bblue}/g
	/^(D)/s/<<<ATTR>>>/${bmagenta}/g
	/^x /s/<<<ATTR>>>/${bblack}${strike}/g
	s/<<<ATTR>>>/$clr/g; # default

	# complete colouring priorities
	/^(A)/s/^\(.*\)$/$bred\1/
	/^(B)/s/^\(.*\)$/$byellow\1/
	/^(C)/s/^\(.*\)$/$bblue\1/
	/^(D)/s/^\(.*\)$/$bmagenta\1/

	# strike completed
	/^x /s/^\(.*\)$/$bblack$strike\1/

	# clear on newline
	s/$/$clr/
"
