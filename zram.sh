#!/bin/zsh

if ! whereis zramctl > /dev/null ; then
	echo "Please install ZRAM."
	break
fi

mem=$(free -m | grep Mem | awk '{print $2}')
swap=$(free -m | grep Swap | awk '{print $2}')
difference=$(($mem - $swap))
required=$(($mem/4))

if [[ $swap -lt $required ]] ; then
	echo -e "Mem:\t$mem\nSwap:\t$swap\nDiff:\t$difference\nReq:\t$required\n"
	zramctl --find --size $(($required - $swap))M | \
	while read zram ; do
		mkswap $zram
		swapon $zram
	done

fi
