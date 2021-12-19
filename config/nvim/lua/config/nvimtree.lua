vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1

vim.g.nvim_tree_quit_on_open = 1

vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_root_folder_modifier = ":p:~"

vim.g.nvim_tree_symlink_arrow = ' ⤑  '

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌"
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
}

require("nvim-tree").setup({
  diagnostics = { enable = true },
  tab_open = true,
  auto_close = false,
  view = {
    width = 30,
    side = "left"
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500
  },
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
