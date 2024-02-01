return {
	"mfussenegger/nvim-lint",
	lazy = true,
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			lua = { "luacheck" },
			markdown = { "markdownlint" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },
		}

		local M = {}

		M.lint = function()
			local names = lint._resolve_linter_by_ft(vim.bo.filetype)

			if #names > 0 then
				lint.try_lint(names)
			end
		end

		---@param ms number
		---@param fn function
		---@return function
		M.debounce = function(ms, fn)
			local timer = vim.loop.new_timer()
			return function(...)
				local argv = { ... }
				timer:start(ms, 0, function()
					timer:stop()
					vim.schedule_wrap(fn)(unpack(argv))
				end)
			end
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = M.debounce(200, M.lint),
		})
	end,
}
