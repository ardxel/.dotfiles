return {
	"stevearc/conform.nvim",
	-- event = { "BufWritePre" },
	lazy = false,
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	opts = {
		default_format_opts = {
			lsp_format = "fallback",
		},
		--- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				timeout_ms = 1000,
				lsp_format = "fallback",
			}
		end,
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
			python = { "isort", "autoflake", "black" },
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, { desc = "Re-enable autoformat-on-save" })
	end,
}
