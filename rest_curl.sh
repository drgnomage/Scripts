#!/bin/bash

while getopts ":u:k:" opt; do
  case "$opt" in
  u) URL="$OPTARG";;
  k) KEY="$OPTARG";;
  esac
done

# -u https://www.youtube.com/watch?v=QZ8ZEbNZ9dQ -k flibble

curl -X POST \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	-H 'Connection: keep-alive' \
	-d "URL="$URL"&KEY="$KEY \
	'http://127.0.0.1:6001/music/'

