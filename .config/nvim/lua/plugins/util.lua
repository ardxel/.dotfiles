return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {},
		keys = {
			{
				"<leader>ql",
				function()
					require("persistence").load()
				end,
				desc = "restore the last session",
			},
		},
	},
	{
		"zakissimo/smoji.nvim",
		dependencies = { "stevearc/dressing.nvim" },
		cmd = "Emoji",
		config = function()
			local smoji = require("smoji")
			vim.api.nvim_del_user_command("Smoji")
			vim.api.nvim_create_user_command("Emoji", smoji.select, { nargs = 0 })
		end,
	},
}
