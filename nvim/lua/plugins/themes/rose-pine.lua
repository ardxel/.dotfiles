local groups = {
	background = "base",
	background_nc = "_experimental_nc",
	panel = "surface",
	panel_nc = "base",
	border = "highlight_med",
	comment = "muted",
	link = "iris",
	punctuation = "subtle",

	error = "love",
	hint = "iris",
	info = "foam",
	warn = "gold",

	headings = {
		h1 = "iris",
		h2 = "foam",
		h3 = "rose",
		h4 = "gold",
		h5 = "pine",
		h6 = "foam",
	},
}

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
	Search = { bg = "gold", inherit = false },
}

return {
	"rose-pine/neovim",
	enabled = false,
	lase = false,
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			--- @usage 'auto'|'main'|'moon'|'dawn'
			variant = "auto",
			--- @usage 'main'|'moon'|'dawn'
			dark_variant = "main",
			bold_vert_split = false,
			dim_nc_background = true,
			disable_background = true,
			disable_float_background = true,
			disable_italics = false,

			--- @usage string hex value or named color from rosepinetheme.com/palette
			groups = groups,

			-- Change specific vim highlight groups
			-- https://github.com/rose-pine/neovim/wiki/Recipes
			highlight_groups = highlight_groups,
		})
		vim.cmd("hi Function gui=bold cterm=bold")

		vim.cmd("colorscheme rose-pine")

		vim.cmd("hi Function gui=bold cterm=bold")
		require("plugins.themes.after-load")()
	end,
}
