return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	config = function()
		-- Default options:
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = { bold = false, italic = false },
			keywordStyle = { bold = true, italic = false },
			statementStyle = { bold = true, italic = false },
			typeStyle = { bold = true, italic = false },
			transparent = true, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")

		require("plugins.themes.after-load")()
	end,
}
