set nocompatible

syntax on
filetype plugin indent on

set showcmd
set showmode

set number
set ruler

set incsearch
set hlsearch

set tabstop=2
set shiftwidth=2
set expandtab

#vim-go

#autosave before build
set autowrite

#jump between errors in the quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>


map <C-n> :NERDTreeToggle<CR>
