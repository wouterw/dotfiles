local map = require("util").map

local opts = { noremap = true, silent = true }

-- Shortcuts
map("n", "<C-t>", ":tabnew<CR>", opts)

-- Quickfix list
map("n", "<C-]>", ":cnext<CR>", opts)
map("n", "<C-[>", ":cprev<CR>", opts)
map("n", "<C-\\>", ":clist<CR>", opts)

-- Buffer
map("n", "<Leader>]", ":bnext<CR>", opts)
map("n", "<Leader>[", ":bprev<CR>", opts)

-- Window navigation
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Disable Ex mode
map("n", "Q", "<Nop>", opts)
