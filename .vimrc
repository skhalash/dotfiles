set nocompatible

syntax enable

set showcmd
set showmode

set number
set ruler

set incsearch
set hlsearch

set tabstop=2
set shiftwidth=2
set expandtab

execute pathogen#infect()
call pathogen#helptags()

map <C-n> :NERDTreeToggle<CR>
