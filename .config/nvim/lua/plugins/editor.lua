return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
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
		opts = {
			defaults = {
				sorting_strategy = "ascending",
			},
			extensions = {
				file_browser = {
					hijack_netrw = true,
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").files({
						cwd = require("utils").get_embed_arg_path(),
						winopts = {
							hidden = "hidden",
						},
					})
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep({
						cwd = require("utils").get_embed_arg_path(),
					})
				end,
				desc = "live grep",
			},
			{
				"<leader>fb",
				function()
					require("fzf-lua").buffers({
						previewer = false,
						winopts = {
							row = 1,
							col = 0,
							width = 1,
							height = 0.4,
							border = "none",
						},
					})
				end,
				desc = "buffers",
			},
		},
	},
	{
		"MunifTanjim/nui.nvim",
		config = function()
			local utils = require("utils.popup")
			local neogen_docs = utils.create_popup_menu({

				{ text = "func", action = ":Neogen func" },
				{ text = "type", action = ":Neogen type" },
				{ text = "class", action = ":Neogen class" },
			}, { title = "[Generate docs]" })

			vim.keymap.set("n", "<leader>ng", function()
				neogen_docs:mount()
			end)

			local ts_features = utils.create_popup_menu({
				{ text = "Organize imports", action = "TSToolsOrganizeImports" },
				{ text = "Remove unused imports", action = "TSToolsRemoveUnusedImports" },
				{ text = "Add missing imports", action = "TSToolsAddMissingImports" },
				{ text = "Sort imports", action = "TSToolsSortImports" },
				{ text = "Remove unused statements", action = "TSToolsRemoveUnused" },
				{ text = "Fix all", action = "TSToolsFixAll" },
			}, { title = "[Typescript features]" })

			vim.keymap.set("n", "<leader>tt", function()
				local ts_servers = { "tsserver", "typescript-tools" }
				local active_clients = vim.lsp.get_clients()
				for _, client in ipairs(active_clients) do
					if vim.tbl_contains(ts_servers, client) then
						ts_features:mount()
					end
				end
			end, { noremap = true, silent = true })
		end,
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
		opts = {},
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
