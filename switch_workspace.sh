
#!/bin/bash

# Get current workspace ID
current_ws=$(hyprctl activeworkspace -j | jq '.id')

# Max number of workspaces
max_ws=10

# Arguments:
# $1: direction ("next" or "prev")
# $2: optional flag "move" to move window instead of switching

direction=$1
mode=$2

if [ "$direction" == "next" ]; then
    new_ws=$(( (current_ws % max_ws) + 1 ))
elif [ "$direction" == "prev" ]; then
    new_ws=$(( (current_ws - 2 + max_ws) % max_ws + 1 ))
else
    echo "Invalid direction: $direction"
    exit 1
fi

if [ "$mode" == "move" ]; then
    hyprctl dispatch movetoworkspace "$new_ws"
else
    hyprctl dispatch workspace "$new_ws"
fi

