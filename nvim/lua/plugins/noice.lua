return {
	"folke/noice.nvim",
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
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			config = function()
				local notify = require("notify")
				notify.setup({
					background_colour = "#000000",
				})

				vim.keymap.set("n", "<leader>sx", require("notify").dismiss, { noremap = true })
			end,
		},
	},
}
