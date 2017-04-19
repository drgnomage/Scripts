#!/bin/sh

export DISPLAY=:0.0

ssh 172.20.1.52 /home/josh/lock.sh &
i3lock -c 2d2d2d -e --ringcolor=d3d0c800 --insidevercolor=0000a0bf --insidewrongcolor=ff8000bf --insidecolor=ffffffbf --ringvercolor=0020ffff --ringwrongcolor=4040ffff --textcolor=ffffffff --keyhlcolor=30ccccff --bshlcolor=ff8000ff -n

ssh 172.20.1.52 killall i3lock