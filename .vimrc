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

" vim-go

" remap leader to make it easily accessible
let mapleader = ","

" all lists will be of type quickfix (no location lists)
let g:go_list_type = "quickfix"

" autosave before build
set autowrite

" jump between errors in the quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" go toolchain shortcuts
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
