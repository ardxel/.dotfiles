return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	keys = {
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "restore the last session",
		},
	},
}
