---@param opts table
---@param items table
---@param bind function
local createMenu = function(opts, items, bind)
	local Menu = require("nui.menu")
	local M = {}

	M.opts = opts or {}

	M.popup_options = vim.tbl_deep_extend("force", {
		position = "50%",
		border = {
			style = "rounded",
			text = {
				top = "Menu",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None",
		},
	}, opts)

	M.lines = {}
	M.commands = {}

	for i, v in ipairs(items) do
		table.insert(M.lines, Menu.item(("%d. %s"):format(i, v.text), { id = i }))
		table.insert(M.commands, v.cmd)
	end

	M.on_submit = function(insered)
		vim.cmd(M.commands[insered.id])
	end

	local menu = Menu(M.popup_options, {
		lines = M.lines,
		max_width = 70,
		min_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_submit = M.on_submit,
	})

	bind(menu)
end

return createMenu
