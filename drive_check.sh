#!/bin/bash

while true ; do
if touch /home/Share/.test ; then
	echo "All good!"
else
	echo "Issue detected!"
	echo "Remounting filesystems!"
fi
sleep 15
done
