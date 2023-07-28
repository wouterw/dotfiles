local is_dark_mode = require('themes.is_dark_mode')

require('github-theme').setup({
  options = {
    dim_inactive = false,
    transparent = true,
  },
})

vim.cmd.colorscheme(is_dark_mode() and 'github_dark_high_contrast' or 'github_light_high_contrast')
