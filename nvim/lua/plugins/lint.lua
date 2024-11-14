return {
	"mfussenegger/nvim-lint",
	lazy = false,
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			lua = { "luacheck" },
			markdown = { "markdownlint" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },
			bash = { "shellcheck" },
		}

		local try_lint = function()
			local linters = lint._resolve_linter_by_ft(vim.bo.filetype)

			if #linters > 0 then
				lint.try_lint(linters)
			end
		end

		---@param ms number
		---@param fn function
		---@return function
		local debounce = function(ms, fn)
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
			callback = debounce(100, try_lint),
		})
	end,
}
