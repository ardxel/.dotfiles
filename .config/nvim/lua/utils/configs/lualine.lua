local M = {}

M.colors = {
	primary = "#1a3a34",
	secondary = "#0d1b2a",
	accent = "#ff8c42",
	background = "#0b1d2c",
	surface = "#a6a6a6",
	text_primary = "#e5e5e5",
	text_secondary = "#7abf91",
	success = "#00ffab",
	warning = "#ffc857",
	error = "#ff4e50",
	info = "#5bc0eb",
	transparent = nil,
}

M._dark_theme = {
	normal = {
		a = { bg = M.colors.background, fg = M.colors.surface, gui = "bold" },
		b = { bg = M.colors.background, fg = M.colors.text_primary },
		c = { bg = M.colors.background },
		x = { bg = M.colors.background },
		y = { bg = M.colors.background },
		z = { bg = M.colors.background },
	},
	insert = {
		a = { bg = M.colors.background, fg = M.colors.surface, gui = "bold" },
		b = { bg = M.colors.background, fg = M.colors.text_primary },
		c = { bg = M.colors.background },
		x = { bg = M.colors.background },
		y = { bg = M.colors.background },
		z = { bg = M.colors.background },
	},
	visual = {
		a = { bg = M.colors.background, fg = M.colors.surface, gui = "bold" },
		b = { bg = M.colors.background, fg = M.colors.text_primary },
		c = { bg = M.colors.background },
		x = { bg = M.colors.background },
		y = { bg = M.colors.background },
		z = { bg = M.colors.background },
	},
	replace = {
		a = { bg = M.colors.background, fg = M.colors.surface, gui = "bold" },
		b = { bg = M.colors.background, fg = M.colors.text_primary },
		c = { bg = M.colors.background },
		x = { bg = M.colors.background },
		y = { bg = M.colors.background },
		z = { bg = M.colors.background },
	},
	command = {
		a = { bg = M.colors.background, fg = M.colors.surface, gui = "bold" },
		b = { bg = M.colors.background, fg = M.colors.text_primary },
		c = { bg = M.colors.background },
		x = { bg = M.colors.background },
		y = { bg = M.colors.background },
		z = { bg = M.colors.background },
	},
	inactive = {
		a = { bg = M.colors.background, fg = M.colors.surface, gui = "bold" },
		b = { bg = M.colors.background, fg = M.colors.text_primary },
		c = { bg = M.colors.background },
		x = { bg = M.colors.background },
		y = { bg = M.colors.background },
		z = { bg = M.colors.background },
	},
}

M.get_config = function()
	local icons = require("config.icons")

	local branch = {
		"branch",
		color = { fg = M.colors.text_primary },
	}

	local filename = {
		"filename",
		path = 4,
		color = { fg = M.colors.info },
	}

	local location = {
		"location",
		fmt = function()
			local line = vim.fn.line(".")
			local col = vim.fn.virtcol(".")
			local total_lines = vim.fn.line("$")

			return string.format("%2d:%s:%-2d", line, col, total_lines)
		end,
		color = { fg = M.colors.text_primary },
	}

	--- Visual Multi Mode
	--- @see https://github.com/nvim-lualine/lualine.nvim/issues/951
	local mode = {
		"mode",
		fmt = function(mode)
			local ok, extra_mode = pcall(function()
				return vim.iter(string.gmatch(vim.fn["vm#themes#statusline"](), "%S+")):nth(2)
			end)
			return ok and extra_mode or mode
		end,
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
		diff_color = {
			added = "LuaLineDiffAddSpace", -- Changes the diff's added color
			modified = "LuaLineDiffChangeSpace", -- Changes the diff's modified color
			removed = "LuaLineDiffDeleteSpace", -- Changes the diff's removed color you
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

	local filetype = {
		"filetype",
		icon_only = true,
	}

	-- local theme = utils.is_dark_mode() and M._dark_theme or M._light_theme
	local theme = M._dark_theme
	return {
		options = {
			theme = theme,
			globalstatus = true,
			section_separators = "",
			component_separators = "",
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { branch },
			lualine_c = { filename },
			lualine_x = { diff, diagnostics, filetype },
			lualine_y = {},
			lualine_z = { location },
		},
	}
end

return M
