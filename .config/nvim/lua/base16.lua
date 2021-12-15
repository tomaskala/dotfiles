local M = {}

M.highlight = setmetatable({}, {
  __newindex = function(_, hlgroup, args)
    if (type(args) == "string") then
      vim.cmd(("hi! link %s %s"):format(hlgroup, args))
      return
    end
    local guifg = args.guifg or nil
    local guibg = args.guibg or nil
    local gui = args.gui or nil
    local guisp = args.guisp or nil
    local cmd = {"hi", hlgroup}
    if guifg then table.insert(cmd, "guifg=" .. guifg) end
    if guibg then table.insert(cmd, "guibg=" .. guibg) end
    if gui then table.insert(cmd, "gui=" .. gui) end
    if guisp then table.insert(cmd, "guisp=" .. guisp) end
    vim.cmd(table.concat(cmd, " "))
  end
})

function M.setup(colors)
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.o.termguicolors = true

  M.colors = colors
  local hi = M.highlight

  -- Vim editor colors
  hi.Bold         = { guifg = nil,             guibg = nil,             gui = "bold", guisp = nil }
  hi.ColorColumn  = { guifg = nil,             guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.Conceal      = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.Cursor       = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }
  hi.CursorColumn = { guifg = nil,             guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.CursorLine   = { guifg = nil,             guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.CursorLineNr = { guifg = M.colors.base04, guibg = M.colors.base01, gui = nil,    guisp = nil }
  hi.Debug        = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
  hi.Directory    = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
  hi.Error        = { guifg = M.colors.base00, guibg = M.colors.base08, gui = nil,    guisp = nil }
  hi.ErrorMsg     = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.Exception    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
  hi.FoldColumn   = { guifg = M.colors.base0C, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.Folded       = { guifg = M.colors.base03, guibg = M.colors.base01, gui = nil,    guisp = nil }
  hi.IncSearch    = { guifg = M.colors.base01, guibg = M.colors.base09, gui = "none", guisp = nil }
  hi.Italic       = { guifg = nil,             guibg = nil,             gui = "none", guisp = nil }
  hi.LineNr       = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.Macro        = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
  hi.MatchParen   = { guifg = nil,             guibg = M.colors.base04, gui = nil,    guisp = nil }
  hi.ModeMsg      = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
  hi.MoreMsg      = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
  hi.NonText      = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
  hi.Normal       = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.PMenu        = { guifg = M.colors.base05, guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.PMenuSel     = { guifg = M.colors.base01, guibg = M.colors.base05, gui = nil,    guisp = nil }
  hi.Question     = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
  hi.QuickFixLine = { guifg = nil,             guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.Search       = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = nil,    guisp = nil }
  hi.SignColumn   = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.SpecialKey   = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
  hi.StatusLine   = { guifg = M.colors.base05, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.StatusLineNC = { guifg = M.colors.base04, guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.Substitute   = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = "none", guisp = nil }
  hi.TabLine      = { guifg = M.colors.base03, guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.TabLineFill  = { guifg = M.colors.base03, guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.TabLineSel   = { guifg = M.colors.base09, guibg = M.colors.base01, gui = "none", guisp = nil }
  hi.Title        = { guifg = M.colors.base0D, guibg = nil,             gui = "none", guisp = nil }
  hi.TooLong      = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
  hi.Underlined   = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
  hi.VertSplit    = { guifg = M.colors.base05, guibg = M.colors.base00, gui = "none", guisp = nil }
  hi.Visual       = { guifg = M.colors.base00, guibg = M.colors.base03, gui = nil,    guisp = nil }
  hi.VisualNOS    = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
  hi.WarningMsg   = { guifg = M.colors.base08, guibg = nil,             gui = nil,    guisp = nil }
  hi.WildMenu     = { guifg = M.colors.base08, guibg = M.colors.base0A, gui = nil,    guisp = nil }

  -- Standard syntax highlighting
  hi.Boolean      = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
  hi.Character    = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
  hi.Comment      = { guifg = M.colors.base03, guibg = nil,             gui = nil,    guisp = nil }
  hi.Conditional  = { guifg = M.colors.base0E, guibg = nil,             gui = nil,    guisp = nil }
  hi.Constant     = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
  hi.Define       = { guifg = M.colors.base0E, guibg = nil,             gui = "none", guisp = nil }
  hi.Delimiter    = { guifg = M.colors.base05, guibg = nil,             gui = nil,    guisp = nil }
  hi.Float        = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
  hi.Function     = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
  hi.Identifier   = { guifg = M.colors.base05, guibg = nil,             gui = "none", guisp = nil }
  hi.Include      = { guifg = M.colors.base0D, guibg = nil,             gui = nil,    guisp = nil }
  hi.Keyword      = { guifg = M.colors.base0E, guibg = nil,             gui = nil,    guisp = nil }
  hi.Label        = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
  hi.Number       = { guifg = M.colors.base09, guibg = nil,             gui = nil,    guisp = nil }
  hi.Operator     = { guifg = M.colors.base05, guibg = nil,             gui = "none", guisp = nil }
  hi.PreProc      = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
  hi.Repeat       = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
  hi.Special      = { guifg = M.colors.base0C, guibg = nil,             gui = nil,    guisp = nil }
  hi.SpecialChar  = { guifg = M.colors.base05, guibg = nil,             gui = nil,    guisp = nil }
  hi.Statement    = { guifg = M.colors.base0E, guibg = nil,             gui = "none", guisp = nil }
  hi.StorageClass = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
  hi.String       = { guifg = M.colors.base0B, guibg = nil,             gui = nil,    guisp = nil }
  hi.Structure    = { guifg = M.colors.base0E, guibg = nil,             gui = nil,    guisp = nil }
  hi.Tag          = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }
  hi.Todo         = { guifg = M.colors.base0A, guibg = M.colors.base01, gui = nil,    guisp = nil }
  hi.Type         = { guifg = M.colors.base0A, guibg = nil,             gui = "none", guisp = nil }
  hi.Typedef      = { guifg = M.colors.base0A, guibg = nil,             gui = nil,    guisp = nil }

  -- Diff highlighting
  hi.DiffAdd     = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffAdded   = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffChange  = { guifg = M.colors.base03, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffDelete  = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffFile    = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffLine    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffNewFile = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffRemoved = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.DiffText    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }

  -- Git highlighting
  hi.gitcommitBranch        = { guifg = M.colors.base09, guibg = nil, gui = "bold", guisp = nil }
  hi.gitcommitComment       = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitDiscarded     = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitDiscardedFile = { guifg = M.colors.base08, guibg = nil, gui = "bold", guisp = nil }
  hi.gitcommitDiscardedType = { guifg = M.colors.base0D, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitHeader        = { guifg = M.colors.base0E, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitOverflow      = { guifg = M.colors.base08, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitSelected      = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitSelectedFile  = { guifg = M.colors.base0B, guibg = nil, gui = "bold", guisp = nil }
  hi.gitcommitSelectedType  = { guifg = M.colors.base0D, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitSummary       = { guifg = M.colors.base0B, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitUnmergedFile  = { guifg = M.colors.base08, guibg = nil, gui = "bold", guisp = nil }
  hi.gitcommitUnmergedType  = { guifg = M.colors.base0D, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitUntracked     = { guifg = M.colors.base03, guibg = nil, gui = nil,    guisp = nil }
  hi.gitcommitUntrackedFile = { guifg = M.colors.base0A, guibg = nil, gui = nil,    guisp = nil }

  -- GitGutter highlighting
  hi.GitGutterAdd          = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.GitGutterChange       = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.GitGutterChangeDelete = { guifg = M.colors.base0E, guibg = M.colors.base00, gui = nil, guisp = nil }
  hi.GitGutterDelete       = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }

  -- Spelling highlighting
  hi.SpellBad   = { guifg = nil, guibg = nil, gui = "undercurl", guisp = M.colors.base08 }
  hi.SpellCap   = { guifg = nil, guibg = nil, gui = "undercurl", guisp = M.colors.base0D }
  hi.SpellLocal = { guifg = nil, guibg = nil, gui = "undercurl", guisp = M.colors.base0C }
  hi.SpellRare  = { guifg = nil, guibg = nil, gui = "undercurl", guisp = M.colors.base0E }

  hi.DiagnosticError                = { guifg = M.colors.base08, guibg = nil, gui = "none",      guisp = nil }
  hi.DiagnosticHint                 = { guifg = M.colors.base0C, guibg = nil, gui = "none",      guisp = nil }
  hi.DiagnosticInfo                 = { guifg = M.colors.base05, guibg = nil, gui = "none",      guisp = nil }
  hi.DiagnosticUnderlineError       = { guifg = nil,             guibg = nil, gui = "undercurl", guisp = M.colors.base08 }
  hi.DiagnosticUnderlineHint        = { guifg = nil,             guibg = nil, gui = "undercurl", guisp = M.colors.base0C }
  hi.DiagnosticUnderlineInformation = { guifg = nil,             guibg = nil, gui = "undercurl", guisp = M.colors.base05 }
  hi.DiagnosticUnderlineWarn        = { guifg = nil,             guibg = nil, gui = "undercurl", guisp = M.colors.base0E }
  hi.DiagnosticUnderlineWarning     = { guifg = nil,             guibg = nil, gui = "undercurl", guisp = M.colors.base0E }
  hi.DiagnosticWarn                 = { guifg = M.colors.base0E, guibg = nil, gui = "none",      guisp = nil }

  hi.LspDiagnosticsDefaultError         = "DiagnosticError"
  hi.LspDiagnosticsDefaultHint          = "DiagnosticHint"
  hi.LspDiagnosticsDefaultInformation   = "DiagnosticInfo"
  hi.LspDiagnosticsDefaultWarning       = "DiagnosticWarn"
  hi.LspDiagnosticsUnderlineError       = "DiagnosticUnderlineError"
  hi.LspDiagnosticsUnderlineHint        = "DiagnosticUnderlineHint"
  hi.LspDiagnosticsUnderlineInformation = "DiagnosticUnderlineInformation"
  hi.LspDiagnosticsUnderlineWarning     = "DiagnosticUnderlineWarning"
  hi.LspReferenceRead                   = { guifg = nil, guibg = nil, gui = "underline", guisp = M.colors.base04 }
  hi.LspReferenceText                   = { guifg = nil, guibg = nil, gui = "underline", guisp = M.colors.base04 }
  hi.LspReferenceWrite                  = { guifg = nil, guibg = nil, gui = "underline", guisp = M.colors.base04 }

  hi.TSAnnotation         = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSAttribute          = { guifg = M.colors.base0A, guibg = nil, gui = "none",          guisp = nil }
  hi.TSBoolean            = { guifg = M.colors.base09, guibg = nil, gui = "none",          guisp = nil }
  hi.TSCharacter          = { guifg = M.colors.base0B, guibg = nil, gui = "none",          guisp = nil }
  hi.TSComment            = { guifg = M.colors.base03, guibg = nil, gui = "italic",        guisp = nil }
  hi.TSConditional        = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSConstBuiltin       = { guifg = M.colors.base0F, guibg = nil, gui = "none",          guisp = nil }
  hi.TSConstMacro         = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSConstant           = { guifg = M.colors.base09, guibg = nil, gui = "none",          guisp = nil }
  hi.TSConstructor        = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSCurrentScope       = { guifg = nil,             guibg = nil, gui = "bold",          guisp = nil }
  hi.TSDefinition         = { guifg = nil,             guibg = nil, gui = "underline",     guisp = M.colors.base04 }
  hi.TSDefinitionUsage    = { guifg = nil,             guibg = nil, gui = "underline",     guisp = M.colors.base04 }
  hi.TSEmphasis           = { guifg = M.colors.base09, guibg = nil, gui = "italic",        guisp = nil }
  hi.TSError              = { guifg = M.colors.base08, guibg = nil, gui = "none",          guisp = nil }
  hi.TSException          = { guifg = M.colors.base08, guibg = nil, gui = "none",          guisp = nil }
  hi.TSField              = { guifg = M.colors.base0C, guibg = nil, gui = "none",          guisp = nil }
  hi.TSFloat              = { guifg = M.colors.base09, guibg = nil, gui = "none",          guisp = nil }
  hi.TSFuncBuiltin        = { guifg = M.colors.base0F, guibg = nil, gui = "none",          guisp = nil }
  hi.TSFuncMacro          = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSFunction           = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSInclude            = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSKeyword            = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSKeywordFunction    = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSKeywordOperator    = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSKeywordReturn      = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSLabel              = { guifg = M.colors.base0A, guibg = nil, gui = "none",          guisp = nil }
  hi.TSLiteral            = { guifg = M.colors.base09, guibg = nil, gui = "none",          guisp = nil }
  hi.TSMethod             = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSNamespace          = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSNone               = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSNumber             = { guifg = M.colors.base09, guibg = nil, gui = "none",          guisp = nil }
  hi.TSOperator           = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSParameter          = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSParameterReference = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSProperty           = { guifg = M.colors.base0C, guibg = nil, gui = "none",          guisp = nil }
  hi.TSPunctBracket       = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSPunctDelimiter     = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSPunctSpecial       = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSRepeat             = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSStrike             = { guifg = M.colors.base00, guibg = nil, gui = "strikethrough", guisp = nil }
  hi.TSString             = { guifg = M.colors.base0B, guibg = nil, gui = "none",          guisp = nil }
  hi.TSStringEscape       = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSStringRegex        = { guifg = M.colors.base0E, guibg = nil, gui = "none",          guisp = nil }
  hi.TSStrong             = { guifg = nil,             guibg = nil, gui = "bold",          guisp = nil }
  hi.TSSymbol             = { guifg = M.colors.base0B, guibg = nil, gui = "none",          guisp = nil }
  hi.TSTag                = { guifg = M.colors.base0A, guibg = nil, gui = "none",          guisp = nil }
  hi.TSTagDelimiter       = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSText               = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSTitle              = { guifg = M.colors.base0D, guibg = nil, gui = "none",          guisp = nil }
  hi.TSType               = { guifg = M.colors.base0A, guibg = nil, gui = "none",          guisp = nil }
  hi.TSTypeBuiltin        = { guifg = M.colors.base0A, guibg = nil, gui = "none",          guisp = nil }
  hi.TSURI                = { guifg = M.colors.base09, guibg = nil, gui = "underline",     guisp = nil }
  hi.TSUnderline          = { guifg = M.colors.base00, guibg = nil, gui = "underline",     guisp = nil }
  hi.TSVariable           = { guifg = M.colors.base05, guibg = nil, gui = "none",          guisp = nil }
  hi.TSVariableBuiltin    = { guifg = M.colors.base0F, guibg = nil, gui = "none",          guisp = nil }

  hi.NvimInternalError = { guifg = M.colors.base00, guibg = M.colors.base08, gui = "none", guisp = nil }

  hi.FloatBorder  = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.NormalFloat  = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.NormalNC     = { guifg = M.colors.base05, guibg = M.colors.base00, gui = nil,    guisp = nil }
  hi.TermCursor   = { guifg = M.colors.base00, guibg = M.colors.base05, gui = "none", guisp = nil }
  hi.TermCursorNC = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil,    guisp = nil }

  hi.User1 = { guifg = M.colors.base08, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User2 = { guifg = M.colors.base0E, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User3 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User4 = { guifg = M.colors.base0C, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User5 = { guifg = M.colors.base01, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User6 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User7 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User8 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = "none", guisp = nil }
  hi.User9 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = "none", guisp = nil }

  hi.TreesitterContext = { guifg = nil, guibg = M.colors.base01, gui = "italic", guisp = nil }

  vim.g.terminal_color_0  = M.colors.base00
  vim.g.terminal_color_1  = M.colors.base08
  vim.g.terminal_color_2  = M.colors.base0B
  vim.g.terminal_color_3  = M.colors.base0A
  vim.g.terminal_color_4  = M.colors.base0D
  vim.g.terminal_color_5  = M.colors.base0E
  vim.g.terminal_color_6  = M.colors.base0C
  vim.g.terminal_color_7  = M.colors.base05
  vim.g.terminal_color_8  = M.colors.base03
  vim.g.terminal_color_9  = M.colors.base08
  vim.g.terminal_color_10 = M.colors.base0B
  vim.g.terminal_color_11 = M.colors.base0A
  vim.g.terminal_color_12 = M.colors.base0D
  vim.g.terminal_color_13 = M.colors.base0E
  vim.g.terminal_color_14 = M.colors.base0C
  vim.g.terminal_color_15 = M.colors.base07
end

return M
