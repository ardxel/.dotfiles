return {
	"stevearc/conform.nvim",
	dependecies = { "mason.nvim" },
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out:w
	cmd = "ConformInfo",
	opts = function()
		local mason_bridge = require("mason-bridge")

		return {
			format = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
			},
			formatter_by_ft = mason_bridge.get_formatters(),
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
			},
		}
	end,
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
