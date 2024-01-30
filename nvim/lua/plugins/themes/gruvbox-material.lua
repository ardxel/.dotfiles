return {
	"sainnhe/gruvbox-material",
	lazy = false,

	config = function()
		vim.g.gruvbox_material_transparent_background = 2
		vim.g.gruvbox_material_foreground = "mix"
		vim.g.gruvbox_material_enable_bold = 1

		vim.cmd("colorscheme gruvbox-material")

		require("plugins.themes.after-load")("gruvbox-material")
	end,
}
