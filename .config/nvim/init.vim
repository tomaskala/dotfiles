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
set laststatus=2  " status line height
set showcmd  " show the last command in the bottom bar
set cursorline  " highlight the current line
set wildmenu  " visual autocomplete for the command menu
set wildmode=list:longest,full  " shell-like filename autocompletion
set lazyredraw  " redraw only when needed
set showmatch  " highlight matching parentheses
set matchpairs=(:),[:],{:},<:>  " these parentheses are shown as matching
set shortmess+=I  " do not display the startup message
set noshowmode  " do not display the current mode, the status bar does that
set splitbelow  " open new pane to the bottom
set splitright  " open new pane to the right
set colorcolumn=81  " show a column at 81 characters
set scrolloff=3  " minimum lines to keep above/below cursor when scrolling


" STATUSLINE
let currentmode={
  \ 'n': 'NORMAL ',
  \ 'v': 'VISUAL ',
  \ 'V': 'V-LINE ',
  \ "\<C-V>": 'V-BLOCK ',
  \ 'i': 'INSERT ',
  \ 'R': 'REPLACE ',
  \ 'Rv': 'V-REPLACE ',
  \ 'c': 'COMMAND ',
\}

set statusline=

" show the current mode
set statusline+=\ %{currentmode[mode()]}

" file path, as typed or relative to current directory
set statusline+=\ %F

" modified and/or read-only file
set statusline+=%{&modified?'\ [+]':''}
set statusline+=%{&readonly?'\ [x]':''}

" truncate line here
set statusline+=%<

" separation point between left and right aligned items
set statusline+=%=

set statusline+=%{&filetype!=#''?&filetype.'\ ':'none\ '}

" fileformat
set statusline+=%-7([%{&fileformat}]%)

" location of cursor line
set statusline+=[%l/%L]

" column number
set statusline+=\ col:%c


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

" show substitution results in real time
if exists('&inccommand')
  set inccommand=nosplit
endif


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

" decrease indentation level in insert mode
inoremap <S-Tab> <ESC><<i

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

" press Enter to insert a blank line below
map <Enter> o<ESC>

" fix caps lock annoyances
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
function SetIndentation(n)
    let &l:tabstop=a:n
    let &l:softtabstop=a:n
    let &l:shiftwidth=a:n
endfunction

augroup FileTypeSpecificAutocommands
  autocmd BufRead,BufNewFile *.pyx set filetype=cython
  autocmd BufRead,BufNewFile *.pxd set filetype=cython

  autocmd FileType lua call SetIndentation(2)
  autocmd FileType sh,bash call SetIndentation(2)
  autocmd FileType mail,markdown,text
    \ call SetIndentation(2) |
    \ setlocal textwidth=80
  autocmd FileType python,cython setlocal colorcolumn=89
augroup end
