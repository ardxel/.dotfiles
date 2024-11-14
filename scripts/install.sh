#!/bin/bash

if ! command -v brews &>/dev/null; then
	echo "BREW NOT INSTALLED"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -f "$HOME/.config/Brewfile" ]; then
	brew bundle --file="$HOME/.config/Brewfile"
fi

echo 'export ZDOTDIR="$HOME/.config"' >> "$HOME/.zshenv"
echo 'export XDG_CACHE_HOME="$HOME/.cache"' >> "$HOME/.zshenv"
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> "$HOME/.zshenv"
echo 'export XDG_DATA_HOME="$HOME/.local/share"' >> "$HOME/.zshenv"
