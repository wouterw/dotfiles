local execute = vim.api.nvim_command
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute('packadd packer.nvim')
end

-- Auto source when there are changes in plugins.lua
local group = vim.api.nvim_create_augroup('PackerGroup', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile profile=true',
  group = group,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  profile = { enable = true },
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
    prompt_border = 'rounded',
  },
})

packer.startup(function()
  use('wbthomason/packer.nvim')

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.gitsigns')
    end,
  })

  use({
    'williamboman/mason.nvim',
    requires = {
      -- LSP Support
      { 'williamboman/mason-lspconfig.nvim' },
      { 'neovim/nvim-lspconfig' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
    },
    config = function()
      require('lsp.setup')
      require('lsp.cmp')
    end,
  })

  use({
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins.nvimtree')
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.telescope')
    end,
  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  })

  use({
    'tpope/vim-fugitive',
    config = function()
      require('plugins.fugitive')
    end,
  })

  use('tpope/vim-surround')
  use('tpope/vim-unimpaired')
  use({ 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } })
  use('tpope/vim-repeat')

  use('sheerun/vim-polyglot')

  -- use({
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --     require('themes.github')
  --   end,
  -- })

  use({
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require('themes.catppuccin')
    end,
  })

  use({
    'mhartington/formatter.nvim',
    config = function()
      require('plugins.formatter')
    end,
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  })

  use('simrat39/rust-tools.nvim')
end)
