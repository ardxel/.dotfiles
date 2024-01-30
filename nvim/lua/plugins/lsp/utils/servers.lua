local LspServerManager = {}

function LspServerManager:new()
	local private = {}
	private.servers = {}

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

		private.servers[name] = vim.tbl_extend("force", {}, extra)
		return true
	end

	--- setup all lsp servers
	---@param lsp table lsp configuration
	---@param opts table options
	function public:setup(lsp, opts)
		for lsp_name, extra in pairs(private.servers) do
			local options = vim.tbl_extend("force", extra, opts)
			lsp[lsp_name].setup(options)
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
	diagnostics = {
		Lua = {
			globals = { "vim" },
		},
	},
})

-- BASH
serverManager:add("bashls", {
	filetypes = { "sh", "aliasrc" },
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

return serverManager
