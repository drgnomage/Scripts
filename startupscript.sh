#!/bin/sh

sshfs -o allow_other 172.20.1.52: ~/mnt

sshfs -o allow_other media.glitchbusters.info:/mnt /mnt 
