return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		opts = {
			pywal = true,
		},
		config = function(_, opts)
			local utils = require("plugins.configs.lualine")
			local lualine = require("lualine")
			lualine.setup(utils.config(opts.pywal))

			vim.api.nvim_create_user_command("LualineRestart", function()
				lualine.setup(utils.config())
			end, { desc = "Restart Lualine" })
		end,
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
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"Trouble",
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"notify",
					"snacks_notif",
					"snacks_terminal",
					"snacks_win",
					"toggleterm",
					"trouble",
				},
			},
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = "LazyFile",
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
	},
}
