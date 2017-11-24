#!/usr/bin/env bash
cd "$(dirname $0)" # Gå till katalogen som skriptet ligger i
for dir in */ ; do
	cd $dir # Gå in i alla underkataloger
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1 ; then # Försäkra dig om att katalogen innehåller ett git-repo
		echo ${dir%/}: not a git repository
		cd .. # Gå tillbaka till den övre katalogen
		continue
	fi
	echo pull ${dir%/}...
	git pull
	cd ..
done
