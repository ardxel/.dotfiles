return {
	"xero/miasma.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme miasma")
		require("plugins.themes.after-load")()
	end,
}
