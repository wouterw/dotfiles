-- Leader key
vim.g.mapleader = " "

-- Spell Checker
vim.cmd [[set spell]]

-- quicker update
vim.opt.updatetime = 500

-- Highlight Yank
local au = require("au")
au.TextYankPost = function()
  vim.highlight.on_yank({higroup = "Search", timeout = 120})
end

-- statusline
-- %<                                             trim from here
-- %{fugitive#head()}                             name of the current branch (needs fugitive.vim)
-- %f                                             path+filename
-- %m                                             check modifi{ed,able}
-- %r                                             check readonly
-- %w                                             check preview window
-- %=                                             left/right separator
-- %l/%L,%c                                       rownumber/total,colnumber
-- %{&fileencoding?&fileencoding:&encoding}       file encoding
vim.opt.statusline =
    "  %< %{fugitive#head()}  %f %m %r %w %= Ln %l, Col %c  %{&fileencoding?&fileencoding:&encoding}  "

-- syntax highlighting
vim.opt.termguicolors = true
vim.g.t_Co = 256
vim.g.syntax_on = true

vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.pumheight = 10 -- Makes popup menu smaller

vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.cmdheight = 1 -- Less space for displaying messages

vim.opt.conceallevel = 0 -- So that I can see `` in markdown files

-- 2 character wide tab for indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.g.smartintend = true

-- don't wrap lines
vim.opt.wrap = false

-- search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

-- line default relative number
vim.opt.number = true
vim.opt.relativenumber = true

vim.wo.cursorline = true -- Enable highlighting of the current line
vim.wo.signcolumn = "number" -- Always show the signcolumn, otherwise it would shift the text each time

vim.wo.scrolloff = 10
vim.wo.sidescrolloff = 30

vim.o.backup = false -- This is recommended by coc
vim.o.swapfile = false
vim.o.writebackup = false -- This is recommended by coc

-- whitespace characters
vim.wo.list = true
vim.opt.listchars = "tab:→ ,trail:•,extends:»,precedes:«"
-- set list listchars=tab:»·,trail:·,nbsp:·

-- copy and paste with OS clipboard
vim.opt.clipboard = "unnamedplus"

-- Error format
vim.bo.errorformat = [[
    %E%f:%l:%c: %trror: %m,%-Z%p^,%+C%.%#
    %D%*a: Entering directory [`']%f
    %X%*a: Leaving directory [`']%f
    %-G%.%#
]]

-- Open new split panes to right and bottom, which feels more natural
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Auto write and read files
vim.opt.autowrite = true
vim.opt.autoread = true

-- Set spellfile to location that is guaranteed to exist, can be symlinked to
-- Dropbox or kept in Git and managed outside of dotfiles using rcm.
-- set spellfile=$HOME/.vim-spell-en.utf-8.add

-- Always use vertical diffs
-- set diffopt+=vertical

-- Allow undo history to persist after closing buffer
-- if has("persistent_undo")
--   set undodir=~/.vim/_undo
--   set undofile
-- end

-- Trim spaces at EOL and retab.
-- command! TEOL %s/\s\+$//
-- command! CLEAN retab | TEOL
