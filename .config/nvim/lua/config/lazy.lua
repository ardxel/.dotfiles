local M = {}

M.options = {
	default = { lazy = true },
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"netrwPlugin",
			"netrw",
			"tarPlugin",
			"tohtml",
		},
	},
	ui = {
		border = "rounded",
	},
	change_detection = { notify = false },
}

M.lazy = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	vim.uv = vim.uv or vim.loop
	if not vim.uv.fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)
end

M.setup = function()
	M.lazy()
	local events = require("config.events")
	events.lazy_file()

	require("config.globals")
	require("config.autocmds")
	require("config.keymaps")
	require("config.options")
	require("lazy").setup("plugins", M.options)
end

return M
