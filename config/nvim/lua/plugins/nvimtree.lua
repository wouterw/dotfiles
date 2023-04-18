require('nvim-tree').setup({
  view = {
    signcolumn = 'no',
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      webdev_colors = false,
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false,
      },
      symlink_arrow = ' ⟶ ',
      glyphs = {
        symlink = '',
        folder = {
          arrow_closed = '●',
          arrow_open = '○',
          default = '●',
          empty = '◌',
          empty_open = '○',
          open = '○',
        },
      },
    },
    special_files = {},
  },
  update_focused_file = { enable = true },
  diagnostics = { enable = true },
  filters = {
    custom = { '^.git$' },
  },
})

-- Mappings
vim.keymap.set('n', '<C-n>', function()
  require('nvim-tree.api').tree.toggle()
end, { noremap = true, silent = true })
