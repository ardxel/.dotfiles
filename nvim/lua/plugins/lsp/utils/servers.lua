local LspServerManager = {}

function LspServerManager:new()
	local private = {}
	private.servers = {}
	-- TODO

	private.ignore_servers = {

		-- "tailwindcss",
		"emmet_ls",
	}

	local public = {}
	setmetatable(public, self)

	--- add server with extra options
	---@param name string - lsp name
	---@param extra table - extra options
	---@return boolean
	function public:add(name, extra)
		if private.servers[name] ~= nil then
			return false
		end

		private.servers[name] = extra
		return true
	end

	--- setup all lsp servers
	---@param lsp table lsp configuration
	---@param extra table options
	function public:setup(lsp, extra)
		for lsp_name, opts in pairs(private.servers) do
			if vim.tbl_contains(private.ignore_servers, lsp_name) == false then
				local options = vim.tbl_extend("force", opts, extra)
				lsp[lsp_name].setup(options)
			end
		end
	end

	return public
end

local serverManager = LspServerManager:new()

-- TAILWIND CSS
serverManager:add("tailwindcss", {
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
})
-- CSS
serverManager:add("cssls", {})

-- HTML
serverManager:add("html", {})

-- LUA
serverManager:add("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
		},
	},
})

-- BASH
serverManager:add("bashls", {
	filetypes = { "sh", "aliasrc", "zsh" },
})

-- DOCKER
serverManager:add("dockerls", {})

-- JSON
serverManager:add("jsonls", {
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			schemas = require("plugins.lsp.utils.json-schemas"),
		},
	},
})

-- EMMET
serverManager:add("emmet_ls", {})

-- MARKDOWN
serverManager:add("marksman", {})

-- SQL / PSQL
serverManager:add("sqlls", {
	filetypes = { "sql", "mysql", "psql" },
	root_dir = function(_)
		return vim.loop.cwd()
	end,
})

-- YAMLLS
serverManager:add("yamlls", {
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
})

serverManager:add("gopls", {
	settings = {
		gopls = {
			usePlaceholders = false,
		},
	},
})

return serverManager
