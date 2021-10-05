.SILENT: clean

default:
	shellcheck tashk

clean:
	echo "tashk is a shell script! There is nothing to clean."
	echo "If you intend to install tashk system wide,"
	echo "'make install' will put it in /usr/local/bin/."
	exit 1

install:
	echo "unimplemented."
