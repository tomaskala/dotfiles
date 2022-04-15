-- Plugin installation
-------------------------------------------------------------------------------
require("packer").startup(function()
  use("wbthomason/packer.nvim")
  use("cocopon/iceberg.vim")
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
end)

-- Treesitter config
-------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "go",
    "gomod",
    "gowork",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "regex",
    "vim",
    "yaml",
  },
})
