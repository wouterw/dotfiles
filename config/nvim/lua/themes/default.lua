local is_dark_mode = require('themes.is_dark_mode')
local flavour = (is_dark_mode() and 'dark' or 'light')
vim.cmd('set background='..flavour)

-- Remove background
-- vim.cmd([[ highlight Normal guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE ]])
-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
