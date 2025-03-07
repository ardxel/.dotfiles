#!/usr/bin/env bash

wal_config_file="$HOME/.cache/wal/colors.json"
if [ ! -f "$wal_config_file" ]; then
	echo "Error: config file is not exists"
	echo "Try use walw -i <image.png>"
	exit 1
fi

active_theme="$(jq -r ".wallpaper" "$wal_config_file")"
if [ ! -f "$active_theme" ]; then
	echo "Error: active wallpaper image is not exists"
	exit 1
fi

listloaded="$(hyprctl hyprpaper listloaded)"
if ! echo "$listloaded" | grep -s "$active_theme" >/dev/null; then
	hyprctl hyprpaper preload "$active_theme"
fi

hyprctl hyprpaper wallpaper ,"$active_theme"
