#!/bin/sh

find ~/Youtube/*/ -type f -ctime +90 -exec rm {} \;
find ~/ASMR/*/ -type f -ctime +90 -exec rm {} \;
