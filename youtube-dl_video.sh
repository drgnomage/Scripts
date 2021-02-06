#!/bin/bash

if [ ! -z "$1" ] ; then
	URL="$1"

else
	echo "Which URL?"
	read URL

fi

if [ ! -z "$2" ] ; then
	resolution="$2"

else
	resolution="1080"

fi

if [ ! -z $URL ] ; then
	filename=$(youtube-dl -f "bestvideo[height<=?${resolution}][fps<=?30][vcodec!=?vp9]+bestaudio/best" --get-filename \
					-o "/Data/Videos/Youtube/%(uploader)s/%(title)s-${resolution}p-%(fps)sfps.%(ext)s" --yes-playlist $URL)

	youtube-dl -f "bestvideo[height<=?${resolution}][fps<=?30][vcodec!=?vp9]+bestaudio/best" \
		--ignore-errors --restrict-filenames --embed-subs --add-metadata \
		--write-description --write-info-json --write-annotations --write-thumbnail \
		-o "/Data/Videos/Youtube/%(uploader)s/%(title)s-${resolution}p-%(fps)sfps.%(ext)s" \
		--yes-playlist $URL

	mediainfo --LogFile="$filename".nfo "$filename"

fi

