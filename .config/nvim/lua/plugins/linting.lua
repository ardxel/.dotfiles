return {
	"mfussenegger/nvim-lint",
	event = "LazyFile",
	opts = {
		linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			markdown = { "markdownlint" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },
			bash = { "shellcheck" },
			python = { "flake8" },
		},
	},
	config = function(_, opts)
		local lint = require("lint")
		lint.linters_by_ft = opts.linters_by_ft

		local try_lint = function()
			local linters = lint._resolve_linter_by_ft(vim.bo.filetype)

			if #linters > 0 then
				lint.try_lint(linters)
			end
		end

		local utils = require("utils")
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = utils.debounce(100, try_lint),
		})

		for _, linters in pairs(opts.linters_by_ft) do
			for _, linter in ipairs(linters) do
				local ns = lint.get_namespace(linter)
				vim.diagnostic.config({
					underline = false,
					virtual_text = {
						spacing = 4,
						source = true,
						prefix = function(diagnostic)
							local icons = require("config.icons").diagnostics
							return vim.tbl_values(icons)[diagnostic.severity] or icons.Hint
						end,
					},
				}, ns)
			end
		end
	end,
}
