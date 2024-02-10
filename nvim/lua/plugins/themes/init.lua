---@param name string
local load_theme = function(name)
	local themes = {
		rose_pine = { theme = require("plugins.themes.rose-pine"), cmd_name = "rose-pine" },
		catppuccin = { theme = require("plugins.themes.catppuccin"), cmd_name = "catppuccin" },
		gruvbox_material = { theme = require("plugins.themes.gruvbox-material"), cmd_name = "gruvbox-material" },
		tokyo_night = { theme = require("plugins.themes.tokyo-night"), cmd_name = "tokyo-night" },
		gruvbox_base = { theme = require("plugins.themes.gruvbox-base"), cmd_name = "gruvbox-base" },
		kanagawa = { theme = require("plugins.themes.kanagawa"), cmd_name = "kanagawa" },
		oxocarbon = { theme = require("plugins.themes.oxocarbon"), cmd_name = "oxocarbon" },
	}

	return themes[name].theme
end

return load_theme("gruvbox_base")
