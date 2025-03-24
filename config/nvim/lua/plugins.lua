local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  },

  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.surround').setup()
      require('mini.ai').setup()
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },

  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true }
    },
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      require('lsp.setup')
    end,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      require('plugins.oil')
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.telescope')
    end,
  },

  {
    'tpope/vim-fugitive',
    config = function()
      require('plugins.fugitive')
    end,
  },

  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('plugins.formatter')
    end,
  },

  { 'github/copilot.vim' },
}, {
  ui = {
    border = 'rounded',
  },
})
