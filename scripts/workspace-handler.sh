#!/bin/bash

# A small delay to ensure monitors are fully initialized
sleep 1

# --- YOUR MONITOR CONFIGURATION ---
LAPTOP="eDP-1"
DELL_LEFT="desc:Dell Inc. DELL S2421HN J0RJC23"
DELL_RIGHT="desc:Dell Inc. DELL S2421HN 70RJC23"

# --- SCRIPT LOGIC ---
MONITOR_COUNT=$(hyprctl monitors -j | jq length)

if [ "$MONITOR_COUNT" -ge 3 ]; then
  # DOCKED: Apply your specific pinning rules
  hyprctl keyword workspace "1, monitor:$LAPTOP, persistent:true"
  hyprctl keyword workspace "2, monitor:$DELL_RIGHT, persistent:true"
  hyprctl keyword workspace "3, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "4, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "5, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "6, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "7, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "8, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "9, monitor:$DELL_LEFT, persistent:true"
  hyprctl keyword workspace "10, monitor:$DELL_LEFT, persistent:true"
else
  # UNDOCKED: Un-pin ALL workspaces
  for i in {1..10}; do
    hyprctl keyword workspace "$i, monitor:, persistent:true"
  done
fi
