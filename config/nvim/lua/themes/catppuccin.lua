-- local is_dark_mode = require('themes.is_dark_mode')

-- local flavour = (is_dark_mode() and 'mocha' or 'latte')

require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = false,
  color_overrides = {
    mocha = {
      base = '#000000',
      mantle = '#000000',
      crust = '#000000',
    },
  },
})

vim.cmd.colorscheme('catppuccin')
