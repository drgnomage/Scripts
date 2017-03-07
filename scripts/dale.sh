#!/bin/sh

for i in /path/to/files/*;
do
count=$(cat $i | grep -c "EXACT WORDS")
if [[ -z "$count" ]]; then
exit 0
else
echo "found in $i"
fi; done

exit 0


