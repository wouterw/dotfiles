local map = vim.keymap.set
local opt = { noremap = true }

-- Git
-- NOTE: 'dv' to get conflicts
-- NOTE: Ctrl+w & Ctrl+o to save
map('n', '<Leader>gh', ':diffget //2<CR>', opt)
map('n', '<Leader>gl', ':diffget //3<CR>', opt)

-- push & pull
map('n', '<Leader>gs', ':Git<CR>', opt)
map('n', '<Leader>gp', ':G push<CR>', opt)
map('n', '<Leader>gl', ':G pull<CR>', opt)

-- rebase
map('n', '<space>grb', ':G rebase ', opt)

-- fetch
map('n', '<space>gf', ':G fetch ', opt)
map('n', '<space>gfo', ':G fetch origin<CR>', opt)

-- reset
map('n', '<space>grs', ':G reset --soft HEAD~1<CR>', opt)
map('n', '<space>grh', ':G reset --hard HEAD~1<CR>', opt)
