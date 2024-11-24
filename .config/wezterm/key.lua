local wezterm = require("wezterm")
local M = {}
local act = wezterm.action
M.mod = wezterm.target_triple:find("windows") and "SHIFT|CTRL" or "SHIFT|SUPER"

---@param config Config
M.setup = function(config)
	config.disable_default_key_bindings = true
	config.keys = {
		{ mods = "SUPER", key = "-", action = act.DecreaseFontSize },
		{ mods = "SUPER", key = "=", action = act.IncreaseFontSize },

		-- Clipboard
		{ mods = "SUPER", key = "c", action = act.CopyTo("Clipboard") },
		{ mods = "SUPER", key = "v", action = act.PasteFrom("Clipboard") },
	}
end

return M
