return {
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"folke/which-key.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			delay = 1000,
			spelling = {
				enabled = false,
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
