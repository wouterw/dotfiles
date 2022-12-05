require('lsp.visual').setup()

local servers = {
  'cssls',
  'elixirls',
  'eslint',
  'jsonls',
  'pyright',
  -- 'rust_analyzer',
  'solargraph',
  'tsserver',
}

require('mason').setup({
  ui = { border = 'rounded' },
})

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Specify the default options which we'll use to setup all servers
local default_opts = require('lsp.opts')

for _, name in ipairs(servers) do
  -- Enhance the default opts with the server-specific ones
  -- pcall(function()
  --   require('lsp.servers.' .. name).setup(default_opts)
  -- end)

  require('lspconfig')[name].setup(default_opts)
end

require('rust-tools').setup({
  tools = {
    inlay_hints = {
      auto = true,
    },
  },
  server = {
    on_attach = default_opts.on_attach,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
  },
})
