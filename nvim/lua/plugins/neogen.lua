return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		local neogen = require("neogen")

		neogen.setup({
			enabled = true,
			input_after_comment = true,
		})
	end,
}
