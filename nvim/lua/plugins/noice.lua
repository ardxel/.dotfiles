return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
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
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			enabled = false,
			opts = {
				background_colour = "#000000",
			},
			config = function(_, opts)
				local notify = require("notify")
				notify.setup(opts)

				vim.keymap.set("n", "<leader>sx", notify.dismiss, { noremap = true })
			end,
		},
	},
}
