#!/bin/bash

while getopts ":a:k:" opt; do
  case "$opt" in
  k) KEY="$OPTARG";;
  a) ADDR="$OPTARG";;
  esac
done

curl -X POST \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	-H 'Connection: keep-alive' \
	-d "KEY="$KEY \
	"http://"$ADDR":6001/shutdown/"

