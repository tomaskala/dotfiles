" Vim syntax file
" Language:	Cython

" Quit when a syntax file was already loaded.
if exists("b:current_syntax")
  finish
endif

" Read the Python syntax to start with
runtime! syntax/python.vim
unlet b:current_syntax

" Cython extentions
syn keyword cythonDef       cdef cpdef typedef ctypedef fused DEF IF ELIF ELSE
syn keyword cythonStatement sizeof typeid new
syn keyword cythonType		int long short float double char object void signed unsigned
syn keyword cythonStructure	struct union enum cppclass
syn keyword cythonInclude	include cimport
syn keyword cythonAccess	public private property readonly extern
syn keyword cythonGil       gil nogil

" If someome wants Python's built-ins highlighted, they probably
" also want Pyrex's built-ins highlighted.
if exists("python_highlight_builtins") || exists("pyrex_highlight_builtins")
    syn keyword pyrexBuiltin    NULL
endif

" This deletes "from" from the keywords and re-adds it as a
" match with lower priority than cythonForFrom
syn clear   pythonInclude
syn keyword pythonInclude     import
syn match   pythonInclude     "from"

" With "for[^:]*\zsfrom" VIM does not match "for" anymore, so
" I used the slower "\@<=" form
syn match   cythonForFrom        "\(for[^:]*\)\@<=from"

" Default highlighting
hi def link cythonDef       Statement
hi def link cythonStatement Statement
hi def link cythonType		Type
hi def link cythonStructure Structure
hi def link cythonInclude	PreCondit
hi def link cythonAccess	cythonStatement
hi def link cythonGil       Statement

if exists("python_highlight_builtins") || exists("pyrex_highlight_builtins")
    hi def link pyrexBuiltin	Function
endif

hi def link cythonForFrom	Statement


let b:current_syntax = "cython"
