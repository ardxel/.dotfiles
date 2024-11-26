local wezterm = require("wezterm") --[[@as Wezterm]]
local config = wezterm.config_builder()

require("key").setup(config)
require("font").setup(config)
require("links").setup(config)
require("color").setup(config)

config.font_size = 16
config.adjust_window_size_when_changing_font_size = false
config.automatically_reload_config = true
config.enable_tab_bar = false
config.bold_brightens_ansi_colors = true
return config
