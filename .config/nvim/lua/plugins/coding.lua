return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = require("utils.configs.cmp").setup,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{ "petertriho/cmp-git", opts = {} },
			{
				"garymjr/nvim-snippets",
				opts = { friendly_snippets = true },
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"onsails/lspkind.nvim",
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- fork with toggle feature
		"Ealiaksandr-trush/codeium.nvim",
		enabled = false,
		branch = "toggle",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {},
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		enabled = false,
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 1,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		lazy = false,
		opts = { silent = true },
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		version = "*",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		version = false,
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},

			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			enabled = true,
			input_after_comment = true,
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"romainl/vim-cool",
		event = "LazyFile",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		-- Move any selection in any direction
		"echasnovski/mini.move",
		opts = {},
		version = false,
	},
}
