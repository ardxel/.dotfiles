return {
	{
		"vague2k/vague.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
		},
		config = function(_, opts)
			require("vague").setup(opts)
			vim.cmd.colorscheme("vague")
		end,
	},
	{
		"navarasu/onedark.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			style = "light", -- dark | darker | cool | deep | warm | warmer | light
			-- transparent = true,
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = false, -- use undercurl instead of underline for diagnostics
				background = false, -- use background color for virtual text
			},
		},
		config = function(_, opts)
			local utils = require("utils")
			local pywal_mode = utils.pywal_mode()

			opts.style = pywal_mode == "dark" and "cool" or "warmer"
			opts.transparent = pywal_mode == "dark"
			local onedark = require("onedark")
			onedark.setup(opts)
			onedark.load()

			if pywal_mode == "dark" then
				vim.api.nvim_set_hl(0, "Illuminate", { bg = "#504945" })
				vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Illuminate" })
				vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Illuminate" })
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Illuminate" })
				vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" }) -- cmp-border transparent
				vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" }) -- lsp window transparent
			end
		end,
	},
	{
		"rose-pine/neovim",
		enabled = true,
		lazy = false,
		priority = 1000,
		name = "rose-pine",
		opts = {
			styles = {
				italic = false,
			},
		},
		config = function(_, opts)
			local utils = require("utils")
			local pywal_mode = utils.pywal_mode()

			opts.variant = pywal_mode == "dark" and "main" or "dawn"
			opts.styles.transparency = pywal_mode == "dark"
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
