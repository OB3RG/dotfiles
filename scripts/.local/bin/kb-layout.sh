#!/usr/bin/env bash
# Keyboard layout indicator for waybar

get_layout() {
    local layout
    layout=$(swaymsg -t get_inputs | grep -o '"xkb_active_layout_name": "[^"]*"' | head -n1 | sed 's/"xkb_active_layout_name": "//;s/"//')
    case "$layout" in
        *English*US*) echo "US" ;;
        *Swedish*)    echo "SE" ;;
        *)            echo "${layout:0:2}" ;;
    esac
}

# Output loop with polling
while true; do
    echo "{\"text\": \"$(get_layout)\"}"
    sleep 1
done
