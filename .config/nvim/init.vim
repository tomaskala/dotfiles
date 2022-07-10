let g:mapleader=','
let g:netrw_banner=0
let g:netrw_winsize=25
set mouse=a pa=** ff=unix hid lz shm+=I
set ts=4 sts=4 sw=4 lbr et nosol
set nobk noswf
set nu rnu wim=longest:full,full sb spr
set so=3 cul cc=80
set noeb novb
set ic scs
set cino=t0,l1,:0 cink-=0#

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

set tgc
colo iceberg

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

" Change split panes.
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Yank to system clipboard.
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from system clipboard.
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Turn off search highlight.
nnoremap <leader><space> :noh<CR>

augroup go
  autocmd!
  autocmd FileType go setl mp=go\ build fp=gofmt\ -s noet tw=72
augroup end

augroup indentation
  autocmd!
  autocmd FileType bash,c,cpp,haskell,json,lua,mail,markdown,sh,text,vim,yaml setl ts=2 sts=2 sw=2
augroup end

augroup plaintext
  autocmd!
  autocmd FileType mail,markdown,text setl tw=79 fo+=w
augroup end
