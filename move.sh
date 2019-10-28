#!/bin/sh

for i in `~/mnt/Music/*/*.opus` ; do mv "${i/.opus/.mp3}" ~/mnt/mp3/" ; done
for i in `~/mnt/Music/*/*/*.opus` ; do mv "${i/.opus/.mp3}" ~/mnt/mp3/" ; done
for i in `~/mnt/Music/*/*/*/*.opus` ; do mv "${i/.opus/.mp3}" ~/mnt/mp3/" ; done
for i in `~/mnt/Music/*/*/*/*/*.opus` ; do mv "${i/.opus/.mp3}" ~/mnt/mp3/" ; done
