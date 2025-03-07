#!/usr/bin/env bash

colors_file="$HOME/.cache/wal/colors.sh"
config_file="$HOME/.config/starship/starship.toml"
mode=$(cat "$HOME/.cache/wal/mode")

if [[ ! -f "$colors_file" ]]; then
	echo "Error: colors file not found."
	exit 1
fi

sed -i "/^\[palettes\.pywal\]/,\$d" "$config_file"

. "$colors_file"

cat <<EOF >>"$config_file"
[palettes.pywal]
primary = "$color0"
secondary = "$color1"
accent = "$color3"
background = "$background"
surface = "$color4"
text_primary = "$foreground"
text_secondary = "$color6"
success = "#80c995"
warning = "$color7"
error = "#e74c3c" 
info = "$color5"
EOF
