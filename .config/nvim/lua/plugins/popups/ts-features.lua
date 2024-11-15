local ts_features = function()
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
		vim.keymap.set("n", "<leader>tt", function()
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

	local create_menu = require("config.ui.menu")
	create_menu(opts, items, bind)
end

return ts_features
