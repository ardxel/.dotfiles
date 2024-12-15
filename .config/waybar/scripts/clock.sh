#!/bin/bash

STATE_FILE="/tmp/waybar_clock_state"

TIME_FORMAT="{:%I:%M:%S}"
DATE_FORMAT="{:%d %B %Y}"

if [[ ! -f $STATE_FILE ]]; then
	echo "time" >$STATE_FILE
fi

STATE=$(cat $STATE_FILE)

if [[ "$STATE" == "time" ]]; then
	echo "$(date +"$TIME_FORMAT")"
else
	echo "$(date +"$DATE_FORMAT")"
fi

if [[ "$1" == "toggle" ]]; then
	if [[ "$STATE" == "time" ]]; then
		echo "date" >$STATE_FILE
	else
		echo "time" >$STATE_FILE
	fi
fi
