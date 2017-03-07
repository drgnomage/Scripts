#!/bin/sh

xrandr --output VGA1 --scale 1.5x1.5 --output HDMI1 --scale 1.5x1.5
xrandr --output HDMI1 --primary --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output DP1 --off --output VGA1 --mode 1600x900 --pos 2400x0 --rotate normal

