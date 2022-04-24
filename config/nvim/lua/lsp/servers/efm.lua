local efm = {}

efm.setup = function(opts)
  local eslint = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %m' },
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true,
  }

  opts.settings = {
    languages = {
      javascript = { eslint },
      javascriptreact = { eslint },
      typescript = { eslint },
      typescriptreact = { eslint },
    },
  }

  opts.filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  }
end

return efm
