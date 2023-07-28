local function is_dark_mode()
  local result = vim.fn.systemlist('defaults read -g AppleInterfaceStyle')
  return result[1] == 'Dark'
end

return is_dark_mode
