local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
if vim.fn.isdirectory(vim.v.argv[2]) == 1 then
	vim.api.nvim_set_current_dir(vim.v.argv[2])
end

require("config.globals")
require("config.keymaps")
require("config.options")
require("config.autocmds")

local options = {
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

require("lazy").setup("plugins", options)
