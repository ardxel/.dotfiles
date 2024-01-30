local border = {
	{ "┌", "Normal" },
	{ "─", "Normal" },
	{ "┐", "Normal" },
	{ "│", "Normal" },
	{ "┘", "Normal" },
	{ "─", "Normal" },
	{ "└", "Normal" },
	{ "│", "Normal" },
}

-- Add the border on hover and on signature help popup window
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return handlers
