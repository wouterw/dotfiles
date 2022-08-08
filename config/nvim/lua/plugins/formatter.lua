-- https://github.com/mhartington/formatter.nvim

require('formatter').setup({
  logging = false,
  filetype = {
    css = { require('formatter.filetypes.css').prettier },
    elixir = { require('formatter.filetypes.elixir').mixformat },
    html = { require('formatter.filetypes.html').prettier },
    javascript = { require('formatter.filetypes.javascript').prettier },
    javascriptreact = { require('formatter.filetypes.javascriptreact').prettier },
    json = { require('formatter.filetypes.json').prettier },
    lua = { require('formatter.filetypes.lua').stylua },
    markdown = { require('formatter.filetypes.markdown').prettier },
    python = { require('formatter.filetypes.python').isort, require('formatter.filetypes.python').black },
    rust = { require('formatter.filetypes.rust').rustfmt },
    typescript = { require('formatter.filetypes.typescript').prettier },
    typescriptreact = { require('formatter.filetypes.typescriptreact').prettier },
    yaml = { require('formatter.filetypes.yaml').prettier },
    ['*'] = { require('formatter.filetypes.any').remove_trailing_whitespace },
  },
})

local files = {
  '*.css',
  '*.ex',
  '*.exs',
  '*.html',
  '*.js',
  '*.json',
  '*.jsx',
  '*.lua',
  '*.markdown',
  '*.md',
  '*.mjs',
  '*.py',
  '*.rs',
  '*.scss',
  '*.ts',
  '*.tsx',
  '*.yaml',
  '*.yml',
}

local pattern = table.concat(files, ',')
local group = vim.api.nvim_create_augroup('Formatter', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = pattern,
  command = 'FormatWrite',
  group = group,
})
