return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = function(_, opts)
		local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})

		return opts
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}