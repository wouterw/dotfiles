-- https://github.com/mhartington/formatter.nvim

function prettier ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

local isort = function()
  return { exe = 'isort', args = { '-' }, stdin = true }
end

local black = function()
  return { exe = 'black', args = { '-' }, stdin = true }
end

function elixirfmt ()
  return {
    exe = "mix format",
    args = {},
    stdin = true
  }
end

function rustfmt ()
  return {
    exe = "rustfmt",
    args = {"--emit=stdout"},
    stdin = true
  }
end

function luafmt ()
  return {
    exe = "luafmt",
    args = {"--indent-count", 2, "--stdin"},
    stdin = true
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    css = { prettier },
    elixir = { elixirfmt },
    html = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
    json = { prettier },
    lua = { luafmt },
    markdown = { prettier },
    python = { isort, black },
    rust = { rustfmt },
    typescript = { prettier },
    typescriptreact = { prettier },
    yaml = { prettier },
  }
})

local files = {
  "*.css",
  "*.ex",
  "*.exs",
  "*.html",
  "*.js",
  "*.json",
  "*.jsx",
  "*.lua",
  "*.markdown",
  "*.md",
  "*.mjs",
  "*.py",
  "*.rs",
  "*.scss",
  "*.ts",
  "*.tsx",
  "*.yaml",
  "*.yml",
}

local pattern = table.concat(files, ',')
local group = vim.api.nvim_create_augroup('Formatter', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = pattern,
  command = 'FormatWrite',
  group = group,
})
