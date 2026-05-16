#!/bin/bash

current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(yes|no)')

if [ "$mute" = "yes" ]; then
    mute_label="󰕾  Activar sonido"
else
    mute_label="󰖁  Silenciar"
fi

options="󰝝  Subir volumen (+10%)\n󰝞  Bajar volumen (-10%)\n$mute_label\n󰕾  25%\n󰕾  50%\n󰕾  75%\n󰕾  100%"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Volumen: ${current}%" -lines 7)

case "$chosen" in
    "󰝝  Subir volumen (+10%)") pactl set-sink-volume @DEFAULT_SINK@ +10% ;;
    "󰝞  Bajar volumen (-10%)") pactl set-sink-volume @DEFAULT_SINK@ -10% ;;
    "󰖁  Silenciar")            pactl set-sink-mute @DEFAULT_SINK@ 1 ;;
    "󰕾  Activar sonido")       pactl set-sink-mute @DEFAULT_SINK@ 0 ;;
    "󰕾  25%")                  pactl set-sink-volume @DEFAULT_SINK@ 25% ;;
    "󰕾  50%")                  pactl set-sink-volume @DEFAULT_SINK@ 50% ;;
    "󰕾  75%")                  pactl set-sink-volume @DEFAULT_SINK@ 75% ;;
    "󰕾  100%")                 pactl set-sink-volume @DEFAULT_SINK@ 100% ;;
esac
