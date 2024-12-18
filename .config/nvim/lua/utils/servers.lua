local M = {}

M.servers = {
	cssls = {},
	dockerls = {},
	marksman = {},
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
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				diagnostics = {
					globals = { "vim" },
					disable = { "incomplete-signature-doc", "trailing-space" },
				},
				format = {
					enable = false,
				},
			},
		},
	},
	bashls = {
		settings = {
			filetypes = { "sh", "zsh" },
		},
	},
	jsonls = {
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = {
							".prettierrc",
							".prettierrc.json",
							"prettier.config.json",
						},
						url = "https://json.schemastore.org/prettierrc.json",
					},
					{
						fileMatch = { "now.json", "vercel.json" },
						url = "https://json.schemastore.org/now.json",
					},
					{
						fileMatch = { "app.json" },
						url = "https://json.schemastore.org/expo-46.0.0.json",
					},
				},
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
	pyright = {},
}

return M
