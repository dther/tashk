.SILENT: clean

default:
	shellcheck tashk

clean:
	echo "tashk is a shell script! There is nothing to clean."
	echo "If you intend to install tashk system wide,"
	echo "'make install' will put it in /usr/local/bin/."
	echo ''
	echo "However, if you'd like to symlink it to ~/bin/"
	echo "(which is what I do), do 'make link'."
	exit 1

install:
	echo "unimplemented."

link:
	ln -s "${PWD}/tashk" "${HOME}/bin/tashk"
	ln -s "${PWD}/tashkcolor.sh" "${HOME}/bin/tashkcolor.sh"
