#!/usr/bin/env sh

# https://github.com/Yonle/makejail

if [ $# = 0 ]; then
	printf "Usage: makejail <commands>\nThis will create a jail bootstrap with several commands.\nEach commands is separated by space.\n\nTo make a jail bootstrap in a different filename, Append JAIL_FILENAME variable.\n"
else
	paths=""
	for cmd in $@; do
		! command -v $cmd > /dev/null && echo "$cmd not found" && exit 1
		paths="$paths $(command -v $cmd) `ldd $(command -v $cmd) | grep -o "/.*" | cut -d"(" -f1`"
	done

	echo "Proceed creating tarballs...."

	tar -cvaf ${JAIL_FILENAME:-"JailBootstrap-$(uname)-$(uname -m).tar.gz"} $paths
fi
