local M = {}

M.setup = function(opts)
	for severity, icon in pairs(opts.diagnostics.signs.text) do
		local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end

	local lsp_utils = require("utils.lsp")
	local servers = require("utils.servers").servers
	servers = vim.deepcopy(servers)
	local lspconfig = require("lspconfig")
	local blink_cmp = require("blink.cmp")

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink_cmp.get_lsp_capabilities(),
		opts.capabilities or {}
	)
	vim.diagnostic.config(opts.diagnostics)
	require("neoconf").setup()

	for lsp_name, lsp_opts in pairs(servers) do
		lspconfig[lsp_name].setup(vim.tbl_deep_extend("force", lsp_opts, {
			on_attach = lsp_utils.on_attach,
			capabilities = capabilities,
			handlers = lsp_utils.handlers,
		}))
	end
end

return M
