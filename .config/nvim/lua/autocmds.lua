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
