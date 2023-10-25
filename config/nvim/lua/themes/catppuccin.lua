-- local is_dark_mode = require('themes.is_dark_mode')

-- local flavour = (is_dark_mode() and 'mocha' or 'latte')

require('catppuccin').setup({ flavour = 'mocha', transparent_background = true })

vim.cmd.colorscheme('catppuccin')
