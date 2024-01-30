return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("mini.move").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		lazy = false,
		config = function()
			require("mini.surround").setup({
				silent = true,
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"echasnovski/mini.comment",
		lazy = false,
		version = "*",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
}
