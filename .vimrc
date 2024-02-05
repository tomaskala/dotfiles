filetype plugin indent on
syntax on

set bg=dark tgc ttm=0 pa=** ff=unix enc=utf-8 nf=bin,hex shm+=I shm-=S
set ts=2 sts=2 sw=2 et ai bs=indent,eol,start nosol nojs fo+=j cpt-=i sb spr
set ar hid nobk noswf noeb novb hi=1000 mouse=a cpo-=a
set cul so=3 cc=80 nu rnu ru sc wmnu wim=longest:full,full ls=2
set is hls ic scs
set cino=t0,l1,:0 cink-=0#

colorscheme sorbet
let g:mapleader=','
let g:netrw_banner=0
let g:netrw_winsize=25
let &t_SI="\e[6 q"
let &t_SR="\e[4 q"
let &t_EI="\e[2 q"

nn <leader>t :sil !ctags -R<CR><C-L>
nn <leader><space> :noh<CR>
nn Y y$
nn [q :cp<CR>
nn ]q :cn<CR>
nn [Q :cfir<CR>
nn ]Q :cla<CR>

aug golang
  au!
  au FileType go setl mp=go\ build noet
  au FileType go nn <silent> <buffer> <leader>f
    \ :up \|
    \ :cex system('goimports -w ' . expand('%')) \|
    \ :sil edit<cr>
aug end

aug indentmore
  au!
  au FileType go,python setl ts=4 sts=4 sw=4
aug end

aug plaintext
  au!
  au FileType markdown,text setl tw=79 fo+=w ts=2 sts=2 sw=2
aug end
