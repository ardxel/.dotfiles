return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = require("plugins.configs.cmp").setup,
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
		"saghen/blink.cmp",
		enabled = false,
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"xzbdmw/colorful-menu.nvim",
		},
		-- use a release tag to download pre-built binaries
		version = "*",
		event = "InsertEnter",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = require("plugins.configs.blink"),
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
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
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			internal_pairs = {
				{
					"{%",
					"%}",
					fly = true,
					dosuround = true,
					newline = false,
					space = true,
					ft = { "jinja", "html" },
				},
			},
		},
		config = function(_, opts)
			default_cfg = require("ultimate-autopair.default").conf
			default_cfg = vim.deepcopy(default_cfg)

			if opts.internal_pairs then
				for _, pair in ipairs(opts.internal_pairs) do
					table.insert(default_cfg.internal_pairs, pair)
				end
			end

			require("ultimate-autopair").setup(default_cfg)
		end,
	},
	{
		-- Move any selection in any direction
		"echasnovski/mini.move",
		opts = {},
		version = false,
	},
}
