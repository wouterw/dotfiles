local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Shortcuts
map('n', '<C-t>', ':tabnew<CR>', opt)

-- Quickfix list
map('n', '<C-]>', ':cnext<CR>', opt)
map('n', '<C-[>', ':cprev<CR>', opt)
map('n', '<C-\\>', ':clist<CR>', opt)

-- bind K to grep word under cursor
-- map('n', 'K', ':grep! "\b<C-R><C-W>\b"<CR>:cw<CR>', opt)

-- Buffer
map('n', '<Leader>]', ':bnext<CR>', opt)
map('n', '<Leader>[', ':bprev<CR>', opt)

-- Window navigation
map('n', '<C-j>', '<C-w>j', opt)
map('n', '<C-k>', '<C-w>k', opt)
map('n', '<C-h>', '<C-w>h', opt)
map('n', '<C-l>', '<C-w>l', opt)

-- Disable Ex mode
map('n', 'Q', '<Nop>', opt)

-- Move visual selection up or down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
