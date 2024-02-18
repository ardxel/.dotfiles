return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- Default options:
		require("gruvbox").setup({
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		})

		vim.o.background = "dark" -- "dark" or "light"
		vim.cmd("colorscheme gruvbox")

		vim.cmd("hi! @keyword gui=bold cterm=bold guifg=#fb4934")
		vim.cmd("hi! @keyword.return gui=bold cterm=bold guifg=#fb4934")
		vim.cmd("hi! @keyword.function gui=bold cterm=bold guifg=#fb4934")
		vim.cmd("hi! @keyword.exception gui=bold cterm=bold guifg=#fb4934")
		vim.cmd("hi! @keyword.conditional gui=bold cterm=bold guifg=#fb4934")
		vim.cmd("hi! @keyword.import gui=bold cterm=bold guifg=#8ec07c")
		vim.cmd("hi! @keyword.debug gui=bold cterm=bold guifg=#fe8019")
		vim.cmd("hi! @keyword.repeat gui=bold cterm=bold guifg=#fb4934")
		vim.cmd("hi! @keyword.operator gui=bold cterm=bold guifg=#fb4934")

		vim.cmd("hi! @function gui=NONE cterm=NONE guifg=#b8bb26")
		vim.cmd("hi! @function.method gui=NONE cterm=NONE guifg=b8bb26")
		vim.cmd("hi! @function.macro gui=NONE cterm=NONE guifg=#8ec07c")
		vim.cmd("hi! @function.builtin gui=NONE cterm=NONE guifg=#fe8019")
		vim.cmd("hi! @function.call gui=NONE cterm=NONE guifg=#b8bb26")

		vim.cmd("hi! @method gui=bold cterm=bold guifg=#b8bb26")
		vim.cmd("hi! @method.call gui=bold cterm=bold guifg=#b8bb26")

		require("plugins.themes.after-load")()
	end,
}
