#!/bin/bash

options="  Cerrar sesión\n  Apagar\n  Reiniciar"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Energía" -lines 3)

case "$chosen" in
    "  Cerrar sesión") qtile cmd-obj -o cmd -f shutdown ;;
    "  Apagar")        systemctl poweroff ;;
    "  Reiniciar")     systemctl reboot ;;
esac
