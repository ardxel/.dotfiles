local M = {}

M.colors = {
	fg_light = "#ebdbb2",
	fg_dark = "#7c6f64",
	bg_light = "#d5c4a1",
	bg_dark = "black",
}

M.themes = {
	dark = { "vague" },
	ligth = { "gruvbox" },
}

M._dark_theme = {
	normal = {
		a = { bg = M.colors.bg_dark, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		z = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
	},
	insert = {
		a = { bg = M.colors.bg_dark, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
	},
	visual = {
		a = { bg = M.colors.bg_dark, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
	},
	replace = {
		a = { bg = M.colors.bg_dark, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
	},
	command = {
		a = { bg = M.colors.bg_dark, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
	},
	inactive = {
		a = { bg = M.colors.bg_dark, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_dark, fg = M.colors.fg_dark },
	},
}

M._light_theme = {
	normal = {
		a = { bg = M.colors.bg_light, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		z = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
	},
	insert = {
		a = { bg = M.colors.bg_light, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
	},
	visual = {
		a = { bg = M.colors.bg_light, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
	},
	replace = {
		a = { bg = M.colors.bg_light, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
	},
	command = {
		a = { bg = M.colors.bg_light, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
	},
	inactive = {
		a = { bg = M.colors.bg_light, fg = M.colors.fg_dark, gui = "bold" },
		b = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
		c = { bg = M.colors.bg_light, fg = M.colors.fg_dark },
	},
}

M.get_config = function()
	local icons = require("config.icons")
	local utils = require("utils")

	local location = {
		"location",
		fmt = function()
			local line = vim.fn.line(".")
			local col = vim.fn.virtcol(".")
			local total_lines = vim.fn.line("$")

			return string.format("( %2d:%s:%-2d )", line, col, total_lines)
		end,
	}

	--- Visual Multi Mode
	--- @see https://github.com/nvim-lualine/lualine.nvim/issues/951
	local mode = {
		"mode",
		fmt = function(mode)
			return vim.iter(string.gmatch(vim.fn["vm#themes#statusline"](), "%S+")):nth(2) or mode
		end,
	}

	local filetype = {
		"filetype",
		icon_only = true,
	}

	local diff = {
		"diff",
		source = function()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end,
		symbols = {
			added = icons.git.GitAdd .. " ",
			modified = icons.git.GitChange .. " ",
			removed = icons.git.GitDelete .. " ",
		},
		colored = true,
		always_visible = false,
	}

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn", "info", "hint" },
		symbols = {
			error = icons.diagnostics.Error .. " ",
			hint = icons.diagnostics.Hint .. " ",
			info = icons.diagnostics.Info .. " ",
			warn = icons.diagnostics.Warning .. " ",
		},
		colored = true,
		update_in_insert = false,
		always_visible = false,
	}

	local theme = utils.is_dark_mode() and M._dark_theme or M._light_theme
	return {
		options = {
			theme = theme,
			globalstatus = true,
			section_separators = "",
			component_separators = "",
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { "branch" },
			lualine_c = {
				"filename",
			},
			lualine_x = {
				diff,
				diagnostics,
				filetype,
			},
			lualine_y = {},
			lualine_z = { location },
		},
	}
end

M.update_theme = function(config)
	local utils = require("utils")
	config = vim.tbl_deep_extend("force", {}, config, {
		options = {
			theme = utils.is_dark_mode() and M._dark_theme or M._light_theme,
		},
	})
	return config
end

return M
