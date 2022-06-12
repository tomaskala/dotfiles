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
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
})
