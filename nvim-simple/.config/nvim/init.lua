vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.autoread = true
vim.opt.list = true -- show trailing characters
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"
vim.opt.shell = "/bin/bash"
-- vim.opt.colorcolumn = "100"
vim.opt.complete = ".,o"                                          -- use buffer and omnifunc
vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" } -- add 'popup' for docs (sometimes)
vim.opt.autocomplete = true
vim.opt.pumheight = 7
vim.opt.laststatus = 0
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 1

-- Line default relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config({
  severity_sort = true,
})

local opts = { silent = true }
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)  -- exit terminal mode
vim.keymap.set("n", "Q", "<nop>", opts)             -- disable "Q"
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts) -- navigate splits
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)
vim.keymap.set("n", "<leader>t", ":bd!<CR>", opts)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>y", function() -- copy relative filepath to clipboard
  vim.fn.setreg("+", vim.fn.expand("%"))
end)

local augroup = vim.api.nvim_create_augroup("cfg", { clear = true })
vim.api.nvim_create_autocmd("Filetype", { group = augroup, pattern = { "qf" }, command = "setlocal wrap" })
vim.api.nvim_create_autocmd("Filetype",
  { group = augroup, pattern = { "make" }, command = "setlocal noexpandtab tabstop=4 shiftwidth=4" })

local function setup_lsp()
  vim.lsp.enable({
    -- "html",
    -- "jsonls",
    "lua_ls",   -- pacman -S lua-language-server
    "ruby_lsp", -- gem install ruby-lsp
    "herb_ls",  -- npm install -g @herb-tools/language-server
    "expert",
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
      local bufopts = { noremap = true, silent = true, buffer = ev.buf }
      vim.keymap.set("i", "<C-k>", vim.lsp.completion.get, bufopts) -- open completion menu manually
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, bufopts)

      local methods = vim.lsp.protocol.Methods
      -- https://github.com/neovim/neovim/blob/b2828af5b5aba044cd40594a519d2d9f5dbb69cb/runtime/lua/vim/lsp/protocol.lua?plain=1#L858
      if client:supports_method(methods.textDocument_completion) then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
        -- Optional formating of items
        convert = function(item)
          -- Remove leading misc chars for abbr name,
          -- and cap field to 25 chars
          --local abbr = item.label
          --abbr = abbr:match("[%w_.]+.*") or abbr
          --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
          --
          -- Remove return value
          --local menu = ""

          -- Only show abbr name, remove leading misc chars (bullets etc.),
          -- and cap field to 15 chars
          local abbr = item.label
          abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
          abbr = abbr:match("[%w_.]+.*") or abbr
          abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

          -- Cap return value field to 15 chars
          local menu = item.detail or ""
          menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

          return { abbr = abbr, menu = menu }
        end,
      })
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format { async = false, id = args.data.client_id }
        end,
      })
    end
  })
end

local function setup_fzf()
  local fzf = require("fzf-lua")
  local noprev = { winopts = { fullscreen = true, preview = { hidden = "hidden" } } }
  local fzf_files = function()
    fzf.files(noprev)
  end
  local fzf_symbols = function()
    fzf.lsp_document_symbols(noprev)
  end
  local fzf_buffers = function()
    fzf.buffers(noprev)
  end
  vim.keymap.set("n", "<leader>s", fzf_files, { desc = "fzf files", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>F", fzf_symbols, { desc = "fzf symbols", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>f", fzf_buffers, { desc = "fzf buffers", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>S", fzf.live_grep, { desc = "fzf grep", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>j", fzf.jumps, { desc = "fzf jumplist", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>m", fzf.marks, { desc = "fzf marks", noremap = true, silent = true })
  fzf.setup({ "max-perf" })
end

local function setup_treesitter()
  local ts_parsers = {
    "bash",
    "c",
    "dockerfile",
    "elixir",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "ruby",
    "rust",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "yaml",
    "zig",
    "erb",
  }
  local nts = require("nvim-treesitter")
  nts.install(ts_parsers)

  vim.api.nvim_create_autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
    group = augroup,
    callback = function(ev)
      local spec = ev.data.spec
      if spec and spec.name == "nvim-treesitter" and ev.data.kind == "update" then
        vim.schedule(function()
          nts.update()
        end)
      end
    end,
  })

  vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
    group = augroup,
    callback = function(ev)
      local filetype = ev.match
      local lang = vim.treesitter.language.get_lang(filetype)
      if vim.treesitter.language.add(lang) then
        if vim.treesitter.query.get(filetype, "indents") then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        if vim.treesitter.query.get(filetype, "folds") then
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
        vim.treesitter.start()
      end
    end,
  })
end

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/karb94/neoscroll.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/rose-pine/neovim",
})

setup_treesitter()
setup_lsp()
setup_fzf()

require("neoscroll").setup({
  duration_multiplier = 0.4
})

require("treesitter-context").setup({
  max_lines = 3,
  multiline_threshold = 1,
  separator = "-",
  min_window_height = 20,
  line_numbers = true,
})

require("vim._extui").enable {}

require("rose-pine").setup({ variant = "main", dark_variant = "main" })
vim.cmd("colorscheme rose-pine")
