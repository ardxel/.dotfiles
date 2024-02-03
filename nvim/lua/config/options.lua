local opt = vim.opt

vim.o.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smarttab = true
opt.autoindent = true
opt.completeopt = "menuone,noinsert,noselect"

opt.ignorecase = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
-- opt.colorcolumn = "100"
opt.pumheight = 10

opt.hidden = true
opt.scrolloff = 10
opt.swapfile = false
opt.modifiable = true
opt.pumblend = 0
opt.termguicolors = true

-- NEOVIDE
-- if vim.g.neovide then
-- 	vim.o.guifont = "DroidSansM Nerd Font"
-- 	vim.g.neovide_input_macos_alt_is_meta = true
-- end
