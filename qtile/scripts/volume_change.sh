#!/bin/bash
# $1 = +5% | -5% | toggle

pactl set-sink-mute @DEFAULT_SINK@ 0 2>/dev/null

if [ "$1" = "toggle" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
else
    pactl set-sink-volume @DEFAULT_SINK@ "$1"
fi

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(yes|no)')

if [ "$mute" = "yes" ]; then
    notify-send -t 1500 -h string:synchronize:volume "󰖁  Silenciado"
else
    notify-send -t 1500 -h int:value:"$vol" -h string:synchronize:volume "󰕾  Volumen: ${vol}%"
fi
