#!/bin/bash

tail -f /Docker/homeassistant/command_input | while read command ; do

	if [ "$command" != "" ] ; then
		$command
	fi

done
