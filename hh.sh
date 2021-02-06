#!/bin/bash

temphist=$( cat $( find ~/ -maxdepth 1 -name "*history*" ) )
tempgrep="grep"

echo -e "Grepping personal history files for: "$@"\n"
if [ ! -z $1 ] ; then
	for word in $@ ; do
		temphist=$( echo "$temphist" | grep $word )
		tempgrep=$( echo "$tempgrep -e $word" )
	done
	echo "$temphist" | $tempgrep --colour=always
else
	echo "$temphist"
fi

