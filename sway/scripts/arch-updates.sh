#!/bin/sh

if [[ $(ping -q -w1 -c1 google.com 2> /dev/null) ]]; then
	dbpath="/tmp/updates.db"
	if [[ -d ${dbpath} ]]; then
		rm -r ${dbpath}
	fi

	mkdir -p ${dbpath}
	ln -s $(pacman-conf DBPath)/local ${dbpath}
	fakeroot pacman -Sy --dbpath ${dbpath} 2>&1 >/dev/null

	if ! updates=$(yay -Qu --dbpath ${dbpath} 2> /dev/null | wc -l ); then
	    updates=0
	fi

	echo "$updates"

	rm -r ${dbpath}
fi
