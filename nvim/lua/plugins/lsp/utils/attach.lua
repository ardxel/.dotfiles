local attach = function(client, bufnr)
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts)
	keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions, opts)
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<cr>", opts)
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
	keymap.set("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", opts)
end

return attach
