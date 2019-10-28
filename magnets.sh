#!/bin/bash

while true ; do

if [ -z $1 ] ; then
	magnets=$()
else
	read magnets
fi

for magnet in $magnets ; do
count=$(grep -c $magnet ~/.bin/magnets.list)

if [ $count = 0 ] ; then
transmission-remote 9090 -a "$magnet"
echo $magnet >> ~/.bin/magnets.list
fi

done

TORRENTLIST=`transmission-remote 9090 --list | sed -e '1d;$d;s/^ *//' | cut --only-delimited --delimiter=" " --fields=1`

for TORRENTID in $TORRENTLIST ; do
echo Processing : $TORRENTID

DL_COMPLETED=`transmission-remote 9090 --torrent $TORRENTID --info | grep -c "100%"`
STATE_STOPPED=`transmission-remote 9090 --torrent $TORRENTID --info | grep -c "Finished"`

if [ $DL_COMPLETED == 2 ] && [ $STATE_STOPPED == 1 ]; then
echo "Torrent $TORRENTID is completed"
echo "Removing torrent from list"
transmission-remote 9090 --torrent $TORRENTID --remove
fi

done
sleep 3600

done
