#!/bin/bash

while getopts ":u:k:" opt; do
  case "$opt" in
  k) KEY="$OPTARG";;
  esac
done

curl -X POST \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	-H 'Connection: keep-alive' \
	-d "KEY="$KEY \
	'http://127.0.0.1:6001/shutdown/'

