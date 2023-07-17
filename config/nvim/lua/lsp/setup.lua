local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', '<leader>vca', function()
    vim.lsp.buf.code_action()
  end, opts)
end)

require('mason').setup({
  ui = {
    border = 'rounded',
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer' },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
  },
})

require('lsp-zero').extend_cmp()

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- `Ctrl+Space` to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  },
})
