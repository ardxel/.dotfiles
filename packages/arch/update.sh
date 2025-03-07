#!/usr/bin/env bash

PACMAN_FILE="/home/$USER/.dotfiles/packages/arch/pacman.txt"
AUR_FILE="/home/$USER/.dotfiles/packages/arch/aur.txt"

comm -23 <(pacman -Qqe | grep -v "nvidia" | sort) <(yay -Qmq | sort) >$PACMAN_FILE
yay -Qmq | grep -v "debug" >$AUR_FILE
