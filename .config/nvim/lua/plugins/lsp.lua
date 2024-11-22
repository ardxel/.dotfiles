return {
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		opts = function()
			local signs = require("config.icons").signs
			local o = {
				inlay_hints = { enabled = false },
				diagnostics = {
					underline = true,
					update_in_insert = false,
					severity_sort = true,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
					},
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = signs.Error,
							[vim.diagnostic.severity.WARN] = signs.Warn,
							[vim.diagnostic.severity.HINT] = signs.Hint,
							[vim.diagnostic.severity.INFO] = signs.Info,
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

			return o
		end,
		config = function(_, opts)
			require("utils.configs.lsp").setup(opts)
		end,
		dependencies = {
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
			},
			"williamboman/mason-lspconfig.nvim",
			"windwp/nvim-autopairs",
		},
	},

	{
		"nvimdev/lspsaga.nvim",
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
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
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
		"frostplexx/mason-bridge.nvim",
		opts = {
			overrides = {
				linters = {
					javascript = { "eslint_d" },
					javascriptreact = { "eslint_d" },
					typescript = { "eslint_d" },
					typescriptreact = { "eslint_d" },
					lua = { "luacheck" },
					markdown = { "markdownlint" },
					json = { "jsonlint" },
					jsonc = { "jsonlint" },
					sh = { "shellcheck" },
					zsh = { "shellcheck" },
					bash = { "shellcheck" },
				},
				formatters = {
					lua = { "stylua" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					html = { "prettierd" },
					css = { "prettierd" },
					scss = { "prettierd" },
					sh = { "shfmt" },
					zsh = { "shfmt" },
					json = { "prettierd" },
					jsonc = { "prettierd" },
					docker = { "prettierd" },
					markdown = { "prettierd" },
				},
			},
		},
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup()
		end,
	},
	{ "saecki/live-rename.nvim", opts = {} },
}
