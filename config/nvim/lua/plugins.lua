local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.gitsigns')
    end
  }

  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('config.spellsitter')
    end
  }

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'

  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require("lsp.setup")
    end
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require("config.cmp")
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("config.telescope")
    end
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("config.nvimtree")
    end
  }

  use {
    'tpope/vim-fugitive',
    config = function()
      require("config.fugitive")
    end
  }

  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
  use 'tpope/vim-repeat'

  use 'sheerun/vim-polyglot'
  use 'projekt0n/github-nvim-theme'

  use {
    'mhartington/formatter.nvim',
    config = function()
      require("config.formatter")
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }
end)
