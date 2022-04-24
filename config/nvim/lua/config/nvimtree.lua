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
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cache", ".yarn" }
  },
  update_focused_file = { enable = true },
})

-- Mappings
vim.keymap.set("n", "<C-n>", function()
  require('nvim-tree').toggle()
end, { noremap = true, silent = true })
