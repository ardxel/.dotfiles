#!/usr/bin/sh

# Change theme here
config="/home/$USER/.config/waybar/themes/modern/config.json"
style="/home/$USER/.config/waybar/themes/modern/style.css"

killall -q waybar
pkill waybar 2>/dev/null
sleep 0.5
waybar -c "$config" -s "$style" &>/dev/null &
