vim.api.nvim_create_augroup("auto_create_dir", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
	group = "auto_create_dir",
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "Illuminate", { bg = "#504945" })
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Illuminate" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Illuminate" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Illuminate" })
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	pattern = { "@" },
	callback = function()
		if vim.b.visual_multi then
			local delay = 0
			vim.defer_fn(function()
				vim.cmd('execute "redrawstatus"')
			end, delay)
		end
	end,
})
