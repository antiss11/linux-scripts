#!/bin/sh
# Simple alsamixer controller is used to swith between speakers and headphones. Use --show option to show volume level, example for i3blocks.
# Use --change option to mute one device and set volume to other device.
# Use PCM channel to change volume.

VOLUME_STATUS=$(amixer -c 1 get Headphone | awk 'FNR==7 {print $4}')            #check Headphones
MASTER=$(amixer -c 1 get PCM | awk 'FNR==6 {print $5}'| grep -o [0-9]*)         #get PCM volume


if [[ "$1" = "--show" ]]; then
    if [ $VOLUME_STATUS = "0" ]; then
        echo -e "\uF9C2 $MASTER"
    else
        echo -e "\uF7CA $MASTER"
    fi

elif [[ "$1" = "--change" ]]; then
    if [ $VOLUME_STATUS = "0" ]; then                                                       #if Headphones is disabled - change to headphones
        VOLUME_LEVEL=$(amixer -c 1 get Front | awk 'FNR==6 {print $5}' | grep -o [0-9]*)    #get speakers volume
        amixer -c 1 set Front 0% > /dev/null
        amixer -c 1 set Headphone $VOLUME_LEVEL
    else
        VOLUME_LEVEL=$(amixer -c 1 get Headphone | awk 'FNR==6 {print $5}' | grep -o [0-9]*)
        amixer -c 1 set Headphone 0% > /dev/null
        amixer -c 1 set Front $VOLUME_LEVEL
    fi
fi

exit 0
