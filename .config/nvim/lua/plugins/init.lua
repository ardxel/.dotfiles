return {
	{ "echasnovski/mini.nvim", version = false },
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 2000,
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
