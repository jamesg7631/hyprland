#!/bin/bash

HANDLER_SCRIPT="$HOME/.config/hypr/scripts/workspace-handler.sh"

socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  if [[ $line == "monitoradded>>"* || $line == "monitorremoved>>"* ]]; then
    $HANDLER_SCRIPT
  fi
done
