local function is_dark_mode()
  local result = vim.fn.systemlist('defaults read -g AppleInterfaceStyle')
  return result[1] == 'Dark'
end

require('github-theme').setup({
  dim_inactive = false,
})

vim.cmd.colorscheme(is_dark_mode() and 'github_dark_high_contrast' or 'github_light_high_contrast')
