#!/bin/bash

mkdir transcoded; for i in *.mov; do ffmpeg -i "$i" -vcodec mov -q:v 2 -acodec pcm_s16be -q:a 0 -f mjpeg "transcoded/${i%.*}.mov"; done
