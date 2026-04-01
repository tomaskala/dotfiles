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
vim.opt.swapfile = false

vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.showmode = false
vim.opt.completeopt = { "menu", "menuone", "popup", "fuzzy", "noinsert" }
vim.opt.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { noremap = true })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Go settings",
  pattern = "go",
  group = vim.api.nvim_create_augroup("go", { clear = true }),
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
    vim.opt_local.makeprg = "go build"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Python settings",
  pattern = "python",
  group = vim.api.nvim_create_augroup("python", { clear = true }),
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
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true

    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.formatoptions = "qn1j"

    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set({ "n", "x" }, "j", "gj", opts)
    vim.keymap.set({ "n", "x" }, "k", "gk", opts)
  end,
})
