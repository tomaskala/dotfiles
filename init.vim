set nocompatible  " must be the first line


" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'scrooloose/nerdtree'
call plug#end()


" COLORS
set termguicolors  " use true colors
set background=dark
"colorscheme nord
let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty
let &t_ut=''  " do not use background color erase (conflicts with kitty)


" FILETYPE-SPECIFIC
filetype on  " syntax highlighting
filetype indent on  " load filetype-specific indent files
filetype plugin on  " load filetype-specific plugin files


" MAIN
syntax enable  " enable syntax processing
set mouse=a  " enable mouse input
set autochdir  " always switch to the current file directory


" INDENTATION
set tabstop=4  " number of visual spaces per TAB
set softtabstop=4  " number of visual spaces in tab when editing
set shiftwidth=4
set softtabstop=4  " number of spaces when performing editing operations (e.g. tab at the beginning)
set linebreak  " do not break words when wrapping lines
set expandtab  " tabs are spaces
set smarttab  " smart behavior when inserting tab in front of a line
set autoindent  " indent at the previous line level


" UI CONFIG
set number  " show line numbers
set showcmd  " show the last command in the bottom bar
set cursorline  " highlight the current line
set wildmenu  " visual autocomplete for the command menu
set wildmode=longest,list  " shell-like filename autocompletion
set lazyredraw  " redraw only when needed
set showmatch  " highlight matching parentheses
set shortmess+=I  " do not display the startup message
set showmode  " display the current mode
set splitbelow  " open new pane to the bottom
set splitright  " open new pane to the right


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

" press <leader><space> to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


" KEYMAPS
" note that the `"` comment cannot be used on the line defining the key mapping

" make j/down and k/up go by rows instead of by lines in normal/visual selection modes
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

" go to the beginning/end of a row instead of a line in normal/visual selection modes
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

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>


" MISCELLANEOUS
set nohidden  " once a tab is closed, remove the buffer
set noerrorbells  " shut up
set visualbell  " shut up and blink instead
set t_vb=  " shut up


" FILETYPE-SPECIFIC AUTOCOMMANDS
augroup FileTypeSpecificAutocommands
    autocmd FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2 softtabstop=2
augroup end
