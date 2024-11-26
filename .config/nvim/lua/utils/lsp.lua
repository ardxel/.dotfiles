local M = {}

M.on_attach = function(_, bufnr)
	local keymap = vim.keymap
	local default_opts = { noremap = true, silent = true, buffer = bufnr }

	local opts = function(description)
		return vim.tbl_extend("force", {}, default_opts, { desc = description })
	end

	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts("Show Definition"))
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<cr>", opts("Go to Definition"))
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts("lspsaga diagnostic jump next"))
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts("lspsaga diagnostic jump prev"))
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", opts("lspsaga line diagnostic"))
	keymap.set("n", "<leader>cR", "<cmd>Lspsaga rename<cr>", opts("lspsaga rename"))
	keymap.set("n", "<leader>cr", require("live-rename").map({ insert = true }), opts("live rename"))
end

-- Add the border on hover and on signature help popup window
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

M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = M.border("FloatBorder"),
	}),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = M.border("FloatBorder") }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = function(diagnostic)
				local icons = require("config.icons").diagnostics
				return vim.tbl_values(icons)[diagnostic.severity] or icons.Hint
			end,
		},
	}),
}

return M
