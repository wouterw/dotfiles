return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
      local fzf = require('fzf-lua')

      fzf.setup {
        { 'max-perf' },
        fzf_colors = true,
        winopts = { preview = { hidden = true } }
      }

      local map = vim.keymap.set
      local opt = { noremap = true, silent = true }

      map('n', '<Leader>ff', function() fzf.files({ resume = true }) end, opt)
      map('n', '<Leader>fg', function() fzf.grep({ resume = true }) end, opt)
    end
  }
}
