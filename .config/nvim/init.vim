let g:mapleader = ','
set mouse=a
set path=**
set fileformat=unix
set hidden
set lazyredraw
set shortmess+=I

set tabstop=4
set softtabstop=4
set shiftwidth=4
set linebreak
set expandtab
set nostartofline

set nobackup
set noswapfile

set number
set relativenumber
set wildmode=longest:full,full
set splitbelow
set splitright

set scrolloff=3
set cursorline
set colorcolumn=80

let g:netrw_banner=0
let g:netrw_winsize=25

set noerrorbells
set novisualbell

set ignorecase
set smartcase

set cinoptions+=t0,l1,:0
set cinkeys-=0#

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'cocopon/iceberg.vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua <<EOF
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  ensure_installed = "all",
})
EOF

set termguicolors
colorscheme iceberg

" MakeTags command to generate ctags.
" ctrl+]   ... jump to tag under the cursor.
" g+ctrl+] ... ambiguous tags
" ctrl+t   ... jump back up the tag stack.
command! MakeTags !ctags -R .

" Fix caps lock annoyances.
command! -bang -nargs=? -complete=file E e<bang> <args>
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" Use ctrl+direction to change split panes.
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" <leader>y yanks to system clipboard.
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" <leader>p pastes from system clipboard.
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" <leader><space> turns off search highlight.
nnoremap <leader><space> :nohlsearch<CR>

augroup go
  autocmd!
  autocmd FileType go setlocal makeprg=go\ build formatprg=gofmt\ -s noexpandtab shiftwidth=4 tabstop=4 textwidth=72
augroup end

augroup indentation
  autocmd!
  autocmd FileType bash,c,cpp,haskell,json,lua,mail,markdown,sh,text,vim,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup end

augroup plaintext
  autocmd!
  autocmd FileType mail,markdown,text setlocal textwidth=79 formatoptions+=w
augroup end
