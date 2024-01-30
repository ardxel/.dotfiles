---@param name string
local load_theme = function(name)
	local themes = {
		rose_pine = { theme = require("plugins.themes.rose-pine"), cmd_name = "rose-pine" },
		catppuccin = { theme = require("plugins.themes.catppuccin"), cmd_name = "catppuccin" },
		gruvbox_base = { theme = require("plugins.themes.gruvbox-base"), cmd_name = "gruvbox-base" },
		gruvbox_material = { theme = require("plugins.themes.gruvbox-material"), cmd_name = "gruvbox-material" },
		kanagawa = { theme = require("plugins.themes.kanagawa"), cmd_name = "kanagawa" },
	}

	if themes[name] == nil then
		for n, theme in pairs(themes) do
			if theme.cmd_name == name then
				return themes[n].theme
			end
		end
	end

	return themes[name].theme
end

return load_theme("gruvbox_material")
