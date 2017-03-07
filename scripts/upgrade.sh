#!/bin/sh

for i in `yaourt -Qnq` ; do yes | yaourt -S $i ; done

# for i in `pacman -Qnq` ; do yaourt -S $i-git --force ; done
