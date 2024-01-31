return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	config = function(_, opts)
		require("persistence").setup(opts)
	end,
	keys = {
		{
			"<leader>ql",
			function()
				require("persistence").load()
			end,
			desc = "restore the last session",
		},
	},
}
