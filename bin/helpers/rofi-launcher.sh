#!/bin/sh

SCREEN_POS=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).rect | "\(.width)x\(.height)\\+\(.x)\\+\(.y)"')
XWAYLAND_OUTPUT=$(xrandr | rg -oP "[A-Z]+[0-9]+(?= [a-z]+ $SCREEN_POS)")
MONITOR_ID=$(rofi --help | rg $XWAYLAND_OUTPUT -B1 | sed -sr '/ID/!d;s/[^:]*:\s([0-9])/\1/')

rofi -show drun -m \"$MONITOR_ID\" $@ </dev/stdin
