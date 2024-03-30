return {
	"mg979/vim-visual-multi",
	lazy = false,
	init = function()
		vim.g.VM_maps = nil
		vim.g.VM_maps = {
			["Add Cursor Up"] = "<C-Up>",
			["Add Cursor Down"] = "<C-Down>",
		}
	end,
}
