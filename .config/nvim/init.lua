-- Options
-------------------------------------------------------------------------------
vim.g.mapleader = ","          -- The leader is a comma instead of a backslash.
vim.opt.mouse = "a"            -- Enable mouse input.
vim.opt.path:append("**")      -- Recursive globbing.
vim.opt.fileformat = "unix"    -- Always use unix-style line endings.
vim.opt.hidden = true          -- Do not lose history when switching buffers.
vim.opt.lazyredraw = true      -- Redraw only when needed.
vim.opt.shortmess:append("I")  -- Do not display the startup message.

vim.opt.tabstop = 4          -- Tab character is this many spaces.
vim.opt.softtabstop = 4      -- Tab or backspace press is this many spaces.
vim.opt.shiftwidth = 4       -- Indentation is this many spaces.
vim.opt.linebreak = true     -- Do not break words when wrapping lines.
vim.opt.expandtab = true     -- Tabs are spaces.
vim.opt.startofline = false  -- Do not move the cursor to line start on gg, G.

vim.opt.backup = false    -- Do not keep backups around after writing buffers.
vim.opt.swapfile = false  -- Disable swapfile creation.

vim.opt.number = true                        -- Show absolute line numbers.
vim.opt.relativenumber = true                -- Show relative line numbers.
vim.opt.wildmode = {"longest:full", "full"}  -- Shell-like autocompletion.
vim.opt.splitbelow = true                    -- Open new pane to the bottom.
vim.opt.splitright = true                    -- Open new pane to the right.

vim.opt.scrolloff = 3       -- Minimum lines to keep above/below cursor.
vim.opt.cursorline = true   -- Highlight the current line.
vim.opt.colorcolumn = "80"  -- Show a column at 80 characters.

vim.g.netrw_banner = 0    -- Hide the netrw banner.
vim.g.netrw_winsize = 25  -- Use this percentage of the screen for netrw.

vim.opt.errorbells = false  -- Disable the bell for error messages.
vim.opt.visualbell = false  -- Disable the visual bell.

vim.opt.ignorecase = true  -- Case insensitive search.
vim.opt.smartcase = true   -- But case sensitive when uppercase is present.

vim.opt.cinoptions:append("t0")  -- Don't indent function type.
vim.opt.cinoptions:append("l1")  -- Align with case label.
vim.opt.cinoptions:append(":0")  -- Align case with switch.
vim.opt.cinkeys:remove("0#")     -- Directives aren't special.

-- Plugins
-------------------------------------------------------------------------------
require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("cocopon/iceberg.vim")
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
end)

require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
})

-- Colorscheme
-------------------------------------------------------------------------------
vim.opt.termguicolors = true
vim.cmd("colorscheme iceberg")

-- Keymaps
-------------------------------------------------------------------------------
-- MakeTags command to generate ctags.
-- ctrl+]   ... jump to tag under the cursor.
-- g+ctrl+] ... ambiguous tags
-- ctrl+t   ... jump back up the tag stack.
vim.api.nvim_create_user_command("MakeTags", "!ctags -R .", {})

-- Fix caps lock annoyances.
vim.api.nvim_create_user_command(
  "E",
  "e<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command(
  "W",
  "w<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command(
  "Wq",
  "wq<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command(
  "WQ",
  "wq<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command("Wa", "wa<bang>", {bang = true})
vim.api.nvim_create_user_command("WA", "wa<bang>", {bang = true})
vim.api.nvim_create_user_command("Q", "q<bang>", {bang = true})
vim.api.nvim_create_user_command("Qa", "qa<bang>", {bang = true})
vim.api.nvim_create_user_command("QA", "qa<bang>", {bang = true})

-- Use ctrl+direction to change split panes.
vim.api.nvim_set_keymap("", "<C-h>", "<C-W>h", {noremap = true})
vim.api.nvim_set_keymap("", "<C-j>", "<C-W>j", {noremap = true})
vim.api.nvim_set_keymap("", "<C-k>", "<C-W>k", {noremap = true})
vim.api.nvim_set_keymap("", "<C-l>", "<C-W>l", {noremap = true})

-- <leader>y yanks to system clipboard.
vim.api.nvim_set_keymap("n", "<leader>y", "\"+y", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>yy", "\"+yy", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>Y", "\"+Y", {noremap = false})

-- <leader>p pastes from system clipboard.
vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>p", "\"+p", {noremap = true})

-- <leader><space> turns off search highlight.
vim.api.nvim_set_keymap(
  "n",
  "<leader><space>",
  ":nohlsearch<CR>",
  {noremap = true}
)

-- Autocommands
-------------------------------------------------------------------------------
vim.api.nvim_create_augroup("go", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = "go",
  pattern = "go",
  callback = function()
    vim.opt_local.makeprg = "go build"
    vim.opt_local.formatprg = "gofmt -s"
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.textwidth = 72
  end,
})

vim.api.nvim_create_augroup("indentation", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = "indentation",
  pattern = {
    "c",
    "cpp",
    "haskell",
    "lua",
    "vim",
    "sh",
    "bash",
    "json",
    "yaml",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_augroup("plaintext", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = "plaintext",
  pattern = {"markdown", "text"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.textwidth = 79
  end,
})

vim.api.nvim_create_augroup("email", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = "email",
  pattern = "mail",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.textwidth = 79
    vim.opt_local.formatoptions:append("w")
  end,
})
