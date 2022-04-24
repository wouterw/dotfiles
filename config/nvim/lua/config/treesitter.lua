require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  sync_install = false,
  autopairs = {
    enabled = true,
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  fold = { enable = true },
  autotag = { enable = true },
}
