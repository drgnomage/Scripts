#!/bin/sh

TORRENTLIST=$(transmission-remote 9090 --list | grep 'www.' | awk '{print $1}')

#transmission-remote 9090 --list

for TORRENTID in $TORRENTLIST
do
    echo Processing : $TORRENTID
    transmission-remote 9090 --torrent $TORRENTID --remove
done
