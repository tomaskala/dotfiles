set nocompatible  " must be the first line



" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'scrooloose/nerdcommenter'  " <leader>c<space> to toggle line comment
    Plug 'bluz71/vim-moonfly-colors'
call plug#end()


" COLORS
set termguicolors  " use true colors
set background=dark
colorscheme moonfly


" FILETYPE-SPECIFIC
filetype on  " syntax highlighting
filetype indent on  " load filetype-specific indent files
filetype plugin on  " load filetype-specific plugin files


" MAIN
syntax enable  " enable syntax processing
set mouse=a  " enable mouse input
set autochdir  " always switch to the current file directory
set selection=old  " old-style visual selection
set encoding=utf-8
set backspace=indent,eol,start
set autoread  " automatically reload changed files from disk


" INDENTATION
set tabstop=4  " number of visual spaces per TAB
set softtabstop=4  " number of visual spaces in tab when editing
set shiftwidth=4
set softtabstop=4  " number of spaces when performing editing operations
set linebreak  " do not break words when wrapping lines
set expandtab  " tabs are spaces
set smarttab  " smart behavior when inserting tab in front of a line
set autoindent  " indent at the previous line level
set nojoinspaces  " do not insert an extra space when joining (J) sentences


" BACKUPS
set nobackup
set nowritebackup
set noswapfile


" UI CONFIG
set number  " show line numbers
set showcmd  " show the last command in the bottom bar
set cursorline  " highlight the current line
set wildmenu  " visual autocomplete for the command menu
set wildmode=list:longest,full  " shell-like filename autocompletion
set lazyredraw  " redraw only when needed
set showmatch  " highlight matching parentheses
set matchpairs=(:),[:],{:},<:>  " these parentheses are shown as matching
set shortmess+=I  " do not display the startup message
set showmode  " display the current mode
set splitbelow  " open new pane to the bottom
set splitright  " open new pane to the right
set colorcolumn=81  " show a column at 81 characters


" SHUT UP
set noerrorbells
set novisualbell
set visualbell t_vb=
if exists('&belloff')
    set belloff=all
endif


" MISCELLANEOUS
set nohidden  " once a tab is closed, remove the buffer


" LEADER SHORTCUTS
let mapleader=","  " the leader is a comma instead of a backslash

" <leader>y yanks to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" <leader>p pastes from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p


" SEARCHING
set incsearch  " search as characters are entered
set hlsearch  " highlight matches
set ignorecase  " case insensitive search
set smartcase  " but case sensitive when uppercase is present
set showmatch  " live match highlighting

" press <leader><space> to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


" KEYMAPS
" note that the `"` comment cannot be used on the line defining the key mapping

" make j/down and k/up go by rows instead of lines in normal/visual selection
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" make down and up go by rows instead of by lines in the insert mode
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" go to the beginning/end of a row instead of a line in normal/visual selection
nnoremap ^ g^
nnoremap $ g$
vnoremap ^ g^
vnoremap $ g$

" yank from the cursor to the end of the line, consistent with C and D
nnoremap Y y$

" press F12 to toggle preserving the pasted code indentation
set pastetoggle=<F12>

" use ctrl+direction to change split panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" new tab
nnoremap <silent> <C-t> :tabnew<CR>
" next tab
nnoremap <silent> <C-Right> :tabnext<CR>
" previous tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" Press Enter to insert a blank line below.
map <Enter> o<ESC>

" Fix caps lock annoyances.
if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif


" FILETYPE-SPECIFIC AUTOCOMMANDS
augroup FileTypeSpecificAutocommands
    autocmd BufRead,BufNewFile *.pyx set filetype=cython
    autocmd BufRead,BufNewFile *.pxd set filetype=cython
    autocmd FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType python,cython setlocal colorcolumn=89
    autocmd FileType sh,bash setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType mail,markdown,text setlocal textwidth=80
augroup end
