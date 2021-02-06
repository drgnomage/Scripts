#!/bin/bash

if [ ! -z "$1" ] ; then

	URL="$1"

else

	echo "Which URL?"
	read URL

fi

if [ ! -z $URL ] ; then

	youtube-dl --extract-audio --audio-format mp3 --ignore-errors --restrict-filenames -o "/Data/Audio/Music/Youtube/%(uploader)s/%(title)s.%(ext)s" --yes-playlist $URL
	youtube-dl --extract-audio --ignore-errors --restrict-filenames -o "/Data/Audio/Music/Youtube/%(uploader)s/%(title)s.%(ext)s" --yes-playlist $URL

fi

