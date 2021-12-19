local lsp_installer = require("nvim-lsp-installer")
local opts = require("lsp.opts")

local servers = {
  "cssls",
  "efm",
  "elixirls",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "solargraph",
  "tsserver",
}

USER = vim.fn.expand("$USER")

-- Automatic Installation
for _, name in pairs(servers) do
  local ok, server = lsp_installer.get_server(name)
  -- Check that the server is supported in nvim-lsp-installer
  if ok then
    if not server:is_installed() then
      print("[nvim-lsp-installer]: Installing " .. name .. " ...")
      server:install()
    end
  end
end

-- Configuration
lsp_installer.on_server_ready(function(server)
  local default_opts = opts

  server:setup(opts)

  vim.cmd([[ do User LspAttachBuffers ]])
end)

-- Diagnostic icons
local signs = {Error = " ", Warn = " ", Hint = "硫", Info = " "}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

-- local eslint = {
--   lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--   formatStdin = true
-- }

-- nvim_lsp.tsserver.setup {
--   on_attach = function(client)
--     if client.config.flags then
--       client.config.flags.allow_incremental_sync = true
--     end
--     client.resolved_capabilities.document_formatting = false
--     set_lsp_config(client)
--   end
-- }

-- nvim_lsp.efm.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = true
--     client.resolved_capabilities.goto_definition = false
--     set_lsp_config(client)
--   end,
--   root_dir = function()
--     if not eslint_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     languages = {
--       javascript = {eslint},
--       javascriptreact = {eslint},
--       ["javascript.jsx"] = {eslint},
--       typescript = {eslint},
--       ["typescript.tsx"] = {eslint},
--       typescriptreact = {eslint}
--     }
--   },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact"
--   },
-- }
