return {
	{
		"rose-pine/neovim",
		lazy = false,
		enabled = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				disable_background = true,
				disable_float_background = true,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				palette = {
					main = {
						gold = "#d4a15e",
					},
					moon = {
						gold = "#d4a15e",
					},
				},
			})

			-- vim.cmd("colorscheme rose-pine")
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = require("rose-pine.palette").foam, bg = "NONE" })
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
		},
		config = function(_, opts)
			require("vague").setup(opts)
			vim.cmd("colorscheme vague")
		end,
	},
}