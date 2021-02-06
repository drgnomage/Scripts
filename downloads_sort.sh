#!/bin/bash

uppercase() {
	IFS=' '
	title=$1
	for item in "${title[@]}"; do
		split=( $item )
		echo "'${split[*]^}'"
	done
}

main() {
	original_name=$(basename "$1")
	original_dir=$(dirname "$1")
	title=$( echo $original_name | sed -e 's/[S,s][0-9][0-9].*//g' | sed 's/\./\ /g' | xargs )
	season=$( echo $original_name | sed -e 's/^.*\([S,s][0-9][0-9].*\)/\1/g' | cut -c 2-3 | sed 's/0//' )
	title=$( uppercase "$title" | sed -e s/\'//g )
	echo "$original_dir/$original_name" "/Data/Videos/Episodes/$title/Season $season/"
	mkdir -p "/Data/Videos/Episodes/$title/Season $season/"
	mv "$original_dir/$original_name" "/Data/Videos/Episodes/$title/Season $season/"
}


if [ -z "$1" ]; then
	echo "Please run this script like this."
	echo "for file in *[]* ; do ~/.bin/downloads_sort.sh \"$file\" ; done"
else
	main "$1"
fi
