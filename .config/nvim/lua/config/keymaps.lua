local map = vim.keymap
local opts = { noremap = true, silent = true }
local function with_desc(desc)
	local extended = vim.tbl_extend("force", vim.deepcopy(opts), { desc = desc })
	return extended
end

-- DIRECTORY NAVIGATION
-- map.set("n", "<leader>e", ":Neotree toggle<CR>", with_desc("Neotree toggle"))
-- map.set("n", "<leader>m", ":Neotree focus<CR>", with_desc("Neotree focus"))

-- PANEL NAVIGATION
map.set("n", "<C-h>", "<C-w>h", with_desc("Move left"))
map.set("n", "<C-j>", "<C-w>j", with_desc("Move down"))
map.set("n", "<C-k>", "<C-w>k", with_desc("Move up"))
map.set("n", "<C-l>", "<C-w>l", with_desc("Move down"))

-- RESIZE WINDOW
map.set("n", "<C-w><left>", "<C-w><", with_desc("Resize to left"))
map.set("n", "<C-w><right>", "<C-w>>", with_desc("Resize to right"))
map.set("n", "<C-w><up>", "<C-w>+", with_desc("Resize to up"))
map.set("n", "<C-w><down>", "<C-w>-", with_desc("Resize to down"))

-- WINDOW MANAGEMENT
map.set("n", "<leader>sv", ":vsplit<CR>", with_desc("Split vertical"))
map.set("n", "<leader>sh", ":split<CR>", with_desc("Split horizontal"))

-- SELECT ALL
map.set("n", "<C-s-a>", "gg<S-v>G", { desc = "Select all" })

-- BUFFERLINE MANAGMENT
map.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", with_desc("Buffer Next"))
map.set("n", "<s-Tab>", "<cmd>BufferLineCyclePrev<CR>", with_desc("Buffer Prev"))

map.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy" })
map.set({ "n", "x" }, "<leader>Y", '"+yg_', { desc = "Copy to clipboard" })
map.set({ "n", "x" }, "<leader>d", '"+d', { desc = "Delete line and copy" })
map.set({ "n", "x" }, "<leader>D", '"+dg_', { desc = "Delete line and copy to clipboard" })
map.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from vim proccess" })
map.set({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste from clipboard" })

-- IF NEOVIDE
if vim.g.neovide then
	-- Allow clipboard copy paste in neovim
	vim.g.neovide_input_use_logo = 2

	vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", opts)
	vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", opts)
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", opts)
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", opts)
end
