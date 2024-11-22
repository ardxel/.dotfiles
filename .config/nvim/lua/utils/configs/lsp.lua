local M = {}

M.setup = function(opts)
	local lsp_utils = require("utils.lsp")
	local servers = lsp_utils.servers()
	local lspconfig = require("lspconfig")
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {},
		opts.capabilities or {}
	)

	require("neoconf").setup()

	for lsp_name, lsp_opts in pairs(servers) do
		lspconfig[lsp_name].setup(vim.tbl_deep_extend("force", lsp_opts, {
			on_attach = lsp_utils.on_attach,
			capabilities = capabilities,
			handlers = lsp_utils.handlers,
		}))
	end

	vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
end

return M
