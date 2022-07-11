set nocp
filetype plugin indent on
syntax on

set mouse=a ttm=0 pa=** ff=unix enc=utf-8 nf=bin,hex ar hid lz shm+=I
set ts=2 sts=2 sw=2 lbr et nosol bs=indent,eol,start sta nojs fo+=j ai
set nobk noswf
set nu rnu ru sc wmnu wim=longest:full,full ls=2 sb spr cpt-=i
set so=3 cul cc=80 hi=1000
set noeb novb
set is hls ic scs
set lcs=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set cino=t0,l1,:0 cink-=0#
colo slate

let g:mapleader=','
let g:netrw_banner=0
let g:netrw_winsize=25
let &t_SI="\e[6 q"
let &t_SR="\e[4 q"
let &t_EI="\e[2 q"

map <leader>t :silent !ctags -R<CR><C-L>
map <leader><space> :noh<CR>

aug go
  au!
  au FileType go setl mp=go\ build fp=gofmt\ -s noet tw=72
aug end

aug indentmore
  au!
  au FileType python setl ts=4 sts=4 sw=4
aug end

aug plaintext
  au!
  au FileType mail,markdown,text setl tw=79 fo+=w
aug end
