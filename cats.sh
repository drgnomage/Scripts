#!/bin/bash

checkjpg=1
checkjpeg=1
checkpng=1
checkmp4=1
checkgif=1
checkyou=1
checkyoutube=1
checkgifv=1
checkwebm=1

chkhttp() {
	checkdata=$(echo "$cat" | grep -ci "data-url")
	#echo $checkdata
}

chkdata() {
	checkcomments=$(echo "$cat" | grep -ci "comments")
	#echo $checkcomments
}

chkcomments() {
	url=$(echo $cat | cut -c 10-1000 | sed -e 's/\"//g')
	file=$(basename $url)
	checklist=$(grep -c $file ~/.bin/cats.list)
	#echo $checklist
}

chklist() {
	checkjpg=$(echo "$url" | grep -ci "jpg")
	checkpng=$(echo "$url" | grep -ci "png")
	checkjpeg=$(echo "$url" | grep -ci "jpeg")
	checkgif=$(echo "$url" | grep -ci "gif")
	checkgifv=$(echo "$url" | grep -ci "gifv")
	checkwebm=$(echo "$url" | grep -ci "webm")
	checkmp4=$(echo "$url" | grep -ci "mp4")
	checkyou=$(echo "$url" | grep -ci "youtu.be")
	checkyoutube=$(echo "$url" | grep -ci "youtube")
	#echo $checkjpg $checkjpeg $checkgif $checkwebm $checkmp4
}

chkfile() {
	verified=true
	if [[ $checkjpg -gt 0 ]] || [[ $checkjpeg -gt 0 ]] || [[ $checkpng -gt 0 ]] ; then
		datatype="photo"
		filecheck=true
	elif [[ $checkmp4 -gt 0 ]] || [[ $checkgif -gt 0 ]] ; then
		datatype="video"
		filecheck=true
	elif [[ $checkyou -gt 0 ]] || [[ $checkyoutube -gt 0 ]] || [[ $checkgifv -gt 0 ]] ; then
		datatype="youtube"
		filecheck=true
	elif [[ $checkwebm -gt 0 ]] ; then
		echo "webm sucks."
		verified=false
	else
		echo "Failed on $url"
		echo "$checkjpg $checkjpeg $checkpng $checkmp4 $checkgif $checkyou $checkyoutube $checkgifv $checkwebm"
		verified=false
	fi
}

waiting() {
	unset result
	result="test"

	while [ $result != "yes" ]; do
		date=$(date +%M | sed -e 's/^0*//')
		if [[ -z $date ]] || (( "$date" % 15 == 0 )) ; then
			result="yes"
		else
			result="no"
			sleep 1
		fi
		#echo $result $date
	done
}

chkmd5() {
	md5full=$(md5sum ~/.bin/tmp_cats/$file)
	md5=$(echo $md5full | awk '{print $1}')
	md5check=$(cat ~/.bin/cats.md5 | grep -c $md5)
	if [ "$md5check" = 0 ] ; then
		go=true
		echo $md5full >> ~/.bin/cats.md5
	else
		go=false
	fi
	rm ~/.bin/tmp_cats/$file
}

download() {
	echo $file >> ~/.bin/cats.list
	wget --no-verbose $url -P ~/.bin/tmp_cats/
	echo -e "/home/josh/.bin/tmp_cats/$file\n$url"
}

aws() {
	catcheck=$(~/.bin/cat_detector.py ~/.bin/tmp_cats/$file | grep -ci "cat")
	echo "catcheck value: $catcheck"
	if [ $catcheck -gt 0 ] ; then
		go=true
	else
		go=false
	fi
}

post() {

	if [ "$go" = true ] ; then

		waiting

		count=$((count + 1))

		if [ "$url" != "" ] ; then
			echo "$url" | if /home/josh/.bin/telegram.py $datatype caturday ; then sleep 60 ; fi
		else
			echo "https://cataas.com/cat/gif?test=$RANDOM" | if /home/josh/.bin/telegram.py video caturday ; then sleep 60 ; fi
		fi

	fi


}

delete() {
        find /home/josh/.bin/tmp_cats/ -mtime +7 -delete
}

count=1
urlcount=0

while true ; do

	urlcount=$((urlcount + 1))

	if [[ $urlcount = 1 ]] ; then
		urltype="rising"
	elif [[ $urlcount = 2 ]] ; then
		urltype="best"
	elif [[ $urlcount = 3 ]] ; then
		urltype="hot"
	elif [[ $urlcount = 4 ]] ; then
		urltype="new"
		urlcount=0
	fi

	echo "urltype: $urltype $urlcount"

	. ~/.bin/cat.urls $urltype

	for cat in $( echo $allcats ) ; do

		checkhttp=$(echo "$cat" | grep -ci "http")
		echo "checkhttp: $checkhttp $cat"

		if [ "$checkhttp" -gt 0 ] ; then chkhttp ; fi ; echo "chkhttp"

		if [ "$checkdata" -gt 0 ] ; then chkdata ; fi ; echo "chkdata"

		if [ "$checkcomments" = 0 ] ; then chkcomments ; fi ; echo "chkcomments"

		if [ "$checklist" = 0 ] ; then chklist ; else continue ; fi ; echo "chklist"

		chkfile ; echo "chkfile"

		if [ "$filecheck" = true ] ; then

			download
			if [ "$(file ~/.bin/tmp_cats/$file | grep -ci html)" -gt 0 ] ; then continue ; fi
			chkmd5

			if [ "$verified" = true ] ; then
				aws
				post
			fi

		fi

		echo "Count: $count"
		if (( count % 4 == 0 )) ; then
			url=""
			post
		fi

		unset checkhttp
		unset checkdata
		unset checkcomments
		unset checklist
		unset filecheck
		unset verified
		unset go
		delete
	done

done
