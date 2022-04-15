-- General
-------------------------------------------------------------------------------
vim.g.mapleader = ","          -- The leader is a comma instead of a backslash.
vim.opt.mouse = "a"            -- Enable mouse input.
vim.opt.selection = "old"      -- Old-style visual selection.
vim.opt.path:append("**")      -- Recursive globbing.
vim.opt.fileformat = "unix"    -- Always use unix-style line endings.
vim.opt.hidden = true          -- Do not lose history when switching buffers.
vim.opt.lazyredraw = true      -- Redraw only when needed.
vim.opt.shortmess:append("I")  -- Do not display the startup message.

-- Indentation
-------------------------------------------------------------------------------
vim.opt.tabstop = 4          -- Number of visual spaces per TAB.
vim.opt.softtabstop = 4      -- Number of visual spaces in tab when editing.
vim.opt.shiftwidth = 4       -- Auto-indent this many spaces.
vim.opt.softtabstop = 4      -- Number of spaces when editing.
vim.opt.linebreak = true     -- Do not break words when wrapping lines.
vim.opt.expandtab = true     -- Tabs are spaces.
vim.opt.startofline = false  -- Do not move the cursor to line start on gg, G.

-- Backups
-------------------------------------------------------------------------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- UI config
-------------------------------------------------------------------------------
vim.opt.number = true                        -- Show absolute line numbers.
vim.opt.relativenumber = true                -- Show relative line numbers.
vim.opt.showmode = false                     -- The status bar displays the mode.
vim.opt.wildmode = {"longest:full", "full"}  -- Shell-like filename autocompletion.
vim.opt.splitbelow = true                    -- Open new pane to the bottom.
vim.opt.splitright = true                    -- Open new pane to the right.

vim.opt.showmatch = true                           -- Highlight matching pairs.
vim.opt.matchpairs = {"(:)", "[:]", "{:}", "<:>"}  -- Show these as matching.

vim.opt.scrolloff = 3       -- Minimum lines to keep above/below cursor.
vim.opt.cursorline = true   -- Highlight the current line.
vim.opt.colorcolumn = "80"  -- Show a column at 80 characters.

-- Netrw config
-------------------------------------------------------------------------------
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Shut up
-------------------------------------------------------------------------------
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Searching
-------------------------------------------------------------------------------
vim.opt.ignorecase = true  -- Case insensitive search.
vim.opt.smartcase = true   -- But case sensitive when uppercase is present.
vim.opt.showmatch = true   -- Live match highlighting.

-- C-specific config
-------------------------------------------------------------------------------
vim.opt.cinoptions:append("t0")  -- Don't indent function type.
vim.opt.cinoptions:append("l1")  -- Align with case label.
vim.opt.cinoptions:append(":0")  -- Align case with switch.
vim.opt.cinkeys:remove("0#")     -- Directives aren't special.
vim.g.c_no_curly_error = 1       -- Vim still lacks C99 support.
