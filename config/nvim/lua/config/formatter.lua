-- https://github.com/mhartington/formatter.nvim

function prettier ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
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
    typescript = { prettier },
    typescriptreact = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
		css = { prettier },
		json = { prettier },
		yaml = { prettier },
		markdown = { prettier },
		html = { prettier },
    rust = { rustfmt },
    lua = { luafmt },
  }
})

local au = require("au")

local files = {
  "*.js",
  "*.jsx",
  "*.mjs",
  "*.ts",
  "*.tsx",
  "*.css",
  "*.less",
  "*.scss",
  "*.json",
  "*.md",
  "*markdown",
  "*.yml",
  "*.yaml",
  "*.html",
}

local ftypes = table.concat(files, ",")

au.group("FormatAutogroup", {{"BufWritePost", ftypes, "FormatWrite"}})
