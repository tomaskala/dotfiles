let g:mapleader=','  " The leader is a comma instead of a backslash.


" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'vimwiki/vimwiki'
call plug#end()


" PLUGIN CONFIGURATION
" tree-sitter
lua <<EOF
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "go",
    "json",
    "lua",
    "python",
    "regex",
    "vim",
    "yaml",
  },
})
EOF

" vimwiki
let s:wiki='~/notes/'
let g:vimwiki_list=[{'path': s:wiki, 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel=0
let g:vimwiki_markdown_link_ext=1

" Populate vimwiki index by the directory tree.
function! Index()
  let l:wiki_name=split(s:wiki, '/')[-1]
  let l:index_lines=TraverseWiki(s:wiki, l:wiki_name, '#')
  if writefile(l:index_lines, expand(s:wiki . 'index.md'), 's')
    echoerr 'Cannot write the wiki index.'
  endif
endfunction

function! TraverseWiki(root, wiki_name, header_prefix)
  let l:index_lines=[]
  let l:directories=filter(globpath(a:root, '*', 0, 1), 'isdirectory(v:val)')
  let l:files=globpath(a:root, '*.md', 0, 1)

  for l:wiki_file in l:files
    if l:wiki_file !~ '.*index.md'
      let l:wiki_name_end=stridx(l:wiki_file, a:wiki_name) + len(a:wiki_name)
      let l:file_path=l:wiki_file[l:wiki_name_end + 1:]
      let l:file_name=split(l:file_path, '/')[-1]
      call add(l:index_lines, '* [' . l:file_name . '](' . l:file_path . ')')
    endif
  endfor

  if len(l:index_lines) > 0
    call add(l:index_lines, '')
    call add(l:index_lines, '')
  endif

  for l:wiki_dir in l:directories
    let l:wiki_name_end=stridx(l:wiki_dir, a:wiki_name) + len(a:wiki_name)
    let l:wiki_subpage_name=l:wiki_dir[l:wiki_name_end + 1:]
    let l:rec_lines=TraverseWiki(l:wiki_dir, a:wiki_name, a:header_prefix . '#')

    call add(l:index_lines, a:header_prefix . ' ' . l:wiki_subpage_name)
    call add(l:index_lines, '')
    call extend(l:index_lines, l:rec_lines)
  endfor

  return l:index_lines
endfunction

nnoremap <leader>i :call Index()<CR>


" COLORS
set termguicolors
lua <<EOF
require("base16").setup({
    base00 = "#262627",  -- Background
    base01 = "#313132",  -- Color column, current line
    base02 = "#313132",  -- Statusbar
    base03 = "#606366",  -- Comments
    base04 = "#6B737B",  -- Line numbers
    base05 = "#A9B7C6",  -- Normal text
    base06 = "#FFC66D",
    base07 = "#FFFFFF",
    base08 = "#E74946",  -- Errors
    base09 = "#669FEE",  -- Literals, selected tab
    base0A = "#BBB529",  -- Data types, search highlights
    base0B = "#6A8759",  -- Strings
    base0C = "#9876AA",  -- Properties, fields
    base0D = "#FFC66B",  -- Functions, imports, macros, namespaces
    base0E = "#CC7832",  -- Keywords, definitions
    base0F = "#8381B8",  -- Built-ins
})
EOF

" MAIN
filetype on          " Syntax highlighting.
filetype indent on   " Load filetype-specific indent files.
filetype plugin on   " Load filetype-specific plugin files.
syntax enable        " Enable syntax processing.
set mouse=a          " Enable mouse input.
set selection=old    " Old-style visual selection.
set path+=**         " Recursive globbing.
set fileformat=unix  " Always use unix-style line endings.
set nohidden         " Once a tab is closed, remove the buffer.
set lazyredraw       " Redraw only when needed.
set shortmess+=I     " Do not display the startup message.


" INDENTATION
set tabstop=4      " Number of visual spaces per TAB.
set softtabstop=4  " Number of visual spaces in tab when editing.
set shiftwidth=4   " Auto-indent this many spaces.
set softtabstop=4  " Number of spaces when performing editing operations.
set linebreak      " Do not break words when wrapping lines.
set expandtab      " Tabs are spaces.
set nostartofline  " Do not move the cursor to line beginning on gg, G, etc.


" BACKUPS
set nobackup
set nowritebackup
set noswapfile


" UI CONFIG
set number                      " Show absolute line numbers.
set relativenumber              " Show relative line numbers.
set noshowmode                  " The status bar displays the current mode.
set wildmode=longest:full,full  " Shell-like filename autocompletion.

set showmatch                   " Highlight matching parentheses.
set matchpairs=(:),[:],{:},<:>  " These parentheses are shown as matching.

set splitbelow  " Open new pane to the bottom.
set splitright  " Open new pane to the right.

set scrolloff=3     " Minimum lines to keep above/below cursor when scrolling.
set cursorline      " Highlight the current line.
set colorcolumn=80  " Show a column at 80 characters.


" STATUSLINE
let g:currentmode={
  \ 'n': 'NORMAL ',
  \ 'v': 'VISUAL ',
  \ 'V': 'V-LINE ',
  \ "\<C-V>": 'V-BLOCK ',
  \ 'i': 'INSERT ',
  \ 'R': 'REPLACE ',
  \ 'Rv': 'V-REPLACE ',
  \ 'c': 'COMMAND ',
\}

set statusline=                             " Clear the status line.
set statusline+=\ %{g:currentmode[mode()]}  " Show the current mode.
set statusline+=\ %F                        " Current file path.
set statusline+=%{&modified?'\ [+]':''}     " The file has been modified.
set statusline+=%{&readonly?'\ [x]':''}     " The file is read-only.
set statusline+=%<                          " Truncate line here.
set statusline+=%=                          " Aligned items separator.
set statusline+=%{&filetype!=#''?&filetype.'\ ':'none\ '}  " File type.
set statusline+=%-7([%{&fileformat}]%)      " File format.
set statusline+=[%l/%L]                     " Cursor line location.
set statusline+=\ col:%c                    " Column number.


" NETRW SETTINGS
let g:netrw_banner=0
let g:netrw_winsize=25


" SHUT UP
set noerrorbells
set novisualbell


" KEYMAPS
" Use ctrl+direction to change split panes.
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Next tab.
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous tab.
nnoremap <silent> <C-Left> :tabprevious<CR>

" Copy-paste
" <leader>y yanks to system clipboard.
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" <leader>p pastes from system clipboard.
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Press <leader><space> to turn off search highlight.
nnoremap <leader><space> :nohlsearch<CR>


" USER COMMANDS
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

" MakeTags command to generate ctags.
" ctrl+]   ... jump to tag under the cursor.
" g+ctrl+] ... ambiguous tags
" ctrl+t   ... jump back up the tag stack.
command! MakeTags !ctags -R .


" SEARCHING
set ignorecase  " Case insensitive search.
set smartcase   " But case sensitive when uppercase is present.
set showmatch   " Live match highlighting.


" FILETYPE-SPECIFIC COMMANDS
" C
set cinoptions+=t0        " Don't indent function type.
set cinoptions+=l1        " Align with case label.
set cinoptions+=:0        " Align case with switch.
set cinkeys-=0#           " Directives aren't special.
let g:c_no_curly_error=1  " Vim still lacks C99 support.

function! SetIndentation(n)
  let &l:tabstop=a:n
  let &l:softtabstop=a:n
  let &l:shiftwidth=a:n
endfunction

augroup go
  autocmd!
  autocmd FileType go setlocal makeprg=go\ build
  autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 textwidth=72
  autocmd FileType go map <silent> <buffer> <leader>i
      \ :update \|
      \ :cexpr system("goimports -w " . expand('%')) \|
      \ :silent edit<CR>
augroup end

augroup indentation
  autocmd!
  autocmd FileType c,cpp call SetIndentation(2)
  autocmd FileType haskell call SetIndentation(2)
  autocmd FileType lua call SetIndentation(2)
  autocmd FileType vim call SetIndentation(2)
  autocmd FileType sh,bash call SetIndentation(2)
augroup end

augroup column
  autocmd!
  autocmd FileType python setlocal colorcolumn=89
augroup end

augroup plaintext
  autocmd!
  autocmd FileType markdown,text
    \ call SetIndentation(2) |
    \ setlocal textwidth=79
augroup end

augroup email
  autocmd!
  autocmd FileType mail
    \ call SetIndentation(2) |
    \ setlocal textwidth=79 fo+=w
augroup end

augroup todo
  autocmd!
  autocmd Syntax *
    \ call matchadd('Constant', '\v\zs<(TODO|DONE|CANCELLED|FIXME)>')
augroup end
