#!/bin/bash

pinky_powers_old=0
princesspumpkins_old=0
taylorstevens_old=0

while true ; do

	online=$(curl 'https://www.pornhubpremium.com/users/drgnomage/model_subscriptions?orderby=online_now' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36' -H 'DNT: 1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'Referer: https://www.pornhubpremium.com/users/drgnomage/model_subscriptions?orderby=alphabetical' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' -H 'Cookie: bs=v0a4hbimqpad1l2qlggw98lbtcvscibw; ss=503504635340701379; cookieBannerEU=1; RNLBSERVERID=ded6966; playlist_reset_watchlater=1; il=v1bvwPlEhzbEjR1CXwzZikBCvpn6rzuuA5R9Tr0GkM0XwxNTY5NjgxNDgxZVU4X3NFZVRLY3VEaVB2b015RmttMEg2SnhFRGxCRUVuQ0JtRHJKNg..; ua=8a54f59640e1605f3e47832c470bf6b0; platform=pc; pp-sid=keSAGuJxlFvH9QohmHCkBoQ8CdLV4OBNDs1z2uSf; sm_track=v1P63hU9xbfJ7KbRcEdQ8jI3j3essdKe94ob2drIMdk6UxNTY0Nzg4Mjg5NTk5OQ..' --compressed | grep -i "/live/" | sed -e 's/"/ /g' | awk '{print $5}' | sort -h | uniq)

	pinky_powers=$(echo $online | grep -c "pinky_powers")

	princesspumpkins=$(echo $online | grep -c "princesspumpkins")

	taylorstevens=$(echo $online | grep -c "taylorstevens")

	echo -e "pinky_powers:\t$pinky_powers\t$pinky_powers_old\nprincesspumpkins:\t$princesspumpkins\t$princesspumpkins_old\ntaylorstevens:\t$taylorstevens\t$taylorstevens_old"

	if (( $pinky_powers != $pinky_powers_old )) && [ $pinky_powers != 0 ]; then
		echo "Pinky Powers is online!" | ~/.bin/telegram.py message mine
	fi

	if (( $princesspumpkins != $princesspumpkins_old )) && [ $princesspumpkins != 0 ]; then
		echo "Princess Pumpkins is online!" | ~/.bin/telegram.py message mine
	fi

	if (( $taylorstevens != $taylorstevens_old )) && [ $taylorstevens != 0 ]; then
		echo "Taylor Stevens is online!" | ~/.bin/telegram.py message mine
	fi

		pinky_powers_old=$pinky_powers
		princesspumpkins_old=$princesspumpkins
		taylorstevens_old=$taylorstevens
	echo -e "pinky_powers:\t$pinky_powers\t$pinky_powers_old\nprincesspumpkins:\t$princesspumpkins\t$princesspumpkins_old\ntaylorstevens:\t$taylorstevens\t$taylorstevens_old"

	sleep 60

done
