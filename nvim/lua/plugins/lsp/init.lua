local config = function()
	local servers = require("plugins.lsp.utils.servers")

	require("neoconf").setup()
	require("neodev").setup()

	servers:setup(require("lspconfig"), {
		on_attach = require("plugins.lsp.utils.attach"),
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		handlers = require("plugins.lsp.utils.handlers"),
		flags = { debounce_text_changes = 100 },
	})

	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "",
		Info = "",
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		config = config,
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
			},
		},
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
			local tools = require("typescript-tools")
			local attach = require("plugins.lsp.utils.attach")
			local handlers = require("plugins.lsp.utils.handlers")

			tools.setup({
				settings = {
					separate_diagnostic_server = false,
				},
				-- capabilities = capabilities,
				on_attach = attach,
				handlers = handlers,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				-- keybinds for navigation in lspsaga window
				move_in_saga = { prev = "<C-k>", next = "<C-j>" },
				code_action = {
					enable = false,
					keys = {
						quit = "<ESC>",
					},
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
			})
			vim.cmd([[
  hi! link SagaBorder Normal
  hi! link SagaNormal Normal
  hi! link ActionPreviewBorder Normal
  hi! link HoverBorder Normal
  hi! link RenameBorder Normal
  hi! link DiagnosticBorder Normal
  hi! link DiagnosticShowBorder Normal
  hi! link TerminalBorder Normal
]])
		end,
		gependencies = {
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
				-- "tsserver",
				-- "tailwindcss",
				-- "dockerfile-language-server",
				-- "luacheck",
				-- "stylua",
				-- "shellchech",
				-- "shfmt",
				-- "fixjson",
				-- "hadolint"
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
}
