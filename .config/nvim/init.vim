set nocompatible   " Must be the first line.
let mapleader=','  " The leader is a comma instead of a backslash.


" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'sheerun/vim-polyglot'
  Plug 'morhetz/gruvbox'
  Plug 'vimwiki/vimwiki'
  Plug 'junegunn/goyo.vim'
call plug#end()


" PLUGIN CONFIGURATION
" vimwiki config.
let g:vimwiki_list=[{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel=0
let g:vimwiki_markdown_link_ext=1

" Toggle goyo.
map <leader>g :Goyo<CR>

" Workaround to make :q quit goyo and vim.
function! s:goyo_enter()
  let b:quitting=0
  let b:quitting_bang=0
  autocmd QuitPre <buffer> let b:quitting=1
  cabbrev <buffer> q! let b:quitting_bang=1 <bar> q!
endfunction

function! s:goyo_leave()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

augroup goyoquit
  autocmd!
  autocmd User GoyoEnter call <SID>goyo_enter()
  autocmd User GoyoLeave call <SID>goyo_leave()
augroup end


" COLORS
set termguicolors
set background=dark
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='medium'
colorscheme gruvbox

function! Day()
  set background=light
endfunction

function! Night()
  set background=dark
endfunction

command! Day call Day()
command! Night call Night()


" FILETYPE-SPECIFIC
filetype on         " Syntax highlighting.
filetype indent on  " Load filetype-specific indent files.
filetype plugin on  " Load filetype-specific plugin files.


" MAIN
syntax enable                   " Enable syntax processing.
set mouse=a                     " Enable mouse input.
set selection=old               " Old-style visual selection.
set encoding=utf-8              " Set file encoding.
set backspace=indent,eol,start  " Backspace over these.
set autoread                    " Automatically reload changed files from disk.
set path+=**                    " Recursive globbing.


" INDENTATION
set tabstop=4      " Number of visual spaces per TAB.
set softtabstop=4  " Number of visual spaces in tab when editing.
set shiftwidth=4   " Auto-indent this many spaces.
set softtabstop=4  " Number of spaces when performing editing operations.
set linebreak      " Do not break words when wrapping lines.
set expandtab      " Tabs are spaces.
set smarttab       " Smart behavior when inserting tab in front of a line.
set autoindent     " Indent at the previous line level.
set nojoinspaces   " Do not insert an extra space when joining (J) sentences.


" BACKUPS
set nobackup
set nowritebackup
set noswapfile


" UI CONFIG
set number                      " Show line numbers.
set noshowmode                  " The status bar displays the current mode.
set showcmd                     " Show the last command in the bottom bar.
set wildmenu                    " Visual autocomplete for the command menu.
set wildmode=full               " Shell-like filename autocompletion.

set showmatch                   " Highlight matching parentheses.
set matchpairs=(:),[:],{:},<:>  " These parentheses are shown as matching.

set splitbelow  " Open new pane to the bottom.
set splitright  " Open new pane to the right.

set scrolloff=3     " Minimum lines to keep above/below cursor when scrolling.
set cursorline      " Highlight the current line.
set colorcolumn=81  " Show a column at 81 characters.


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

set laststatus=2                          " Status line height.
set statusline=                           " Clear the status line.
set statusline+=\ %{currentmode[mode()]}  " Show the current mode.
set statusline+=\ %F                      " Current file path.
set statusline+=%{&modified?'\ [+]':''}   " The file has been modified.
set statusline+=%{&readonly?'\ [x]':''}   " The file is read-only.
set statusline+=%<                        " Truncate line here.
set statusline+=%=                        " Left/right-aligned items separator.
set statusline+=%{&filetype!=#''?&filetype.'\ ':'none\ '}  " File type.
set statusline+=%-7([%{&fileformat}]%)    " File format.
set statusline+=[%l/%L]                   " Cursor line location.
set statusline+=\ col:%c                  " Column number.


" SHUT UP
set noerrorbells
set novisualbell
set belloff=all


" MISCELLANEOUS
set nohidden      " Once a tab is closed, remove the buffer.
set lazyredraw    " Redraw only when needed.
set shortmess+=I  " Do not display the startup message.


" KEYMAPS
" Note that the `"` comment cannot be used on the line defining the key mapping.

" Make j/down and k/up go by rows instead of lines in normal/visual selection.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" Make down and up go by rows instead of by lines in the insert mode.
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Go to the beginning/end of a row instead of a line in normal/visual selection.
nnoremap ^ g^
nnoremap $ g$
vnoremap ^ g^
vnoremap $ g$

" Decrease indentation level in insert mode.
inoremap <S-Tab> <ESC><<i

" Yank from the cursor to the end of the line, consistent with C and D.
nnoremap Y y$

" Use ctrl+direction to change split panes.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Next tab.
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous tab.
nnoremap <silent> <C-Left> :tabprevious<CR>

" Press Enter to insert a blank line below.
map <Enter> o<ESC>

" Fix caps lock annoyances.
if has('user_commands')
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


" MakeTags command to generate ctags.
" ctrl+]   ... jump to tag under the cursor.
" g+ctrl+] ... ambiguous tags
" ctrl+t   ... jump back up the tag stack.
command! MakeTags !ctags -R .


" Copy-paste
" <leader>y yanks to system clipboard.
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" <leader>p pastes from system clipboard.
nnoremap <leader>p "+p
vnoremap <leader>p "+p


" SEARCHING
set incsearch   " Search as characters are entered.
set hlsearch    " Highlight matches.
set ignorecase  " Case insensitive search.
set smartcase   " But case sensitive when uppercase is present.
set showmatch   " Live match highlighting.

" Press <leader><space> to turn off search highlight.
nnoremap <leader><space> :nohlsearch<CR>

" Show substitution results in real time.
if exists('&inccommand')
  set inccommand=nosplit
endif


" FILETYPE-SPECIFIC AUTOCOMMANDS
function! SetIndentation(n)
  let &l:tabstop=a:n
  let &l:softtabstop=a:n
  let &l:shiftwidth=a:n
endfunction

augroup cython
  autocmd!
  autocmd BufRead,BufNewFile *.pyx set filetype=cython
  autocmd BufRead,BufNewFile *.pxd set filetype=cython
augroup end

augroup indentation
  autocmd!
  autocmd FileType haskell call SetIndentation(2)
  autocmd FileType lua call SetIndentation(2)
  autocmd FileType vim call SetIndentation(2)
  autocmd FileType sh,bash call SetIndentation(2)
augroup end

augroup column
  autocmd!
  autocmd FileType python,cython setlocal colorcolumn=89
augroup end

augroup plaintext
  autocmd!
  autocmd FileType mail,markdown,text
    \ call SetIndentation(2) |
    \ setlocal textwidth=80
augroup end
