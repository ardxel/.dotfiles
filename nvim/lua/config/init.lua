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
vim.cmd("language en_US")
vim.g.mapleader = " "

require("config.globals")
require("config.keymaps")
require("config.options")

local plugins = "plugins"

if vim.fn.isdirectory(vim.v.argv[2]) == 1 then
	vim.api.nvim_set_current_dir(vim.v.argv[2])
end

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

require("lazy").setup(plugins, options)

vim.api.nvim_create_augroup("neotree", {})
vim.api.nvim_create_autocmd("UiEnter", {
	desc = "Open Neotree automatically",
	group = "neotree",
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("Neotree toggle")
		end
	end,
})
