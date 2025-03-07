#!/usr/bin/sh

script_name=$(basename "$0")
instance_count=$(ps aux | grep -F "$script_name" | grep -v grep | grep -v $$ | wc -l)

if [ "$instance_count" -gt 1 ]; then
	sleep "$instance_count"
fi

updates="$(checkupdates-with-aur)"
count="$(echo "$updates" | wc -l)"
updates="$(echo "$updates" | sed -z 's/\n/\\n/g')"

if [ "$count" -gt 1 ]; then
	printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "red"}' "$count" "$count" "$updates"
else
	printf '{"text": "none", "alt": "0", "tooltip": "none"}'
fi
