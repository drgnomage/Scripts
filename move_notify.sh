#!/bin/bash

/usr/bin/inotifywait -m --format "%f" -e create /home/Share/Complete/ | while read file ; do

	echo "$file"
	/home/josh/.bin/move.sh "$file"

done
