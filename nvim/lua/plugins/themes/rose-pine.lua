local highlight_groups = {
	TelescopeBorder = { bg = "none" },
	TelescopeNormal = { bg = "none" },
	TelescopePromptNormal = { bg = "none" },
	TelescopeResultsNormal = { fg = "none", bg = "none" },
	TelescopeSelection = { fg = "text", bg = "none" },
	TelescopeSelectionCaret = { fg = "rose", bg = "none" },

	ColorColumn = { bg = "none" },

	-- Blend colours against the "base" background
	CursorLine = { bg = "none", blend = 10 },
	StatusLine = { fg = "none", bg = "none", blend = 10 },

	-- By default each group adds to the existing config.
	-- If you only want to set what is written in this config exactly,
	-- you can set the inherit option:
	Search = { bg = "none", inherit = false },

	["@keyword"] = { fg = "pine", bold = true },
	["@keyword.debug"] = { fg = "rose", bold = true },
	["@keyword.return"] = { fg = "pine", bold = true },
	["@keyword.import"] = { fg = "pine", bold = true },
	["@keyword.repeat"] = { fg = "pine", bold = true },
	["@keyword.function"] = { fg = "pine", bold = true },
	["@keyword.operator"] = { fg = "muted", bold = true },
	["@keyword.exception"] = { fg = "pine", bold = true },
	["@keyword.conditional"] = { fg = "pine", bold = true },

	["@method"] = { bold = true, fg = "rose" },
	["@method.call"] = { bold = true, fg = "rose" },
	["@function.method.call"] = { bold = true, fg = "rose" },
}

return {
	"rose-pine/neovim",
	lazy = false,
	priority = 1000,
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			bold_vert_split = false,
			dim_inactive_windows = false,
			disable_background = true,
			disable_float_background = true,
			styles = {
				bold = true,
				italic = false,
				transparency = true,
			},
			-- Change specific vim highlight groups
			-- https://github.com/rose-pine/neovim/wiki/Recipes
			highlight_groups = highlight_groups,
		})

		vim.cmd("colorscheme rose-pine")
		-- vim.cmd("colorscheme rose-pine-main")
		vim.cmd("colorscheme rose-pine-moon")
		-- vim.cmd("colorscheme rose-pine-dawn")

		require("plugins.themes.after-load")()
	end,
}
