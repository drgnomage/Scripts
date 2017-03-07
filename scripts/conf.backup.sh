#!/bin/sh

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

list="/root/.found.txt"
D=`date +%d`
M=`date +%m`
Y=`date +%Y`

find / -name "*.conf" ! -name "*.cfg" -fprint $list

tar cpzf ~/$D-$M-$Y-conf.tar.gz --files-from=$list --exclude=/run --exclude=/home/josh/mnt --exclude=/boot
find ~/*conf.tar.gz -mtime +6 -exec rm {} \;
