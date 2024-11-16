return {
	{ "windwp/nvim-autopairs", opts = {} },
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local neogen = require("neogen")
			neogen.setup({
				enabled = true,
				input_after_comment = true,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
}
