#!/bin/bash

# 1. Get occupied workspaces, but sort them in REVERSE order (e.g., 3, 2, 1)
#    This allows us to look "downwards" from our current position.
occupied_workspaces=$(hyprctl workspaces -j | jq -r 'map(select(.windows > 0)) | sort_by(.id) | reverse | .[].id')

# 2. Get current workspace ID
current_workspace=$(hyprctl activeworkspace -j | jq '.id')

# 3. Logic to find the PREVIOUS workspace
target_workspace=""
highest_workspace=""

for ws in $occupied_workspaces; do
    # Capture the highest number (first in list) for wrapping around
    if [ -z "$highest_workspace" ]; then
        highest_workspace=$ws
    fi

    # If we find a workspace number LOWER than current, that's our target!
    if [ "$ws" -lt "$current_workspace" ]; then
        target_workspace=$ws
        break
    fi
done

# 4. If no lower number found, wrap around to the highest number.
if [ -z "$target_workspace" ]; then
    target_workspace=$highest_workspace
fi

# 5. Switch
hyprctl dispatch workspace $target_workspace
