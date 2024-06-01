return {
	{ "vimpostor/vim-tpipeline" },
	{ "windwp/nvim-autopairs", opts = {} },
	{ "folke/neodev.nvim" },
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
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
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
