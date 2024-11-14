local M = {}

M.on_attach = function(_, bufnr)
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts, "Show Definition")
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<cr>", opts, "Go to Definition")
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts, "lspsaga diagnostic jump next")
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts, "lspsaga diagnostic jump prev")
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", opts, "lspsaga line diagnostic")
	keymap.set("n", "<leader>cr", require("live-rename").map({ insert = true }), opts, "lspsaga rename")
end

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
M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return M
