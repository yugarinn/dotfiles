#!/bin/bash

SCREEN_POS=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).rect | "\(.width)x\(.height)\\+\(.x)\\+\(.y)"')
XWAYLAND_OUTPUT=$(xrandr | rg -oP "[A-Z]+[0-9]+(?= [a-z]+ $SCREEN_POS)")
MONITOR_ID=$(rofi --help | rg $XWAYLAND_OUTPUT -B1 | sed -sr '/ID/!d;s/[^:]*:\s([0-9])/\1/')

WINDOWS=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" "+.app_id+": "+.name')
SELECTED=$(echo "$WINDOWS" | rofi -dmenu -i -m \"$MONITOR_ID\" | awk '{print $1}')

swaymsg [con_id="$SELECTED"] focus
