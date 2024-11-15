local signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}
return {
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local s = {
				inlay_hints = { enabled = false },
				-- options for vim.diagnostic.config()
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
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
			}

			return s
		end,
		config = function(_, opts)
			local servers = require("plugins.lsp.utils.server")
			local lspconfig = require("lspconfig")
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local lsp_utils = require("plugins.lsp.utils.utils")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)

			require("neoconf").setup()

			for lsp_name, opts in pairs(servers) do
				lspconfig[lsp_name].setup(vim.tbl_deep_extend("force", opts, {
					on_attach = lsp_utils.on_attach,
					capabilities = capabilities,
					handlers = lsp_utils.handlers,
				}))
			end

			if vim.fn.has("nvim-0.10.0") then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = nil })
				end
			end

			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
				opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
					or function(diagnostic)
						for d, icon in pairs(signs) do
							if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
								return icon
							end
						end
					end
			end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
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
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local ts_tools = require("typescript-tools")
			local lsp_utils = require("plugins.lsp.utils.utils")

			ts_tools.setup({
				settings = {
					separate_diagnostic_server = false,
				},
				on_attach = lsp_utils.on_attach,
				handlers = lsp_utils.handlers,
			})
		end,
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
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup()
		end,
	},
	{ "saecki/live-rename.nvim", opts = {} },
}
