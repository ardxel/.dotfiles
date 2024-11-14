return {
	{
		"akinsho/bufferline.nvim",
		version = "4.6.0",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					show_buffer_close_icons = false,
					diagnostics = "nvim_lsp",
					show_close_icons = false,
					always_show_bufferline = true,
					offsets = {
						{
							separator = true,
							filetype = "neo-tree",
							text = "NeoTree",
							highlight = "Directory",
							text_align = "center",
						},
					},
				},
			})
		end,
	},
}
