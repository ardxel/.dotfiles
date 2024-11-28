return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			local lualine_extra = require("utils.configs.lualine")
			return lualine_extra.get_config()
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		event = "VeryLazy", -- this line fixing second statusbar
		init = function()
			vim.g.tpipeline_restore = 1
			vim.g.tpipeline_fillcentre = 1 -- inherit lualine highlights
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
