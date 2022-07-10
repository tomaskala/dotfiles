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

map <leader>t :silent !ctags -R<CR>
map <leader><space> :noh<CR>

aug go
  au!
  au FileType go setl mp=go\ build fp=gofmt\ -s noet tw=72
aug end

aug indentation
  au!
  au FileType bash,c,cpp,haskell,json,lua,mail,markdown,sh,text,vim,yaml setl ts=2 sts=2 sw=2
aug end

aug plaintext
  au!
  au FileType mail,markdown,text setl tw=79 fo+=w
aug end
