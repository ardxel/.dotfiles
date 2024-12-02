local M = {}
--- @param items table<{text: string, action: string | function}>
--- @param props? table<{title: string}>
--- @return NuiMenu
function M.create_popup_menu(items, props)
	local instance_menu = require("nui.menu")

	--- @type nui_popup_options
	local popup_opts = {
		relative = "editor",
		size = {
			width = 40,
			height = #items + 2, -- Add padding for title and borders
		},
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
	}

	if props and type(props) == "table" then
		popup_opts.border.text.top = props.title or "Menu"
	end

	--- @type nui_menu_options
	local opts = {
		lines = {},
		max_width = 70,
		min_width = 20,
		keymap = {
			focus_next = { "<C-n>", "<Down>", "<Tab>" },
			focus_prev = { "<C-p>", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_submit = function(item)
			if type(item.action) == "string" then
				vim.cmd(item.action)
			else
				item.action()
			end
		end,
	}

	for i, item in ipairs(items) do
		local line = instance_menu.item({
			text = ("%d. %s"):format(i, item.text),
			action = item.action,
			id = i,
		})
		table.insert(opts.lines, line)
	end

	return instance_menu(popup_opts, opts)
end

return M
