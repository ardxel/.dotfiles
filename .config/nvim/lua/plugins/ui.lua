return {
	-- NUI
	{
		"MunifTanjim/nui.nvim",
		config = function()
			local ts_features_popup = require("plugins.popups.ts-features")
			local neogen_popup = require("plugins.popups.neogen")

			ts_features_popup()
			neogen_popup()
		end,
	},
	-- LUALINE
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			local symbols = {
				unix = vim.fn.has("macunix") and "" or "",
				dos = "",
				mac = "",
			}

			local function my_location()
				local line = vim.fn.line(".")
				local col = vim.fn.virtcol(".")
				local total_lines = vim.fn.line("$")

				return string.format("%2d:%s::%-2d", line, col, total_lines)
			end

			return {
				options = {
					disabled_filetypes = {
						"dashboard",
						"filesytem",
						"mason",
						"neo-tree",
						"neo-tree-popup",
						"null-ls-info",
						"lazy",
						"lspinfo",
						"ministarter",
						"TelescopePrompt",
					},
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
			}
		end,
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
