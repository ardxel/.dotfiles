return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		lazy = false,
		-- event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				highlights = require("rose-pine.plugins.bufferline"),
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
			-- vim.cmd("hi! BufferLineFill ctermbg=NONE guibg=NONE")
			-- vim.cmd("hi! BufferLineBuffer ctermbg=NONE guibg=NONE")
			-- vim.cmd("hi! BufferLineTab ctermbg=NONE guibg=NONE gui=bold cterm=bold")
		end,
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},

			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
