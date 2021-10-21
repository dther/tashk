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
	# Find priorities, mark their lines with <tty:A-Z> as appropriate
	/^([[:upper:]]) /s/^(\([[:upper:]]\)) \(.*\)$/<tty:\1>(\1) \2/

	# find completed
	/^x /s/^\(.*\)$/<tty:x>\1/

	# projects + contexts
	s/ \(+[[:graph:]]*\)/ <tty:proj>\1<tty:clr>/g
	s/ \(@[[:graph:]]*\)/ <tty:cont>\1<tty:clr>/g

	# change <tty:clr> to correct default line attributes
	/<tty:[[:upper:]]>/{
		# Keep repeating this until all <tty:clr>s are replaced
		: findnext
		s/<tty:\([[:upper:]]\)>\(.*\)<tty:clr>/<tty:\1>\2<tty:\1>/g
		t findnext
	}

	/<tty:x>/s/<tty:clr>/<tty:x>/g
	s/<tty:clr>/$clr/g; # default

	# change <tty:-> tags to an appropriate escape sequence
	s/<tty:A>/$bred/g
	s/<tty:B>/$byellow/g
	s/<tty:C>/$bblue/g
	s/<tty:D>/$bmagenta/g
	s/<tty:[[:upper:]]>/$bwhite/g # default for unset priorities

	s/<tty:x>/$bblack$strike/g

	s/<tty:proj>/$magenta/g
	s/<tty:cont>/$green/g

	# clear on newline
	s/$/$clr/
"
