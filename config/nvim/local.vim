set encoding=utf-8

" Enable true colors
set termguicolors

" Background color
set background=dark

" Color scheme
" colorscheme one
colorscheme jellybeans

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

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdtree-sync
let g:nerdtree_sync_cursorline = 1

" vim-javascript
let g:javascript_plugin_flow = 1

" airline
let g:airline_theme = 'one'
let g:airline_extensions = []
let g:airline#extensions#ale#enabled = 1

" ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '»'
let g:ale_sign_warning = '»'
let g:ale_fix_on_save = 1

let g:ale_linters = { 'javascript': ['eslint', 'flow'] }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fixers = { 'javascript': ['prettier'] }

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" gitgutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" fzf
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg<CR>

" Hide fzf statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Customize fzf colors to match color scheme
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
