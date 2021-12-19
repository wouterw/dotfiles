require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true },
  context_commentstring = { enable = true },
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
