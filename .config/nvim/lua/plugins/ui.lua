return {
	{
		"MunifTanjim/nui.nvim",
		config = function()
			local utils = require("utils")

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
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			local icons = require("config.icons")

			local location = {
				"location",
				fmt = function()
					local line = vim.fn.line(".")
					local col = vim.fn.virtcol(".")
					local total_lines = vim.fn.line("$")

					return string.format("( %2d:%s:%-2d )", line, col, total_lines)
				end,
			}

			--- Visual Multi Mode
			--- @see https://github.com/nvim-lualine/lualine.nvim/issues/951
			local mode = {
				"mode",
				fmt = function(mode)
					return vim.iter(string.gmatch(vim.fn["vm#themes#statusline"](), "%S+")):nth(2) or mode
				end,
			}

			local filetype = {
				"filetype",
				icon_only = true,
			}

			local diff = {
				"diff",
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
				symbols = {
					added = icons.git.GitAdd .. " ",
					modified = icons.git.GitChange .. " ",
					removed = icons.git.GitDelete .. " ",
				},
				colored = true,
				always_visible = false,
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn", "info", "hint" },
				symbols = {
					error = icons.diagnostics.Error .. " ",
					hint = icons.diagnostics.Hint .. " ",
					info = icons.diagnostics.Info .. " ",
					warn = icons.diagnostics.Warning .. " ",
				},
				colored = true,
				update_in_insert = false,
				always_visible = false,
			}

			return {
				options = {
					theme = {
						normal = {
							a = { bg = "None", fg = "#a89984", gui = "bold" },
							b = { bg = "None", fg = "#a89984" },
							c = { bg = "None", fg = "#a89984" },
							z = { bg = "None", fg = "#a89984" },
						},
						insert = {
							a = { bg = "None", fg = "#a89984", gui = "bold" },
							b = { bg = "None", fg = "#a89984" },
							c = { bg = "None", fg = "#a89984" },
						},
						visual = {
							a = { bg = "None", fg = "#a89984", gui = "bold" },
							b = { bg = "None", fg = "#a89984" },
							c = { bg = "None", fg = "#a89984" },
						},
						replace = {
							a = { bg = "None", fg = "#a89984", gui = "bold" },
							b = { bg = "None", fg = "#a89984" },
							c = { bg = "None", fg = "#a89984" },
						},
						command = {
							a = { bg = "None", fg = "#a89984", gui = "bold" },
							b = { bg = "None", fg = "#a89984" },
							c = { bg = "None", fg = "#a89984" },
						},
						inactive = {
							a = { bg = "None", fg = "#a89984", gui = "bold" },
							b = { bg = "None", fg = "#a89984" },
							c = { bg = "None", fg = "#a89984" },
						},
					},
					globalstatus = true,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { mode },
					lualine_b = { "branch" },
					lualine_c = {
						"filename",
					},
					lualine_x = {
						diff,
						diagnostics,
						filetype,
					},
					lualine_y = {},
					lualine_z = { location },
				},
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		event = "VeryLazy", -- this line fixed second statusbar
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			notify = {
				enabled = false,
			},
			messages = {
				enabled = false,
			},
			cmdline = {
				view = "cmdline",
				format = {
					cmdline = {
						position = {
							row = 0,
						},
					},
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "LazyFile",
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
}
