#!/bin/bash

kitty_id=$(xdotool search kitty)

if [[ -z $kitty_id ]];
then
    kitty --detach --single-instance
    exit
fi

windowstate=$(xwininfo -id $kitty_id | grep 'Map State')

if [[ $windowstate =~ "IsUnMapped" ]];
then
    xdotool windowmap $kitty_id
else
    xdotool windowunmap $kitty_id
fi
