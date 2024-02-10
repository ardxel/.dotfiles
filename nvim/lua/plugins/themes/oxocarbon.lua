return {
	"nyoom-engineering/oxocarbon.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.background = "light" -- set this to dark or light
		vim.cmd("colorscheme oxocarbon")
	end,
}
