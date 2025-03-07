#!/usr/bin/sh

if pgrep waybar = ""; then
	./launcher.sh
fi

while inotifywait -e modify -r ./; do
	./launcher.sh
done

./launcher.sh
