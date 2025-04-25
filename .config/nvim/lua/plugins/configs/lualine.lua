local M = {}
M.colors = {}
M.current = "pywal"
M.pywal_mode = "dark"

M.colors.default = {
	primary = "#1a3a34",
	secondary = "#0d1b2a",
	accent = "#ff8c42",
	surface = "#a6a6a6",
	bg = "#0b1d2c",
	text_primary = "#e5e5e5",
	text_secondary = "#7abf91",
	dark_success = "#00ffab",
	dark_warning = "#ffc857",
	dark_error = "#ff4e50",
	light_success = "#00a800",
	light_warning = "#ffbf00",
	light_error = "#d9534f",
	info = "#5bc0eb",
}

M.parse_pywal_colors = function()
	local utils = require("utils")
	pywal = utils.read_pywal_colors()

	M.colors.pywal = {
		primary = pywal.colors.color0,
		secondary = pywal.colors.color1,
		accent = pywal.colors.color4,
		bg = pywal.special.background,
		surface = pywal.colors.color10,
		text_primary = pywal.special.foreground,
		text_secondary = pywal.colors.color6,
		dark_success = "#00ffab",
		dark_warning = "#ffc857",
		dark_error = "#ff4e50",
		light_success = "#00a800",
		light_warning = "#ffbf00",
		light_error = "#d9534f",
		info = pywal.colors.color5,
	}

	local mode_file = io.open(os.getenv("HOME") .. "/.cache/wal/mode", "r")
	assert(mode_file)
	local mode = mode_file:read("*a")
	mode_file:close()
	mode = mode:gsub("%s+", "")
	mode = string.gsub(mode, "%s+", "")
	M.pywal_mode = mode
end

M.theme = function(theme)
	local c = M.colors[theme]
	return {
		normal = {
			a = { bg = c.bg, fg = c.surface, gui = "bold" },
			b = { bg = c.bg, fg = c.text_primary },
			c = { bg = c.bg, fg = c.accent },
			x = { bg = c.bg },
			y = { bg = c.bg },
			z = { bg = c.bg },
		},
		insert = {
			a = { bg = c.bg, fg = c.surface, gui = "bold" },
			b = { bg = c.bg, fg = c.text_primary },
			c = { bg = c.bg, fg = c.accent },
			x = { bg = c.bg },
			y = { bg = c.bg },
			z = { bg = c.bg },
		},
		visual = {
			a = { bg = c.bg, fg = c.surface, gui = "bold" },
			b = { bg = c.bg, fg = c.text_primary },
			c = { bg = c.bg, fg = c.accent },
			x = { bg = c.bg },
			y = { bg = c.bg },
			z = { bg = c.bg },
		},
		replace = {
			a = { bg = c.bg, fg = c.surface, gui = "bold" },
			b = { bg = c.bg, fg = c.text_primary },
			c = { bg = c.bg, fg = c.accent },
			x = { bg = c.bg },
			y = { bg = c.bg },
			z = { bg = c.bg },
		},
		command = {
			a = { bg = c.bg, fg = c.surface, gui = "bold" },
			b = { bg = c.bg, fg = c.text_primary },
			c = { bg = c.bg, fg = c.accent },
			x = { bg = c.bg },
			y = { bg = c.bg },
			z = { bg = c.bg },
		},
		inactive = {
			a = { bg = c.bg, fg = c.surface, gui = "bold" },
			b = { bg = c.bg, fg = c.text_primary },
			c = { bg = c.bg, fg = c.accent },
			x = { bg = c.bg },
			y = { bg = c.bg },
			z = { bg = c.bg },
		},
	}
end

M.config = function(pywal)
	if pywal then
		M.parse_pywal_colors()
	end
	local icons = require("config.icons")
	local colors = M.colors[M.current]

	local branch = {
		"branch",
	}

	local filename = {
		"filename",
		path = 4,
	}

	local location = {
		"location",
		fmt = function()
			local line = vim.fn.line(".")
			local col = vim.fn.virtcol(".")
			local total_lines = vim.fn.line("$")

			return string.format("%2d:%s:%-2d", line, col, total_lines)
		end,
	}

	local diff_color = (function()
		if M.current == "pywal" and M.pywal_mode == "light" then
			return {
				added = { fg = colors.light_success },
				modified = { fg = colors.light_warning },
				removed = { fg = colors.light_error },
			}
		end
		return {
			added = { fg = colors.dark_success },
			modified = { fg = colors.dark_warning },
			removed = { fg = colors.dark_error },
		}
	end)()

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
		diff_color = diff_color,
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

	return {
		options = {
			theme = M.theme(M.current),
			globalstatus = true,
			section_separators = "",
			component_separators = "",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { branch },
			lualine_c = { filename },
			lualine_x = { diff, diagnostics, filetype },
			lualine_y = {},
			lualine_z = { location },
		},
	}
end

return M
