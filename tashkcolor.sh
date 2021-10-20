#!/bin/sh
# (c) Rudy Dellomas III, GPLv3. See LICENSE file at root of repository.

# Use ANSI escape codes to colourise tashk.
# obv. assumes that these escape codes work
# NOTE: for "done" tasks to work properly,
# this has to be done BEFORE piping to nl...
bblack='[1;30m'
bred='[1;31m'
bgreen='[1;32m'
byellow='[1;33m'
bblue='[1;34m'
bmagenta='[1;35m'
bcyan='[1;36m'
bwhite='[1;37m'

magenta='[0;35m'
white='[0;37m'

strike='[9m'

clr='[0m'
sed "\
	/(A)/s/^\(.*\)$/$bred\1$clr/
	/(B)/s/^\(.*\)$/$byellow\1$clr/
	/(C)/s/^\(.*\)$/$bblue\1$clr/
	/(D)/s/^\(.*\)$/$bmagenta\1$clr/
	s/\(+[[:graph:]]*\)/$magenta\1$clr/
	/^x /s/^\(.*\)$/$bblack$strike\1$clr/"
