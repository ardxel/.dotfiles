local map = vim.keymap
local opts = { noremap = true, silent = true }

-- DIRECTORY NAVIGATION
map.set("n", "<leader>m", ":NvimTreeFocus<CR>", opts)
map.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- PANEL NAVIGATION
map.set("n", "<C-h>", "<C-w>h", opts)
map.set("n", "<C-j>", "<C-w>j", opts)
map.set("n", "<C-k>", "<C-w>k", opts)
map.set("n", "<C-l>", "<C-w>l", opts)

-- WINDOW MANAGEMENT
map.set("n", "<leader>sh", ":vsplit<CR>", opts) -- split vertical
map.set("n", "<leader>sv", ":split<CR>", opts) -- split horizontal

-- SELECT ALL
map.set("n", "<C-S-A>", "gg<S-v>G")

-- BUFFERLINE MANAGMENT
map.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
map.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

map.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map.set("x", "y", '"+y')
map.set("n", "y", '"+y')

-- TROUBLE.NVIM
-- Document Diagnostics (Trouble)
map.set("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>")
-- Workspace Diagnostics (Trouble)
map.set("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>")
-- Location List (Trouble)
map.set("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>")
-- Quickfix List (Trouble)
map.set("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>")

-- Zen mode
map.set("n", "<leader>tzm", "<cmd>ZenMode<cr>", opts)
