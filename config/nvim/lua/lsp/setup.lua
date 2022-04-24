local lsp_installer = require('nvim-lsp-installer')

local servers = {
  'cssls',
  'efm',
  'elixirls',
  'jsonls',
  'pyright',
  'rust_analyzer',
  'solargraph',
  'tsserver',
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print('[nvim-lsp-installer]: Installing ' .. name)
    server:install()
  end
end

local custom_server_opts = {
  ['efm'] = true,
}

lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local default_opts = require('lsp.opts')

  if custom_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    require('lsp.servers.' .. server.name).setup(default_opts)
  end

  server:setup(default_opts)
end)

-- Diagnostic icons
local signs = { Error = ' ', Warn = ' ', Hint = '硫', Info = ' ' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end
