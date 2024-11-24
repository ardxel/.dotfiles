return {
	-- GOLANG
	{
		"ray-x/go.nvim",
		event = "LazyFile",
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = function(_, opts)
			local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})

			return opts
		end,
	},
	-- TYPESCRIPT
	{
		"pmizio/typescript-tools.nvim",
		event = "LazyFile",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local ts_tools = require("typescript-tools")
			local lsp_utils = require("utils.lsp")

			ts_tools.setup({
				settings = {
					separate_diagnostic_server = false,
				},
				on_attach = lsp_utils.on_attach,
				handlers = lsp_utils.handlers,
			})
		end,
	},
}
