function change_gruvbox_highlights()
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
end

return function(theme_name)
	if string.match(theme_name, "gruvbox") then
		change_gruvbox_highlights()
	end

	if string.match(theme_name, "tokyo") == false then
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
