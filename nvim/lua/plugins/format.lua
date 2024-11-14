return {
	"stevearc/conform.nvim",
	dependecies = { "mason.nvim" },
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out:w
	cmd = "ConformInfo",
	opts = {
		format = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
		},
		-- stylua, prettierd, shfmt
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
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
	config = function(_, opts)
		local conform = require("conform")

		conform.setup(opts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
