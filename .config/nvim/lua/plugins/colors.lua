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
		lazy = false,
		priority = 1000,
		opts = {
			style = "dark", -- dark | darker | cool | deep | warm | warmer | light
			-- transparent = true,
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = false, -- use undercurl instead of underline for diagnostics
				background = false, -- use background color for virtual text
			},
		},
		config = function(_, opts)
			opts.transparent = opts.style == "dark"
			local onedark = require("onedark")
			onedark.setup(opts)
			onedark.load()

			if opts.style == "dark" then
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
		"ellisonleao/gruvbox.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {},
		config = function(_, opts)
			vim.o.background = "light"
			require("gruvbox").setup(opts)
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{

		"jnurmine/Zenburn",
		enabled = false,
		lazy = false,
		priority = 1000,
		init = function()
			vim.g.zenburn_transparent = 1
			vim.g.zenburn_disable_Label_underline = 1
			vim.cmd("colors zenburn")
		end,
	},
}
