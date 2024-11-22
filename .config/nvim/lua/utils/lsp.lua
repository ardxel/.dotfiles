local M = {}

M.json_schemas = function()
	local schemas = {
		{
			fileMatch = { "package.json" },
			url = "https://json.schemastore.org/package.json",
		},
		{
			fileMatch = { "tsconfig*.json" },
			url = "https://json.schemastore.org/tsconfig.json",
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
			fileMatch = { ".eslintrc.json" },
			url = "https://json.schemastore.org/eslintrc.json",
		},
		{
			fileMatch = {
				".babelrc",
				".babelrc.json",
				"babel.config.json",
				"babel.config.js",
			},
			url = "https://json.schemastore.org/babelrc.json",
		},
		{
			fileMatch = { "now.json", "vercel.json" },
			url = "https://json.schemastore.org/now.json",
		},
		{
			fileMatch = {
				".stylelintrc",
				".stylelintrc.json",
				"stylelint.config.json",
			},
			url = "http://json.schemastore.org/stylelintrc.json",
		},
		{
			fileMatch = {
				"app.json",
			},
			url = "https://json.schemastore.org/expo-46.0.0.json",
		},
	}
	return schemas
end

M.servers = function()
	return {
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
					schemas = M.json_schemas(),
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
end

M.on_attach = function(_, bufnr)
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts, "Show Definition")
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<cr>", opts, "Go to Definition")
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts, "lspsaga diagnostic jump next")
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts, "lspsaga diagnostic jump prev")
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", opts, "lspsaga line diagnostic")
	keymap.set("n", "<leader>cR", "<cmd>Lspsaga rename<cr>", opts, "lspsaga rename")
	keymap.set("n", "<leader>cr", require("live-rename").map({ insert = true }), opts, "live rename")
	-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts, "lspsaga hover")
end

M.border = function(hl_name)
	return {
		{ "┌", hl_name },
		{ "─", hl_name },
		{ "┐", hl_name },
		{ "│", hl_name },
		{ "┘", hl_name },
		{ "─", hl_name },
		{ "└", hl_name },
		{ "│", hl_name },
	}
end
-- Add the border on hover and on signature help popup window
M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = M.border("FloatBorder"),
	}),
	["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = M.border("FloatBorder") }
	),
}

return M
