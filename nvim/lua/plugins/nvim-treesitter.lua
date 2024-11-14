return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			context = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"javascript",
				"typescript",
				"html",
				"xml",
				"css",
				"scss",
				"tsx",
				"jsdoc",
				"lua",
				"luadoc",
				"go",
				"json",
				"vimdoc",
				"yaml",
				"bash",
				"dockerfile",
				"markdown",
				"gitignore",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
