return {
	"stevearc/conform.nvim",
	lazy = true,
	dependecies = { "mason.nvim" },
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out:w
	cmd = "ConformInfo",
	config = function()
		local conform = require("conform")

		conform.setup({
			format = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
			},
			formatters_by_ft = {
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
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
}
