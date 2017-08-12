#!/usr/bin/env bash
cd "$(dirname $0)" || exit # cd into script's directory
for dir in */ ; do
	cd $dir || exit # cd into every subdirectory
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1 ; then # is this a git repository?
		echo ${dir%/}: not a git repository
		cd .. # go back to parent directory
		continue
	fi
	echo pull ${dir%/}...
	git pull
	cd .. # go back to parent directory
done
