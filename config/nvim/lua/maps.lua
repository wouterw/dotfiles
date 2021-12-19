local map = require("util").map

-- Shortcuts
map("n", "<C-t>", ":tabnew<CR>", {noremap = true})

-- Quickfix list
map("n", "<C-]>", ":cnext<CR>", {noremap = true})
map("n", "<C-[>", ":cprev<CR>", {noremap = true})
map("n", "<C-\\>", ":clist<CR>", {noremap = true})

-- Buffer
map("n", "<Leader><Esc>", ":bd<CR>", {noremap = true})
map("n", "<C-l>", ":%bd!<CR>", {noremap = true})
map("n", "<Leader>]", ":bnext<CR>", {noremap = true})
map("n", "<Leader>[", ":bprev<CR>", {noremap = true})

-- Window navigation
map("n", "<C-j>", "<C-w>j", {noremap = true})
map("n", "<C-k>", "<C-w>k", {noremap = true})
map("n", "<C-h>", "<C-w>h", {noremap = true})
map("n", "<C-l>", "<C-w>l", {noremap = true})

-- Disable Ex mode
map("n", "Q", "<Nop>", {})
