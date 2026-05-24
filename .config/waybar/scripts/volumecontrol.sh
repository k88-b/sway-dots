#!/bin/bash

ICON=""

icodir="/home/kostya/.config/waybar/icons/vol"

notify_vol () {
    angle="$(( (($vol + 2) / 5) * 5 ))"
    ico="${icodir}/vol-${angle}.svg"
    echo $VOLUME
    bar=$(seq -s "." $(($vol / 15)) | sed 's/[0-9]//g')
    notify-send "Changed volume" -a "Volume Control" -r 3333 -t 800 -i "${ico}" "${vol}\n${bar}" 
}

change_volume() {
    case $1 in
        "up")
            pactl set-sink-volume @DEFAULT_SINK@ +5%
            
            ;;
        "down")
            pactl set-sink-volume @DEFAULT_SINK@ -5%
            ;;
        "toggle")
            pactl set-sink-mute @DEFAULT_SINK@ toggle
			notify-send "Muted" -a "Volume Control" -r 3333 -t 800  
            ;;
    esac
}
icodir="/home/kostya/.config/waybar/icons/vol"

case $1 in
    "up")
        change_volume "up"
        ;;
    "down")
        change_volume "down"
        ;;
    "toggle")
        change_volume "toggle"
        ;;
esac


vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n 1)
vol=${vol%\%}
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n 1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    echo "$ICON Muted"
else
    echo "$ICON $VOLUME"
fi

# notify_vol
