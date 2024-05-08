local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', '<leader>vca', function()
    vim.lsp.buf.code_action()
  end, opts)

  vim.keymap.set('n', '<leader>vrr', function()
    vim.lsp.buf.references()
  end, opts)

  vim.keymap.set('n', '<leader>vrn', function()
    vim.lsp.buf.rename()
  end, opts)
end)

require('lspconfig.ui.windows').default_options.border = 'rounded'

require('mason').setup({
  ui = {
    border = 'rounded',
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'ruby_lsp', 'lua_ls', 'tsserver', 'rust_analyzer' },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
  },
})

lsp.set_sign_icons({
  error = '⨯',
  warn = '⊘',
  hint = '⊙',
  info = '▸',
})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})

require('lsp-zero').extend_cmp()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = {
    -- confirm completion item
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- toggle completion menu
    ['<C-e>'] = cmp_action.toggle_completion(),

    -- `Ctrl+Space` to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  },
})
