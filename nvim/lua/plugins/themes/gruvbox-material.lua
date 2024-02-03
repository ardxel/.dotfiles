return {
	"sainnhe/gruvbox-material",
	lazy = false,

	config = function()
		-- https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
		vim.g.gruvbox_material_transparent_background = 2
		-- "material" | "mix" | "original"
		vim.g.gruvbox_material_foreground = "material"
		vim.g.gruvbox_material_enable_bold = 1

		vim.cmd("colorscheme gruvbox-material")

		require("plugins.themes.after-load")("gruvbox-material")
	end,
}
