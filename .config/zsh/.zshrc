export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export CONFIG="$HOME/.config"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
export LS_COLORS="$(vivid generate alabaster_dark)"
export STARSHIP_CONFIG="$CONFIG/starship/starship.toml"
export NODE_PATH="$(npm root --quiet -g)"

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
source "$CONFIG/zsh/.aliases"
source "$CONFIG/zsh/.func"
source "$CONFIG/zsh/.plugins"
source "$HOME/.cargo/env"

eval "$(starship init zsh)"
