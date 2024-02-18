return {
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
}
