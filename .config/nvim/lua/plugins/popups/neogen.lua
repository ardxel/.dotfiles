local neogen_docs = function()
	local opts = {
		border = {
			text = {
				top = "[Generate docs]",
				top_align = "center",
			},
		},
	}

	local items = {
		{ text = "func", cmd = ":Neogen func" },
		{ text = "type", cmd = ":Neogen type" },
		{ text = "class", cmd = ":Neogen class" },
	}

	local bind = function(menu)
		vim.keymap.set("n", "<leader>ng", function()
			menu:mount()
		end)
	end

	local create_menu = require("config.ui.menu")
	create_menu(opts, items, bind)
end

return neogen_docs
