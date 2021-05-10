#!/bin/bash

# Get available windows
WINDOWS=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" "+.app_id+": "+.name')
# Select window with rofi
SELECTED=$(echo "$WINDOWS" | rofi -dmenu -i | awk '{print $1}')



# Tell sway to focus said window
swaymsg [con_id="$SELECTED"] focus
