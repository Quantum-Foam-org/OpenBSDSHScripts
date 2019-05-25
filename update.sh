#!/bin/sh

ports=`/usr/ports/infrastructure/bin/out-of-date | cut -d "#" -f 1 | sed s/,.*//`

for name in $ports 
do 
	if (file -b $name | grep '^directory$')
	then
		cd $name
		update=`make update`
		echo "$update built update $name"
		cd /usr/ports 
	else
		echo "$name port cannot be found"
	fi
done
