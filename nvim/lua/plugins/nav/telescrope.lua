return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>ff",
			function()
				local builtin = require("telescope.builtin")
				builtin.find_files({
					no_ignore = false,
					hidden = true,
				})
			end,
			desc = "find files in your current working directory, respect .gitignore",
		},
		{
			"<leader>fF",
			function()
				local builtin = require("telescope.builtin")
				builtin.find_files({
					no_ignore = true,
					hidden = false,
				})
			end,
			desc = "find files in your current working directory, no respect .gitignore",
		},
		{
			"<leader>fg",
			function()
				local builtin = require("telescope.builtin")
				builtin.live_grep({
					additional_args = { "--hidden" },
				})
			end,
			desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
		},
		{
			"<leader>fb",
			function()
				local builtin = require("telescope.builtin")
				builtin.buffers()
			end,
			desc = "show buffers",
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = { prompt_position = "top", preview_width = 0.55 },
					vertical = { mirror = false },
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
			},
		})
	end,
}
