#!/bin/zsh

file_path="/home/Share/Complete"
move_path="/home/Share/Episodes"

cd $file_path

filename() {

if [ "$(echo "$file" | grep -c "www")" -gt 0 ] ; then
        if [ -z "$(echo "$file" | sed 's/www.*-\ //g')" ] ; then
		echo "Something wrong with sed command."
                exit 255
        else
		output=$(echo "$file" | sed 's/www.*-\ //g')
        mv "$file_path/$file" "$file_path/$output"
	fi
else
        output="$file"
fi

name=$(echo "$output" | sed -e 's/\./ /g' | sed -e "s/'//g" | sed 's/[., ][S,s][0-9][0-9][E,e][0-9][0-9].*//g' | sed -r 's/\<./\U&/g')

}


construction() {

unset season
unset episode

for word in $(echo "$output" | sed -e 's/\ /\./g' | sed -e 's/\./ /g') ; do
	if [ ! -z $(echo "$word" | grep '[S,s][0-9][0-9][E,e][0-9][0-9]') ] ; then
		season=$(echo "$word" | cut -c 1-3)
		seasonno1=$(echo "$season" | cut -c 2-2)
		seasonno2=$(echo "$season" | cut -c 3-3)
		episode=$(echo "$word" | cut -c 4-6)
	fi
done

}


moving() {

if [ "$seasonno1" = '0' ] ; then unset seasonno1 ; fi

mkdir -p "$move_path/$name/Season $seasonno1$seasonno2/"

if [ "$file_path/$output" != "/home/Share/Complete/" ] ; then
echo "rsync -av --progress --remove-source-files" "$file_path/$output" "$move_path/$name/Season $seasonno1$seasonno2/"
echo "chown" "jellyfin:users" "$move_path/$name/" "-R"
echo "chmod" "775" "$move_path/$name/" "-R"

rsync -av --progress --remove-source-files "$file_path/$output" "$move_path/$name/Season $seasonno1$seasonno2/"
chown -f jellyfin:users "$move_path/$name/" -R
chmod -f 775 "$move_path/$name/" -R
find "$file_path" -type d -empty -delete
find "$move_path/$name/" -name RARBG"*" -exec rm {} \;
find "$move_path/$name/" -name ETRG"*" -exec rm {} \;
echo "$name $output" | /home/josh/.bin/telegram.py message mine
else
echo "$file_path/$output_$1_$output" | /home/josh/.bin/telegram.py message mine
fi

}

if [ ! -z "$1" ] ; then

	#echo "if"
	for file in "$(echo "$1" | grep '[S,s][0-9][0-9][E,e][0-9][0-9]')" ; do

		filename
		construction
		moving

	done

elif [ $(ls | grep -c '[S,s][0-9][0-9][E,e][0-9][0-9]') -gt 0 ] ; then

	#echo "elif"
	ls | grep '[S,s][0-9][0-9][E,e][0-9][0-9]' | while read file ; do

		filename
		construction
		moving

	done

else

	#echo "else"
	echo "$1" | /home/josh/.bin/telegram.py message mine

fi
