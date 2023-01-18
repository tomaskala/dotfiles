hi clear

if exists('syntax_on')
  syntax reset
endif

let colors_name='plain'

hi SpecialKey ctermfg=4
hi TermCursor cterm=reverse
hi NonText ctermfg=12
hi Directory ctermfg=4
hi ErrorMsg ctermfg=15 ctermbg=1
hi IncSearch cterm=reverse
hi MoreMsg ctermfg=2
hi ModeMsg cterm=bold
hi Question ctermfg=2
hi WarningMsg ctermfg=1
hi WildMenu ctermfg=0 ctermbg=11
hi Conceal ctermfg=7 ctermbg=7
hi SpellBad ctermbg=9
hi SpellRare ctermbg=13
hi SpellLocal ctermbg=14
hi PmenuSbar ctermbg=8
hi PmenuThumb ctermbg=0
hi TabLine ctermfg=0 ctermbg=7 cterm=underline
hi TabLineSel cterm=bold
hi TabLineFill cterm=reverse
hi CursorColumn ctermbg=7
hi CursorLine cterm=underline
hi MatchParen ctermbg=14
hi Ignore ctermfg=15
hi Error ctermfg=15 ctermbg=9
hi Todo ctermfg=0 ctermbg=11

hi DiffAdd ctermfg=0 ctermbg=2
hi DiffChange ctermfg=0 ctermbg=3
hi DiffDelete ctermfg=0 ctermbg=1
hi DiffText ctermfg=0 ctermbg=11 cterm=bold

hi Visual ctermfg=NONE ctermbg=NONE cterm=inverse
hi Search ctermfg=0 ctermbg=11

hi Comment ctermfg=2
hi String ctermfg=1
hi Character ctermfg=1
hi Boolean ctermfg=1
hi Number ctermfg=4
hi Float ctermfg=4

if &background == 'light'
  hi Constant ctermfg=8
  hi Identifier ctermfg=0 cterm=NONE
  hi PreProc ctermfg=0 cterm=bold
  hi Special ctermfg=0
  hi Statement ctermfg=0 cterm=bold
  hi Title ctermfg=0 cterm=bold
  hi Type ctermfg=0 cterm=bold
  hi Underlined ctermfg=0 cterm=underline
  hi LineNr ctermfg=8
  hi CursorLineNr ctermfg=8
  hi ColorColumn ctermfg=7 ctermbg=8
  hi Folded ctermfg=8 ctermbg=7
  hi FoldColumn ctermfg=8 ctermbg=7
  hi Pmenu ctermfg=0 ctermbg=7
  hi PmenuSel ctermfg=7 ctermbg=0
  hi SpellCap ctermfg=8 ctermbg=7
  hi StatusLine ctermfg=0 ctermbg=7 cterm=bold
  hi StatusLineNC ctermfg=8 ctermbg=7 cterm=NONE
  hi VertSplit ctermfg=8 ctermbg=7 cterm=NONE
  hi SignColumn ctermbg=7
else
  hi Constant ctermfg=7
  hi Identifier ctermfg=15 cterm=NONE
  hi PreProc ctermfg=15 cterm=bold
  hi Special ctermfg=15
  hi Statement ctermfg=15 cterm=bold
  hi Title ctermfg=15 cterm=bold
  hi Type ctermfg=15 cterm=bold
  hi Underlined ctermfg=15 cterm=underline
  hi LineNr ctermfg=8
  hi CursorLineNr ctermfg=8
  hi ColorColumn ctermfg=0 ctermbg=8
  hi Folded ctermfg=7 ctermbg=8
  hi FoldColumn ctermfg=7 ctermbg=8
  hi Pmenu ctermfg=15 ctermbg=8
  hi PmenuSel ctermfg=8 ctermbg=15
  hi SpellCap ctermfg=7 ctermbg=8
  hi StatusLine ctermfg=15 ctermbg=8 cterm=bold
  hi StatusLineNC ctermfg=7 ctermbg=8 cterm=NONE
  hi VertSplit ctermfg=7 ctermbg=8 cterm=NONE
  hi SignColumn ctermbg=8
endif
