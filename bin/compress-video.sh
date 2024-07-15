#!/bin/bash

input_file="$1"
output_file="$2"

ffmpeg -i "$input_file" -vcodec libx265 -crf 28 -preset fast -vf "scale=1280:-1" -acodec aac -b:a 128k -pass 1 -f null /dev/null && ffmpeg -i "$input_file" -vcodec libx265 -crf 28 -preset fast -vf "scale=1280:-1" -acodec aac -b:a 128k -pass 2 "$output_file"
