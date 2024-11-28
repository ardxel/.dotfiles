return {
	{
		"vague2k/vague.nvim",
		lazy = false,
		opts = {
			transparent = true,
		},
		config = function(_, opts)
			require("vague").setup(opts)
			vim.cmd.colorscheme("vague")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		-- lazy = false,
		-- priority = 1000,
		opts = {},
		config = function(_, opts)
			vim.o.background = "light"
			require("gruvbox").setup(opts)
			-- vim.cmd.colorscheme("gruvbox")
		end,
	},
}
