#!/bin/bash

mkdir -p transcoded
ffmpeg -i "$1" -vcodec mov -q:v 2 -acodec pcm_s16be -q:a 0 -f mjpeg "transcoded/${1%.*}.mov"
