return {
	{ "romainl/vim-cool" },
	{
		"mg979/vim-visual-multi",
		lazy = false,
		init = function()
			vim.g.VM_maps = nil
			vim.g.VM_maps = {
				["Add Cursor Up"] = "<C-Up>",
				["Add Cursor Down"] = "<C-Down>",
			}
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				under_cursor = true,
			})

			vim.cmd("hi! Illuminate guibg=#504945 ctermbg=240")

			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Illuminate" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Illuminate" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Illuminate" })

			vim.api.nvim_create_autocmd({ "ColorScheme" }, {
				pattern = { "*" },
				callback = function(_)
					vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Illuminate" })
					vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Illuminate" })
					vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Illuminate" })
				end,
			})
		end,
	},
}
