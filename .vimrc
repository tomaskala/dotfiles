filetype plugin indent on
syntax on
colorscheme habamax

set mouse=a
set ttimeoutlen=0
set path=**
set fileformat=unix
set encoding=utf-8
set nrformats=bin,hex
set lazyredraw
set shortmess+=I
set history=1000
set splitbelow
set splitright
set complete-=i

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set backspace=indent,eol,start
set nostartofline
set nojoinspaces
set formatoptions+=j

set autoread
set hidden
set nobackup
set noswapfile
set noerrorbells
set novisualbell

set cursorline
set scrolloff=3
set colorcolumn=80
set number
set relativenumber
set ruler
set showcmd
set wildmenu
set wildmode=longest:full,full
set laststatus=1

set incsearch
set hlsearch
set ignorecase
set smartcase

set cinoptions=t0,l1,:0
set cinkeys-=0#

let g:mapleader=','
let g:netrw_banner=0
let g:netrw_winsize=25
let &t_SI="\e[6 q"
let &t_SR="\e[4 q"
let &t_EI="\e[2 q"

nnoremap <leader>t :silent !ctags -R<CR><C-L>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

augroup golang
  autocmd!
  autocmd FileType go setlocal makeprg=go\ build noexpandtab
  autocmd FileType go nnoremap <silent> <buffer> <leader>f
      \ :update \|
      \ :cexpr system("goimports -w " . expand('%')) \|
      \ :silent edit<cr>
augroup end

augroup indentmore
  autocmd!
  autocmd FileType go,python setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup end

augroup plaintext
  autocmd!
  autocmd FileType mail,markdown,text setlocal textwidth=79 formatoptions+=w
augroup end
