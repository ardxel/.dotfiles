local wezterm = require("wezterm")
local M = {}

M.setup = function(config)
	config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	config.font = wezterm.font_with_fallback({
		"FiraCode Nerd Font Mono",
		"Noto Color Emoji",
		"Symbols Nerd Font",
	})

	config.font_rules = {
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = 500,
				style = "Normal",
			}),
		},
		{
			intensity = "Normal",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = 500,
				style = "Normal",
			}),
		},
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = "Medium",
				style = "Normal",
			}),
		},
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = "Medium",
				style = "Normal",
			}),
		},
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = "Bold",
				style = "Normal",
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "FiraCode Nerd Font Mono",
				weight = "Bold",
				style = "Normal",
			}),
		},
	}
end

return M
