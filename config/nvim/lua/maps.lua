local map = require("util").map

local opts = { noremap = true, silent = true }

-- Shortcuts
map("n", "<C-t>", ":tabnew<CR>", {noremap = true})

-- Quickfix list
map("n", "<C-]>", ":cnext<CR>", {noremap = true})
map("n", "<C-[>", ":cprev<CR>", {noremap = true})
map("n", "<C-\\>", ":clist<CR>", {noremap = true})

-- Buffer
map("n", "<Leader>]", ":bnext<CR>", {noremap = true})
map("n", "<Leader>[", ":bprev<CR>", {noremap = true})

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

-- Window navigation
map("n", "<C-j>", "<C-w>j", {noremap = true})
map("n", "<C-k>", "<C-w>k", {noremap = true})
map("n", "<C-h>", "<C-w>h", {noremap = true})
map("n", "<C-l>", "<C-w>l", {noremap = true})

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Disable Ex mode
map("n", "Q", "<Nop>", {})
