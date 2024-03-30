return {
	"nvim-lualine/lualine.nvim",
	-- event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local symbols = {}
		symbols.unix = vim.fn.has("macunix") and "" or ""
		symbols.dos = ""
		symbols.mac = ""

		local function my_location()
			local line = vim.fn.line(".")
			local col = vim.fn.virtcol(".")
			local total_lines = vim.fn.line("$")

			return string.format("%2d:%s::%-2d", line, col, total_lines)
		end

		require("lualine").setup({
			options = {
				-- theme = "gruvbox_light",
				theme = "rose-pine",
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
				lualine_y = {},
				lualine_z = { { my_location } },
			},
		})
	end,
}
