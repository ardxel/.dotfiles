return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("utils.configs.cmp").setup()
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {},
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		enabled = false,
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 1,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		lazy = false,
		opts = { silent = true },
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		version = "*",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		version = false,
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
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
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			enabled = true,
			input_after_comment = true,
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"romainl/vim-cool",
		event = "LazyFile",
	},
	{
		-- FIX:  fix VM warning about overwriting mappings
		"mg979/vim-visual-multi",
		-- lualine is using VM statusline for mode highlights permanently,
		-- lualine is not lazy loading, and there can be problems.
		-- event = "LazyFile",
		lazy = false,
		priority = 1000,
		init = function()
			vim.g.VM_silent_exit = 1
			vim.g.VM_set_statusline = 0
			-- vim.g.VM_maps = {
			-- 	["Find Under"] = "",
			-- 	["Undo"] = "",
			-- 	["Redo"] = "",
			-- 	["<BS>"] = "",
			-- }
		end,
		-- config = function()
		-- 	local set = vim.keymap.set
		--
		-- 	set("n", "<M-C-Down", "<Plug>(VM-Add-Cursor-Down)", { silent = true })
		-- 	set("n", "<M-C-Up", "<Plug>(VM-Add-Cursor-Up)", { silent = true })
		-- 	set("n", "<C-n>", "<Plug>(VM-Find-Under)", { silent = true })
		-- 	set("n", "]", "<Plug>(VM-Find-Next)", { silent = true })
		-- 	set("n", "[", "<Plug>(VM-Find-Prev)", { silent = true })
		-- 	set("n", "q", "<Plug>(VM-Skip-Region)", { silent = true })
		-- 	set("n", "Q", "<Plug>(VM-Remove-Region)", { silent = true })
		-- 	set("n", "\\A", "<Plug>(VM-Select-All)", { silent = true })
		-- end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		-- Move any selection in any direction
		"echasnovski/mini.move",
		opts = {},
		version = false,
	},
}
