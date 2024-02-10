return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local symbols = {}
		symbols.unix = vim.fn.has("macunix") and "" or ""
		symbols.dos = ""
		symbols.mac = ""

		require("lualine").setup({
			options = {
				theme = "gruvbox_light",
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					"encoding",
					{
						"fileformat",
						symbols = symbols,
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
