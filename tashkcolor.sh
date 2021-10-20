#!/bin/sh
# (c) Rudy Dellomas III, GPLv3. See LICENSE file at root of repository.

# Use ANSI escape codes to colourise tashk.
# obv. assumes that these escape codes work
# NOTES:
# - this has to be done BEFORE piping to nl (use -p)
# - awk might be more robust.
#   m4 won't work because the todotxt spec is strict and m4 macro names
#   can't contain parens

# bold/bright
bblack='[1;30m' # Grey on most terminals
bred='[1;31m'
bgreen='[1;32m'
byellow='[1;33m'
bblue='[1;34m'
bmagenta='[1;35m'
bcyan='[1;36m'
bwhite='[1;37m'
bold='[1m' # no colour

green='[0;32m'
magenta='[0;35m'
white='[0;37m'
black='[0;30m' # Completely invisible on some terminals.

strike='[9m'

clr='[0m'
sed "
	# Find priorities
	/^(A)/s/^\(.*\)$/<<<A>>>\1/
	/^(B)/s/^\(.*\)$/<<<B>>>\1/
	/^(C)/s/^\(.*\)$/<<<C>>>\1/
	/^(D)/s/^\(.*\)$/<<<D>>>\1/

	# find completed
	/^x/s/^\(.*\)$/<<<x>>>\1/

	# projects + contexts
	s/ \(+[[:graph:]]*\)/ $magenta\1<<<ATTR>>>/g
	s/ \(@[[:graph:]]*\)/ $green\1<<<ATTR>>>/g

	# change <<<ATTR>>> to correct default line attributes
	/<<<A>>>/s/<<<ATTR>>>/<<<A>>>/g
	/<<<B>>>/s/<<<ATTR>>>/<<<B>>>/g
	/<<<C>>>/s/<<<ATTR>>>/<<<C>>>/g
	/<<<D>>>/s/<<<ATTR>>>/<<<D>>>/g
	/<<<x>>>/s/<<<ATTR>>>/<<<x>>>/g
	s/<<<ATTR>>>/$clr/g; # default

	# change <<<foo>>> tags to an appropriate escape sequence
	s/<<<A>>>/$bred/g
	s/<<<B>>>/$byellow/g
	s/<<<C>>>/$bblue/g
	s/<<<D>>>/$bold/g
	s/<<<x>>>/$bblack$strike/g

	# clear on newline
	s/$/$clr/
"
