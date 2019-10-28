#!/bin/bash

. ~/.secrets

nextcloudcmd --user $NEXTCLOUD_user --password $NEXTCLOUD_password -n -h /home/josh/Cloud https://cloud.glitchbusters.info/remote.php/webdav/
