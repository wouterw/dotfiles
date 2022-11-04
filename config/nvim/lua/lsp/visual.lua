return {
  setup = function()
    -- Diagnostic icons
    -- local signs = { Error = ' ', Warn = ' ', Hint = '硫', Info = ' ' }

    -- for type, icon in pairs(signs) do
    --   local hl = 'DiagnosticSign' .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    -- end

    -- Border
    _G.border = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }

    -- Docs Window
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

    -- set border in lspconfig
    require('lspconfig.ui.windows').default_options.border = 'rounded'
  end,
}
