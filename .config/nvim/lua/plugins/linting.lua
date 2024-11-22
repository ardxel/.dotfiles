return {
	"mfussenegger/nvim-lint",
	event = "LazyFile",
	config = function()
		local lint = require("lint")
		local mason_bridge = require("mason-bridge")
		lint.linters_by_ft = mason_bridge.get_linters()

		local try_lint = function()
			local linters = lint._resolve_linter_by_ft(vim.bo.filetype)

			if #linters > 0 then
				lint.try_lint(linters)
			end
		end

		local utils = require("utils")
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = utils.debounce(100, try_lint),
		})

		-- https://github.com/frostplexx/mason-bridge.nvim?tab=readme-ov-file#dynamically-load-linters-and-formatters
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				local linters = mason_bridge.get_linters()
				if #linters == 0 then
					return
				end
				local names = linters[vim.bo.filetype] or {}
				names = vim.list_extend({}, names)
				vim.list_extend(names, linters["*"])
				lint.try_lint(names)
			end,
		})
	end,
}
