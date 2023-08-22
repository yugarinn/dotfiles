#!/bin/bash

WINDOW=$(hyprctl clients | grep "class: " | awk '/class: [^ ]/ {gsub("class: ", ""); sub(/^[ \t]*/, ""); print $0}' | wofi --show dmenu -i)

if [ "$WINDOW" = "" ]; then
    exit
fi

hyprctl dispatch focuswindow $WINDOW
