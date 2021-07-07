set encoding=utf-8

" Enable true colors
set termguicolors

" Background color
set background=dark

" Color scheme
" colorscheme base16-tomorrow-night
colorscheme ghdark

" Relative line numbers
set relativenumber

" Highlight all matches after entering search pattern
set hlsearch

" Automatically update file unless buffer has unsaved changes
set autoread

" Case insensitive pattern matching
set ignorecase

" Overrides ignorecase if pattern contains upcase
set smartcase

" When at 3 spaces and I hit >>, go to 4, not 5
set shiftround

" Keep 5 lines of context when scrolling
set scrolloff=5

" Live preview substitute (neovim)
set inccommand=split

set wildoptions=pum
set pumblend=20
set winblend=20

" Hide -- INSERT -- mode as the mode information is displayed in the statusline
set noshowmode

" Don't add the comment prefix when I hit enter or o/O on a comment line.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Move one displayed line at a time, default is one fysical line
nmap k gk
nmap j gj

" Bind K to grep word under cursor
nnoremap K :Ag <C-R><C-W><CR>

" Complete terms from all buffers
set complete=.,w,b,u,t,i

" Disable Ex mode
map Q <Nop>

" Allow undo history to persist after closing buffer
if has("persistent_undo")
  set undodir=~/.vim/_undo
  set undofile
end

" Shortcuts
map <C-n> :NERDTreeToggle<CR>
map <C-t> <esc>:tabnew<CR>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
nmap <Leader>d :Dispatch

" You don't know what you're missing if you don't use this.
nmap <C-e> :e#<CR>

" Move between open buffers.
" nmap <C-n> :bnext<CR>
" nmap <C-p> :bprev<CR>

" Embrace typos
command! Q q
command! W w
command! Wq wq

" Trim spaces at EOL and retab.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" CocoaPods
au BufRead,BufNewFile Podfile,*.podspec set filetype=ruby

" Make `prettier` power the gq command for automatic formatting
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --single-quote

" neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1

" open nerdtree at location of current open file
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-markdown
let g:markdown_fenced_languages = ['ruby', 'bash=sh']

" airline
let g:airline_theme = 'ghdark'

" ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '◦'
let g:ale_sign_warning = '◦'
let g:ale_fix_on_save = 1

let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'elixir': ['mix_format']
\ }

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" fzf
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :GFiles<CR>
nmap <Leader>a :Rg<CR>

" fzf: disable preview window
let g:fzf_preview_window = ''

" fzf: Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" fzf: Open in popup
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" fzf: Customize colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Augmenting Rg command using `fzf#vim#with_preview` function
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --smart-case '.shellescape(<q-args>), 1, <bang>0)

" Tree-sitter based syntax highlighting and identation
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
    is_supported = function(lang)
      return lang == 'lua'
    end
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  fold = {
    enable = true,
  },
}
EOF

lua <<EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

lua <<EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF

lua <<EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}
EOF

lua <<EOF
require('nvim-autopairs').setup()
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})
EOF

let g:lightline = { 'colorscheme': 'ghdark' }
