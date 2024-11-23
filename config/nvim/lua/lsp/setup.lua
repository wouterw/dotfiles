local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })

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
end

lsp_zero.extend_lspconfig({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  lsp_attach = lsp_attach,
  float_border = 'rounded',
  sign_text = true,
})

require('lspconfig.ui.windows').default_options.border = 'rounded'

require('mason').setup({
  ui = {
    border = 'rounded',
  },
})

require('mason-lspconfig').setup({
  ensure_installed = { 'ruby_lsp', 'lua_ls', 'ts_ls', 'rust_analyzer' },
  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

require('lspconfig').ruby_lsp.setup({
  init_options = {
    formatter = 'syntax_tree',
  },
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

local cmp = require('cmp')

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
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})
