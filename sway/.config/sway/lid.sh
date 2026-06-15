#!/bin/bash
# Smart lid switch handler - only disable laptop display if external monitor is connected

# Check if any external outputs are connected (non-eDP outputs that are active)
external_connected=$(swaymsg -t get_outputs | jq -r '.[] | select(.type == "output" and .active == true and (.name | startswith("eDP") | not)) | .name' | head -1)

if [ -n "$external_connected" ]; then
    swaymsg output eDP-1 disable
fi
