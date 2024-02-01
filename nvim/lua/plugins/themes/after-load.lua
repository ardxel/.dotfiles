return function(theme_name)
	if theme_name == "gruvbox-material" then
		vim.cmd("hi! Keyword gui=bold cterm=bold")
		vim.cmd("hi! @keyword gui=bold cterm=bold ctermfg=167 guifg=#ea6962")
		vim.cmd("hi! @keyword.return gui=bold cterm=bold")
		vim.cmd("hi! @keyword.import gui=bold cterm=bold")
		vim.cmd("hi! @keyword.debug gui=bold cterm=bold")
		vim.cmd("hi! @keyword.repeat gui=bold cterm=bold")
		vim.cmd("hi! @keyword.operator gui=bold cterm=bold")
		vim.cmd("hi! @keyword.function gui=NONE cterm=NONE")

		vim.cmd("hi! Function gui=NONE cterm=NONE")
		vim.cmd("hi! @function gui=NONE cterm=NONE")
		vim.cmd("hi! @function.method gui=NONE cterm=NONE")
		vim.cmd("hi! @function.method.call gui=NONE cterm=NONE")
		vim.cmd("hi! @function.macro gui=NONE cterm=NONE")
		vim.cmd("hi! @function.builtin gui=NONE cterm=NONE")
		vim.cmd("hi! @function.call gui=NONE cterm=NONE")

		vim.cmd("hi! @method gui=NONE cterm=NONE")
		vim.cmd("hi! @method.call gui=NONE cterm=NONE")
		vim.cmd("hi! YellowItalic gui=NONE cterm=NONE ctermfg=214 guifg=#d8a657")
	end

	if theme_name ~= "tokyo_night" then
		vim.cmd("hi! SignColumn guibg=NONE ctermbg=NONE")
		vim.cmd("hi! NvimTreeNormal guibg=NONE ctermbg=NONE")
		vim.cmd("hi! Normal guibg=NONE  ctermbg=NONE")
		vim.cmd("hi! NonText guibg=NONE guifg=NONE ctermbg=NONE")
		vim.cmd("hi! Pmenu guibg=NONE ctermbg=NONE")
		vim.cmd("hi! NormalFloat guibg=NONE ctermbg=NONE")
		vim.cmd("hi! Float guibg=NONE ctermbg=NONE")
		vim.cmd("hi! NormalFloatBorder ctermbg=NONE guibg=NONE")
		vim.cmd("hi! LspFloatWinBorder ctermbg=NONE guibg=NONE")
		vim.cmd("hi! TelescopeBorder ctermbg=NONE guibg=NONE")
	end
end
