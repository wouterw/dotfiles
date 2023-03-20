require('mason.settings').set({
  ui = {
    border = 'rounded',
  },
})

local lsp = require('lsp-zero').preset({ name = 'recommended' })

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
