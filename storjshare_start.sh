#!/bin/sh

sudo storjshare daemon

for i in $(ls /home/josh/.config/storjshare/configs/ ) ; do storjshare-start -c /home/josh/.config/storjshare/configs/$i ; done

storjshare-status
