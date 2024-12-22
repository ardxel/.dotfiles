return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	opts = {
		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "fallback",
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
			python = { "isort", "black" },
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
}
