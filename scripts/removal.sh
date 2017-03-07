#!/bin/sh
file=$(~/lines.txt)
line=$(cat $file | grep -v School,Postcode | awk '{print}' ORS=' ')

if [[ -z "$line" ]] ; then
echo "Completed"
exit 0
else
echo "Removing lines"
cat ~/160503\ Edubase\ Data\ for\ Josh.csv | grep -v $line > ~/160503\ Edubase\ Data\ for\ Josh\ rem.csv
fi

exit 0
