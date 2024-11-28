vim.api.nvim_create_augroup("AutoCreateDir", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
	group = "AutoCreateDir",
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
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

vim.api.nvim_create_augroup("WeztermColorscheme", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "WeztermColorscheme",
	callback = function(args)
		local colorscheme = ({
			["vague"] = "Default",
			["gruvbox"] = "GruvboxLight",
		})[args.match]

		-- after changing colorscheme, appears second statusline.
		-- it's vim-tpipeline conflict, to avoid this, we should set laststatus=0,
		-- but it works only with a little delay
		--- @see https://github.com/vimpostor/vim-tpipeline/issues/53
		vim.defer_fn(function()
			vim.opt.laststatus = 0
		end, 10)

		if colorscheme == nil then
			return
		end

		-- TODO: implement terminal emulator checker
		local is_wezterm = true
		if is_wezterm then
			local filename = vim.fn.expand("$XDG_CONFIG_HOME/wezterm/nvim_colorscheme")
			assert(type(filename) == "string")
			local file = io.open(filename, "w")
			assert(file)
			file:write(colorscheme)
			file:close()
			vim.notify("Setting WezTerm color scheme to " .. colorscheme, vim.log.levels.INFO)
		end

		-- local is_kitty = false
		-- if is_kitty then
		-- 	vim.fn.system({
		-- 		"kitty",
		-- 		"@",
		-- 		"set-color",
		-- 		"background=#" .. vim.fn.printf("%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg),
		-- 	})
		-- end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = { "*" },
	callback = function()
		local ok, lualine = pcall(require, "lualine")
		if ok then
			local lualine_utils = require("utils.configs.lualine")
			lualine.setup(lualine_utils.get_config())
		end

		local utils = require("utils")
		-- TODO: use better highlight colors
		if utils.is_dark_mode() then
			vim.api.nvim_set_hl(0, "Illuminate", { bg = "#504945" })
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Illuminate" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Illuminate" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Illuminate" })
		else
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "hl-LspReferenceText", underline = false })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "hl-LspReferenceRead", underline = false })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "hl-LspReferenceWrite", underline = false })
		end
	end,
})
