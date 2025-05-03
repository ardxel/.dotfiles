return {
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
			end, { noremap = true, silent = true, desc = "Open neogen menu" })

			local ts_features = utils.create_popup_menu({
				{ text = "Organize imports", action = "TSToolsOrganizeImports" },
				{ text = "Remove unused imports", action = "TSToolsRemoveUnusedImports" },
				{ text = "Add missing imports", action = "TSToolsAddMissingImports" },
				{ text = "Sort imports", action = "TSToolsSortImports" },
				{ text = "Remove unused statements", action = "TSToolsRemoveUnused" },
				{ text = "Fix all", action = "TSToolsFixAll" },
			}, { title = "[Typescript features]" })

			local python_features = utils.create_popup_menu({
				{ text = "Organize imports", action = "PyrightOrganizeImports" },
				{ text = "Set python path", action = "PyrightSetPythonPath" },
			}, { title = "[Pyright features]" })

			local used_servers = {
				ts_servers = { "tsserver", "typescript-tools", "ts_ls" },
				python_servers = { "pyright" },
			}

			vim.keymap.set("n", "<leader>tt", function()
				local active_clients = vim.lsp.get_clients()
				for _, client in ipairs(active_clients) do
					if vim.tbl_contains(used_servers.ts_servers, client.name) then
						ts_features:mount()
					end
					if vim.tbl_contains(used_servers.python_servers, client.name) then
						python_features:mount()
					end
				end
			end, { noremap = true, silent = true, desc = "Open lsp_client features window" })
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
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {},
		config = function(_, opts)
			require("nvim-highlight-colors").setup(opts)
		end,
	},
}
