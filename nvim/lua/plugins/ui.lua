return {
	-- NUI
	{
		"MunifTanjim/nui.nvim",
		config = function()
			local ts_features_popup = require("plugins.popups.ts-features")
			local neogen_popup = require("plugins.popups.ts-features")

			ts_features_popup()
			neogen_popup()
		end,
	},
	-- LUALINE
	{
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
	},
	-- NOICE
	{
		"folke/noice.nvim",
		-- enabled = false,
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				notify = {
					enabled = false,
				},
				cmdline = {
					view = "cmdline",
				},
				messages = {
					enabled = false,
				},
				presets = {
					bottom_search = true,
					long_message_to_split = true,
					lsp_doc_border = true,
				},
				routes = {
					{
						filter = {
							event = "notify",
							find = "No information available",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "notify",
							find = "No code actions available",
						},
						opts = { skip = true },
					},
					-- {
					-- 	event = "msg_show",
					-- 	kind = "",
					-- 	find = "change",
					-- 	opts = { skip = true },
					-- },
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
			})
		end,

		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
