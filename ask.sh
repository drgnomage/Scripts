#!/bin/sh

awk 'NR==FNR{a["{[^{}]*"$0"[^{}]*}"]++;next}{for(i in a)if($0~i)next;b[j++]=$0}END{printf "">FILENAME;for(i=0;i in b;++i)print b[i]>FILENAME}' ~/mnt/160503\ Customer\ Cancelled\ List.csv ~/mnt/160503\ Edubase\ Data\ for\ Josh.csv
