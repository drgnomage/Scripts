#!/bin/bash

for i in ~/mnt/*.mov; do ffmpeg -i "$i" -vcodec copy -acodec copy "${i/.mov/.mp4}" -threads 4; done
