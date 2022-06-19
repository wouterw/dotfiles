local function is_dark_mode()
  local result = vim.fn.systemlist('defaults read -g AppleInterfaceStyle')
  return result[1] == 'Dark'
end

require('github-theme').setup({
  theme_style = is_dark_mode() and 'dark_default' or 'light_default',
  dark_sidebar = false,
  transparent = true,
})
