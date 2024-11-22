return {
	{
		"nvim-telescope/telescope.nvim",
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
						cwd = require("utils").get_embed_arg_path(),
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
						cwd = require("utils").get_embed_arg_path(),
					})
				end,
				desc = "Search for a string in your current working directory and get results live as you type",
			},
			{
				"<leader>fb",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "show buffers",
			},
			{
				"<leader>fe",
				function()
					local file_browser = require("telescope").extensions.file_browser
					file_browser.file_browser({
						grouped = true,
						cwd = require("utils").get_embed_arg_path(),
					})
				end,
				desc = "open file browser",
			},
			{
				"<leader>fE",
				function()
					local file_browser = require("telescope").extensions.file_browser
					file_browser.file_browser({
						grouped = true,
						path = "%:p:h",
						select_buffer = true,
					})
				end,
			},
		},
		opts = function(_)
			local actions = require("telescope.actions")

			return {
				defaults = {
					sorting_strategy = "ascending",
				},
				pickers = {
					buffers = {
						previewer = false,
						theme = "ivy",
						layout_config = {
							height = 0.4,
						},
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer + actions.move_to_top,
							},
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					file_browser = {
						hijack_netrw = true,
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")

			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		event = "LazyFile",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"RRethy/vim-illuminate",
		event = "LazyFile",
		opts = {
			providers = {
				"lsp",
				"treesitter",
				"regex",
				under_cursor = true,
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			-- vim.g.mkdp_open_ip = "127.0.0.1"
			-- vim.g.mkdp_port = 3102
		end,
	},
}
