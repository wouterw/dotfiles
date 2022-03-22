vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1

vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_root_folder_modifier = ":p:~"

vim.g.nvim_tree_symlink_arrow = ' ⤑  '

vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 0,
  files = 0,
  folder_arrows = 0,
}

require("nvim-tree").setup({
  diagnostics = { enable = true },
  tab_open = true,
  auto_close = false,
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cache", ".yarn" }
  },
  update_focused_file = {
    enable = true
  },
})

-- Mappings
local map = require("util").map
map("n", "<C-n>", ":lua require('nvim-tree').toggle()<CR>", {noremap = true, silent = true})
