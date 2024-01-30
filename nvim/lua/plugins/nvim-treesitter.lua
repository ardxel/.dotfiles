return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,

	config = function()
		require("nvim-treesitter.configs").setup({
			context = {
				enable = true,
			},
			indent = { enable = true },
			autotag = { enable = true },
			ensure_installed = {
				-- frontend
				"javascript",
				"typescript",
				"html",
				"xml",
				"css",
				"scss",
				"tsx",
				"jsdoc",

				-- lua
				"lua",
				"luadoc",

				-- other
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
				custom_captures = {
					["keyword"] = "Bold",
				},
			},
			rainbow = {
				enable = true,
				extended_mode = true,
			},
		})
	end,
}
