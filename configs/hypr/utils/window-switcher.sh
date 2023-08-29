#!/bin/bash

WINDOW=$(hyprctl clients | grep "class: " | awk '/class: [^ ]/ {gsub("class: ", ""); sub(/^[ \t]*/, ""); print $0}' | wofi --show dmenu -in)

if [ "$WINDOW" = "" ]; then
    return
fi

hyprctl dispatch focuswindow $WINDOW
