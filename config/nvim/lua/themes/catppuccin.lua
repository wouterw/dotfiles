local function is_dark_mode()
  local result = vim.fn.systemlist('defaults read -g AppleInterfaceStyle')
  return result[1] == 'Dark'
end

local flavour = (is_dark_mode() and 'mocha' or 'latte')

vim.cmd.colorscheme('catppuccin')

require('catppuccin').setup({ flavour = flavour, transparent_background = true })
