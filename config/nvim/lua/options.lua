-- Leader key
vim.g.mapleader = ' '

-- Hide statusline
vim.opt.laststatus = 0

-- Quicker update
vim.opt.updatetime = 300

-- Highlight Yank
local group = vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
  end,
  group = group,
})

-- Syntax highlighting
vim.opt.termguicolors = true
vim.g.t_Co = 256
vim.g.syntax_on = true

vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.pumheight = 10 -- Makes popup menu smaller

vim.opt.fileencoding = 'utf-8' -- The encoding written to file
vim.opt.cmdheight = 1 -- Less space for displaying messages

vim.opt.conceallevel = 0 -- So that I can see `` in markdown files

-- 2 character wide tab for indentation
vim.opt.autoindent = true
vim.g.smartintend = true
-- control the number of space characters that will be inserted when the tab key is pressed
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- insert space characters whenever the tab key is pressed
vim.o.expandtab = true

-- Don't wrap lines
vim.opt.wrap = false

-- Search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

-- Line default relative number
vim.opt.number = true
vim.opt.relativenumber = true

vim.wo.cursorline = true -- Enable highlighting of the current line
vim.wo.signcolumn = 'yes:1' -- Always show the signcolumn, otherwise it would shift the text each time

vim.wo.scrolloff = 10
vim.wo.sidescrolloff = 30

vim.o.backup = false -- This is recommended by coc
vim.o.swapfile = false
vim.o.writebackup = false -- This is recommended by coc

-- Whitespace characters
vim.wo.list = true
vim.opt.listchars = 'tab:→ ,trail:•,nbsp:·,extends:»,precedes:«'

-- Copy and paste with OS clipboard
vim.opt.clipboard = 'unnamedplus'

-- Error format
vim.bo.errorformat = [[
    %E%f:%l:%c: %trror: %m,%-Z%p^,%+C%.%#
    %D%*a: Entering directory [`']%f
    %X%*a: Leaving directory [`']%f
    %-G%.%#
]]

-- 'foldtext' can be disabled so the text is rendered/highlighted normally.
vim.o.foldtext = ''
vim.o.fillchars = 'fold: '

-- Open new split panes to right and bottom, which feels more natural
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Automatically :write before running commands
vim.opt.autowrite = true

-- Automatically update file unless buffer has unsaved changes
vim.opt.autoread = true

-- Allow undo history to persist after closing buffer
vim.opt.undofile = true

-- Trim spaces at EOL and retab
vim.cmd([[ command! TEOL %s/\s\+$// ]])
vim.cmd([[ command! CLEAN retab | TEOL ]])

-- Embrace typos
vim.cmd([[ command! Q q ]])
vim.cmd([[ command! W w ]])
vim.cmd([[ command! Wq wq ]])
