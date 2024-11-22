return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			context = { enable = true },
			ensure_installed = {
				"javascript",
				"typescript",
				"html",
				"xml",
				"css",
				"scss",
				"tsx",
				"jsdoc",
				"regex",
				"lua",
				"luadoc",
				"go",
				"vim",
				"json",
				"vimdoc",
				"yaml",
				"bash",
				"dockerfile",
				"markdown",
				"markdown_inline",
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
	{
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "LazyFile",
		opts = {},
	},
}
