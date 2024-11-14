local M = {
	cssls = {},
	dockerls = {},
	marksman = {},
	emmet_ls = {},
	tailwindcss = {
		flags = { debounce_text_changes = 300 },
		exclude = { "*.ts", ".js" },
		filetypes = {
			"html",
			"css",
			"scss",
			"less",
			"javascriptreact",
			"typescriptreact",
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemas = {
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
					["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
				},
			},
		},
	},
	lua_ls = {
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			})
		end,
		settings = {
			Lua = {},
		},
	},
	bashls = {
		filetypes = { "sh", "aliasrc", "zsh" },
	},
	jsonls = {
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				schemas = require("plugins.lsp.utils.json-schemas"),
			},
		},
	},
	gopls = {
		filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl" },
		settings = {
			gopls = {
				usePlaceholders = false,
				templateExtensions = { "tmpl", "html", "gotmpl" },
			},
		},
	},
	html = {
		filetypes = { "html", "gotmpl", "tmpl" },
	},
}

return M
