return {
	"mg979/vim-visual-multi",
	lazy = false,
	init = function()
		vim.g.VM_maps = nil
		vim.g.VM_maps = {
			["Add Cursor Down"] = "<M-C-Down>",
			["Add Cursor Up"] = "<M-C-Up>",
		}
	end,
}
