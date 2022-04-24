local lsp_installer = require('nvim-lsp-installer')
local opts = require('lsp.opts')

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

USER = vim.fn.expand('$USER')

-- Automatic Installation
for _, name in pairs(servers) do
  local ok, server = lsp_installer.get_server(name)
  -- Check that the server is supported in nvim-lsp-installer
  if ok then
    if not server:is_installed() then
      print('[nvim-lsp-installer]: Installing ' .. name .. ' ...')
      server:install()
    end
  end
end

-- Configuration
lsp_installer.on_server_ready(function(server)
  local default_opts = opts

  local server_opts = {
    ['efm'] = function()
      default_opts = opts

      local eslint = {
        lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
        lintStdin = true,
        lintFormats = { '%f:%l:%c: %m' },
        lintIgnoreExitCode = true,
        formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
        formatStdin = true,
      }

      default_opts.settings = {
        languages = {
          javascript = { eslint },
          javascriptreact = { eslint },
          typescript = { eslint },
          typescriptreact = { eslint },
        },
      }

      default_opts.filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      }

      return default_opts
    end,
  }

  -- We check to see if any custom server_opts exist for the LSP server, if so, load them, if not, use our default_opts
  server:setup(server_opts[server.name] and server_opts[server.name]() or opts)

  vim.cmd([[ do User LspAttachBuffers ]])
end)

-- Diagnostic icons
local signs = { Error = ' ', Warn = ' ', Hint = '硫', Info = ' ' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end
