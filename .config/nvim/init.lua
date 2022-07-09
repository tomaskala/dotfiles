-- Options
-------------------------------------------------------------------------------
vim.g.mapleader = ","
vim.opt.mouse = "a"
vim.opt.path = "**"
vim.opt.fileformat = "unix"
vim.opt.hidden = true
vim.opt.lazyredraw = true
vim.opt.shortmess:append("I")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.linebreak = true
vim.opt.expandtab = true
vim.opt.startofline = false

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = {"longest:full", "full"}
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 3
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cinoptions:append("t0")
vim.opt.cinoptions:append("l1")
vim.opt.cinoptions:append(":0")
vim.opt.cinkeys:remove("0#")

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
    "bash",
    "c",
    "cpp",
    "email",
    "haskell",
    "json",
    "lua",
    "markdown",
    "sh",
    "text",
    "vim",
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
  pattern = {"mail", "markdown", "text"},
  callback = function()
    vim.opt_local.textwidth = 79
    vim.opt_local.formatoptions:append("w")
  end,
})
