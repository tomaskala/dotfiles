vim.loader.enable()
vim.g.mapleader = ","

require("plugins")
require("lsp")

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.breakindent = true

vim.opt.shortmess:append({ I = true })
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showmode = false
vim.opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"
vim.opt.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set("n", "<Esc>", function() vim.cmd("nohlsearch") end, { noremap = true })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Go settings",
  pattern = "go",
  group = vim.api.nvim_create_augroup("golang", { clear = true }),
  callback = function(args)
    vim.opt_local.expandtab = false
    vim.opt_local.makeprg = "go build"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Indent to 4 spaces",
  pattern = { "go", "python" },
  group = vim.api.nvim_create_augroup("indent_4_spaces", { clear = true }),
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Plaintext settings",
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
