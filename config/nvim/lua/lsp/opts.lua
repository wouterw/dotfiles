return {
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Show diagnostics in a floating window.
    vim.keymap.set('n', '<space>e', function()
      vim.diagnostic.open_float({ border = 'rounded' })
    end, opts)

    -- Move to the previous diagnostic in the current buffer.
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

    -- Move to the next diagnostic in the current buffer.
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Add buffer diagnostics to the location list.
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Jumps to the declaration of the symbol under the cursor.
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    -- Jumps to the definition of the symbol under the cursor.
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- Lists all the implementations for the symbol under the cursor in the quickfix window.
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    -- Lists all the references to the symbol under the cursor in the quickfix window.
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    -- Displays hover information about the symbol under the cursor in a floating window.
    -- Calling the function twice will jump into the floating window.
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- Displays signature information about the symbol under the cursor in a floating window.
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Add the folder at path to the workspace folders.
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)

    -- Remove the folder at path from the workspace folders.
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)

    --  List workspace folders.
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Jumps to the definition of the type of the symbol under the cursor.
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

    -- Renames all references to the symbol under the cursor.
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)

    -- Selects a code action available at the current cursor position.
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  end,

  -- Add additional capabilities supported by nvim-cmp
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
