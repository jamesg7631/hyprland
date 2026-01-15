#!/bin/bash

# 1. Get a list of IDs for workspaces that have windows (windows > 0)
#    We sort them numerically so the cycling order makes sense (1 -> 2 -> 3).
occupied_workspaces=$(hyprctl workspaces -j | jq -r 'map(select(.windows > 0)) | sort_by(.id) | .[].id')

# 2. Get the ID of the workspace you are currently on.
current_workspace=$(hyprctl activeworkspace -j | jq '.id')

# 3. Logic to find the NEXT workspace
target_workspace=""
first_workspace=""

for ws in $occupied_workspaces; do
    # Capture the very first occupied workspace in case we need to loop back to the start
    if [ -z "$first_workspace" ]; then
        first_workspace=$ws
    fi

    # If we find a workspace number higher than our current one, that's our target!
    if [ "$ws" -gt "$current_workspace" ]; then
        target_workspace=$ws
        break
    fi
done

# 4. If we didn't find a higher number (we are at the end), loop back to the first one.
if [ -z "$target_workspace" ]; then
    target_workspace=$first_workspace
fi

# 5. Tell Hyprland to switch to that workspace.
hyprctl dispatch workspace $target_workspace
