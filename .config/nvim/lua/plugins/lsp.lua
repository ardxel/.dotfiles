return {
	{
		"neovim/nvim-lspconfig",
		after = "williamboman/mason-lspconfig.nvim",
		event = "LazyFile",
		opts = function()
			local icons = require("config.icons")

			return {
				inlay_hints = { enabled = false },
				diagnostics = {
					underline = false,
					virtual_text = {
						spacing = 4,
						source = true,
						prefix = function(diagnostic)
							return vim.tbl_values(icons.diagnostics)[diagnostic.severity] or icons.Hint
						end,
					},
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = icons.signs.ERROR,
							[vim.diagnostic.severity.WARN] = icons.signs.WARN,
							[vim.diagnostic.severity.HINT] = icons.signs.HINT,
							[vim.diagnostic.severity.INFO] = icons.signs.INFO,
						},
					},
				},
				float = {
					border = "rounded",
				},
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
			}
		end,
		config = function(_, opts)
			require("plugins.configs.lsp").setup(opts)
		end,
		dependencies = {
			{
				build = ":MasonUpdate",
				"williamboman/mason.nvim",
			},
			"williamboman/mason-lspconfig.nvim",
		},
	},

	{
		"nvimdev/lspsaga.nvim",
		event = "LazyFile",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		opts = {
			move_in_saga = { prev = "<C-k>", next = "<C-j>" },
			code_action = {
				enable = false,
			},
			definition = {
				keys = {
					quit = "<ESC>",
				},
			},
			ui = {
				code_action = "",
			},
			symbol_in_winbar = {
				enable = false,
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"jsonls",
				"cssls",
				"html",
				"tailwindcss",
			},
			automatic_installation = true,
		},
		event = "BufReadPre",
		dependencies = "williamboman/mason.nvim",
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = "BufReadPre",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = true,
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup()
		end,
	},
	{ "saecki/live-rename.nvim", opts = {} },
}
