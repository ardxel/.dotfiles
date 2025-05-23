return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			local git_icons = require("config.icons").git
			local folder_icons = require("config.icons").folder

			local opts = {
				close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
				sort_case_insensitive = false, -- used when sorting files and directories in the tree
				source_selector = {
					winbar = true,
					content_layout = "center",
					sources = {
						{ source = "filesystem", display_name = folder_icons.FolderClosed .. " " .. "File" },
						{ source = "buffers", display_name = folder_icons.DefaultFile .. " " .. "Bufs" },
						{ source = "git_status", display_name = git_icons.Git .. " " .. "Git" },
					},
				},
				sort_function = nil,
				default_component_configs = {
					container = {
						enable_character_fade = true,
					},
					indent = { padding = 0 },
					icon = {
						folder_closed = folder_icons.FolderClosed,
						folder_open = folder_icons.FolderOpen,
						folder_empty = folder_icons.FolderEmpty,
						folder_empty_open = folder_icons.FolderEmpty,
						default = folder_icons.DefaultFile,
					},
					modified = {
						symbol = "[+]",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = true,
						highlight = "NeoTreeFileName",
					},
					git_status = {
						symbols = {
							-- Change type
							added = git_icons.GitAdd, -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified = git_icons.GitChange, -- or "", but this is redundant info if you use git_status_colors on the name
							deleted = git_icons.GitDelete, -- this can only be used in the git_status source
							renamed = git_icons.GitRenamed, -- this can only be used in the git_status source
							-- Status type
							untracked = git_icons.GitUntracked,
							ignored = git_icons.GitIgnored,
							unstaged = git_icons.GitUnstaged,
							staged = git_icons.GitStaged,
							conflict = git_icons.GitConflict,
						},
					},
					-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
					file_size = {
						enabled = true,
						required_width = 64, -- min width of window required to show this column
					},
					type = {
						enabled = true,
						required_width = 122, -- min width of window required to show this column
					},
					last_modified = {
						enabled = true,
						required_width = 88, -- min width of window required to show this column
					},
					created = {
						enabled = true,
						required_width = 110, -- min width of window required to show this column
					},
					symlink_target = {
						enabled = false,
					},
				},
				-- A list of functions, each representing a global custom command
				-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
				-- see `:h neo-tree-custom-commands-global`
				commands = {},
				window = {
					position = "left",
					width = 30,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<space>"] = false, -- disable space until we figure out which-key disabling
						["<Tab>"] = "next_source",
						["<s-Tab>"] = "prev_source",
					},
				},
				nesting_rules = {},
				filesystem = {
					filtered_items = {
						visible = false, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = false,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
					},
					follow_current_file = {
						enabled = false, -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					group_empty_dirs = false, -- when true, empty folders will be grouped together
					hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
					-- in whatever position is specified in window.position
					-- "open_current",  -- netrw disabled, opening a directory opens within the
					-- window like netrw would, regardless of window.position
					-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
					use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
					-- instead of relying on nvim autocmd events.
					window = {
						mappings = {
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["H"] = "toggle_hidden",
							["/"] = "fuzzy_finder",
							["D"] = "fuzzy_finder_directory",
							["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
							-- ["D"] = "fuzzy_sorter_directory",
							["f"] = "filter_on_submit",
							["<c-x>"] = "clear_filter",
							["[g"] = "prev_git_modified",
							["]g"] = "next_git_modified",
							["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["og"] = { "order_by_git_status", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
						},
						fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
							["<down>"] = "move_cursor_down",
							["<C-n>"] = "move_cursor_down",
							["<up>"] = "move_cursor_up",
							["<C-p>"] = "move_cursor_up",
						},
					},

					commands = {}, -- Add a custom command or override a global one using the same function name
				},
				buffers = {
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--              -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					group_empty_dirs = true, -- when true, empty folders will be grouped together
					show_unloaded = true,
					window = {
						mappings = {
							["bd"] = "buffer_delete",
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
						},
					},
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
							["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
							["oc"] = { "order_by_created", nowait = false },
							["od"] = { "order_by_diagnostics", nowait = false },
							["om"] = { "order_by_modified", nowait = false },
							["on"] = { "order_by_name", nowait = false },
							["os"] = { "order_by_size", nowait = false },
							["ot"] = { "order_by_type", nowait = false },
						},
					},
				},
			}

			require("neo-tree").setup(opts)

			vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
		end,
	},
	{
		"ibhagwan/fzf-lua",
		lazy = false,
		cmd = { "FzfLua" },
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
				"<leader>fF",
				function()
					require("fzf-lua").files({
						cwd = require("utils").get_embed_arg_path(),
						winopts = {
							hidden = "hidden",
						},
					})
				end,
				desc = "Find files(2)",
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
		opts = {},
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
