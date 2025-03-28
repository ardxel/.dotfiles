local opt = vim.opt

vim.o.virtualedit = ""
vim.o.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.cmdheight = 0
opt.smarttab = true
opt.autoindent = true
opt.completeopt = "menuone,noinsert,noselect"

opt.ignorecase = true
opt.number = true
opt.relativenumber = true
opt.cursorlineopt = "number"
opt.cursorline = true
opt.signcolumn = "yes:1"

opt.hidden = true
opt.scrolloff = 4
opt.swapfile = false
opt.modifiable = true
opt.termguicolors = true
opt.showmode = false
opt.smoothscroll = true

-- vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = 0
vim.g.editorconfig = true
vim.g.encoding = "utf-8"
vim.g.fileencoding = "utf-8"

-- NEOVIDE
if vim.g.neovide then
	-- vim.o.guifont = "FiraCode Nerd Font Mono Retina:h15"
	vim.g.neovide_input_macos_alt_is_meta = true

	-- Helper function for transparency formatting
	local alpha = function()
		---@diagnostic disable-next-line: ambiguity-1
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.8
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.g.neovide_window_blurred = true
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
end
