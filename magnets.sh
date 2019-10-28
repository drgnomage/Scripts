#!/bin/bash

while true ; do

#magnets=$(curl 'https://showrss.info/timeline' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://showrss.info/login' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Cookie: __cfduid=d58c3561dd411bc9af1ef4f54eb9c354b1567694155; XSRF-TOKEN=eyJpdiI6IkU4cWo4bXowQmJoU0VwWWZ2XC9xemRnPT0iLCJ2YWx1ZSI6IlJrdGNENTdKRlVuTSs3N0RCUTlENkZQc0VGR2w2NVBvQkltdUtneG9vRjJmSXR6U3U4a2tpRTQ1WnNiM21hNEwiLCJtYWMiOiJiZmYwMTI4NzVhZDc1ZTc0MjZmOTIzNTkzYzliYTkzNTBiMDUyNGFlOWJmMmZkOTMzZWJkN2IyZjdmYjM2NWQ5In0%3D; laravel_session=eyJpdiI6IkF0Um9KTkxlMmJ2NDNSVVZCRTJacmc9PSIsInZhbHVlIjoiY1AzQ2lpVFBCcVZqeGNrQlB4K1dYMERLa0JEbzFMWkIzOGZiYmd4dDRBMGFxcE1WODMzc25BYWFyOUhqT0ZjWiIsIm1hYyI6IjA5MjViN2M1YzZjZTllMWY5ZDViY2NmYmJiZjhjNTA1NzFkZjE4YWI5OTk3NWM5N2E1ZDEwN2U2ZGI5NDhkZTIifQ%3D%3D' -H 'Upgrade-Insecure-Requests: 1' -H 'Cache-Control: max-age=0' | grep magnet | sed -e 's/\"/ /g' | awk '{print $3}'\n | grep '[S,s][0-9][0-9][E,e][0-9][0-9]')

magnets=$(curl -l http://showrss.info/user/105433.rss\?magnets\=true\&namespaces\=false\&name\=clean\&quality\=null\&re\=null | tr '<' '\n' | tr '>' '\n' | grep "url=\"magnet" | tr ' ' '\n' | sed 's/\"/\ /g' | grep magnet | awk '{print $2}')

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
