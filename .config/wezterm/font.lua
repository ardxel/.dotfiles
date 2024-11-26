local wezterm = require("wezterm")
local M = {}

---@param config Config
M.setup = function(config)
	config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	config.font = wezterm.font_with_fallback({
		"FiraCode Nerd Font",
		"Noto Color Emoji",
		"Symbols Nerd Font",
	})

	config.font_rules = {
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "FiraCode Nerd Font",
				weight = 450,
				style = "Normal",
			}),
		},
		{
			intensity = "Normal",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font",
				weight = 450,
				style = "Normal",
			}),
		},
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "FiraCode Nerd Font",
				weight = 500,
				style = "Normal",
			}),
		},
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font",
				weight = "Medium",
				style = "Normal",
			}),
		},
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "FiraCode Nerd Font",
				weight = "Bold",
				style = "Normal",
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "FiraCode Nerd Font",
				weight = "Bold",
				style = "Normal",
			}),
		},
	}
end

return M
