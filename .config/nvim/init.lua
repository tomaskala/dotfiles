vim.g.mapleader = ","
require("plugins")

vim.opt.path = "**"
vim.opt.fileformat = "unix"
vim.opt.ttimeoutlen = 0

vim.opt.shortmess:append({ I = true })
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.cpoptions:remove("a")

vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.colorcolumn = { 80 }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = { "longest:full", "full" }

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cinoptions = { "t0", "l1", ":0" }
vim.opt.cinkeys:remove("0#")

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("n", "[q", ":cprevious<CR>", { noremap = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { noremap = true })
vim.keymap.set("n", "]Q", ":clast<CR>", { noremap = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "go",
  group = vim.api.nvim_create_augroup("golang", { clear = true }),
  callback = function(args)
    vim.opt_local.makeprg = "go build"
    vim.opt_local.expandtab = false
    vim.keymap.set("n", "<leader>f", [[
      :update<CR>
      :cexpr system("goimports -w " . expand("%"))<CR>
      :edit<CR>
    ]], { noremap = true, buffer = args.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "go", "python" },
  group = vim.api.nvim_create_augroup("indentmore", { clear = true }),
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "text" },
  group = vim.api.nvim_create_augroup("plaintext", { clear = true }),
  callback = function()
    vim.opt_local.textwidth = 79
    vim.opt_local.formatoptions:append({ w = true })
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
