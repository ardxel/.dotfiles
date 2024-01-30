local create_menu = require("config.ui.menu")
local keymap = vim.keymap

local M = {}

M.ts_features = function()
	local opts = {
		border = {
			text = {
				top = "[Typescript features]",
				top_align = "center",
			},
		},
	}

	local items = {
		{ text = "Organize imports", cmd = "TSToolsOrganizeImports" },
		{ text = "Remove unused imports", cmd = "TSToolsRemoveUnusedImports" },
		{ text = "Add missing imports", cmd = "TSToolsAddMissingImports" },
		{ text = "Sort imports", cmd = "TSToolsSortImports" },
		{ text = "Remove unused statements", cmd = "TSToolsRemoveUnused" },
		{ text = "Fix all", cmd = "TSToolsFixAll" },
	}

	local bind = function(menu)
		keymap.set("n", "<leader>tt", function()
			local active_clients = vim.lsp.get_active_clients()
			local proper_clients = { "tsserver", "typescript-tools" }

			for _, client in ipairs(active_clients) do
				for _, proper in pairs(proper_clients) do
					if client.name == proper then
						menu:mount()
					end
				end
			end
		end, { noremap = true, silent = true })
	end

	create_menu(opts, items, bind)
end

M.neogen_docs = function()
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
		keymap.set("n", "<leader>ng", function()
			menu:mount()
		end)
	end

	create_menu(opts, items, bind)
end

return {
	"MunifTanjim/nui.nvim",
	config = function()
		M.ts_features()
		M.neogen_docs()
	end,
}
