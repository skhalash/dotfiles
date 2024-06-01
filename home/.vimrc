vim9script

set nocompatible

colorscheme gruvbox
set bg=dark

syntax on
filetype plugin indent on
runtime macros/matchit.vim

set showcmd
set showmode

set number
set relativenumber
set ruler

set incsearch
set hlsearch
set ignorecase
set smartcase

set tabstop=2
set shiftwidth=2
set expandtab

#Navigating between buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]b :blast<CR>

#Easy expansion of the active file directory (%%)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

#Mute search highlighting
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

#Plugin: NERDTree
#Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

#Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

g:NERDTreeMinimalUI = 1
g:NERDTreeDirArrows = 1
g:NERDTreeShowHidden = 1

#Plugin: fzf
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>

#Plugin: lsp
packadd lsp
call LspAddServer([{name: 'golang', filetype: ['go', 'gomod'], path: 'gopls', args: ['serve'], syncInit: v:true }])
