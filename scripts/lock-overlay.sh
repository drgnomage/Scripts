#!/bin/bash
# i3 lock script: pixelates screen and adds lock pic
# requires imagemagick and scrot

tmpbg="/tmp/lockscreen.png"
#text="/tmp/locktext.png"
dir="$HOME/Pictures/overlays/"
images=($(find ${dir} -name '*.png'))
rnd=($(seq 0 $(expr ${#images[@]} - 1) | shuf))
if [ $1 ]; then
    pic=$dir''$1'.png'
else
    pic=${images[${rnd[i]}]}
fi

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% -fill black -colorize 50% "$tmpbg"

if [ -f "$pic" ]; then
    convert "$tmpbg" "$pic" -gravity SouthEast -geometry +100+100 -composite -matte "$tmpbg"
fi

i3lock -c 2d2d2d -e --ringcolor=d3d0c800 --insidevercolor=0000a0bf --insidewrongcolor=ff8000bf --insidecolor=ffffffbf --ringvercolor=0020ffff --ringwrongcolor=4040ffff --textcolor=ffffffff --keyhlcolor=30ccccff --bshlcolor=ff8000ff -n -f -i "$tmpbg" >> /dev/null