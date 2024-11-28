local wezterm = require("wezterm")
local M = {}
local act = wezterm.action
M.mod = wezterm.target_triple:find("windows") and "SHIFT|CTRL" or "SHIFT|SUPER"

M.setup = function(config)
	config.disable_default_key_bindings = true
	config.keys = {
		{ mods = "SUPER", key = "-", action = act.DecreaseFontSize },
		{ mods = "SUPER", key = "=", action = act.IncreaseFontSize },

		-- Clipboard
		{ mods = "SUPER", key = "c", action = act.CopyTo("Clipboard") },
		{ mods = "SUPER", key = "v", action = act.PasteFrom("Clipboard") },
		{ mods = "CTRL|SHIFT", key = "L", action = act.ShowDebugOverlay },
		{
			mods = "CTRL|SHIFT",
			key = "I",
			action = wezterm.action.EmitEvent("toggle-image"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "O",
			action = wezterm.action.EmitEvent("increase-brightness"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "P",
			action = wezterm.action.EmitEvent("decrease-brightness"),
		},
	}
end

return M
