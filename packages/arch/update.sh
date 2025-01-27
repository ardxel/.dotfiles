#!/usr/bin/sh

comm -23 <(pacman -Qqe | sort) <(yay -Qmq | sort) > pacman.txt
yay -Qmq > aur.txt
