return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>"),
		vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>"),
		vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>"),
		vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>"),
	},
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					hidden = true,
					file_ignore_patterns = { "node_modules", ".git" },
				},
				live_grep = {
					hidden = true,
					file_ignore_patterns = {
						"node_modules",
						".git",
						"lazy%-lock.json",
						"yarn.lock",
						"package%-lock.json",
					},
				},
			},
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
