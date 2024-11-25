local wezterm = require("wezterm")
local M = {}

---@param config Config
M.setup = function(config)
	config.font = wezterm.font({ family = "Fira Code", weight = "Regular" })
	config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

	config.font_rules = {
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "Fira Code",
				weight = "Regular",
				style = "Normal",
			}),
		},
		{
			intensity = "Normal",
			italic = false,
			font = wezterm.font({
				family = "Fira Code",
				weight = "Regular",
				style = "Normal",
			}),
		},
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "Fira Code",
				weight = "DemiBold",
				style = "Normal",
			}),
		},
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font({
				family = "Fira Code",
				weight = "DemiBold",
				style = "Normal",
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "Fira Code",
				weight = "Bold",
				style = "Normal",
			}),
		},
	}
end

return M
