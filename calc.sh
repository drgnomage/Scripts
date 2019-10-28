#!/bin/bash

first=$1
second=$3
dec=6

function ADDITION {
vars=$(echo "scale=$dec; $first+$second" | bc)
echo $vars 
}

function SUBTRACT {
vars=$(echo "scale=$dec; $first-$second" | bc)
echo $vars 
}

function MULTIPLY {
vars=$(echo "scale=$dec; $first*$second" | bc)
echo $vars 
}

function DIVIDE {
vars=$(echo "scale=$dec; $first/$second" | bc)
echo $vars 
}

if [ $2 = "+" ] ; then
ADDITION
fi

if [ $2 = "-" ] ; then
SUBTRACT
fi

if [ $2 = "x" ] ; then
MULTIPLY
fi

if [ $2 = "/" ] ; then
DIVIDE
fi

#$0 & 

