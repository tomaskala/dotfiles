vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Plugin hooks",
  group = vim.api.nvim_create_augroup("hooks", { clear = true }),
  callback = function(args)
    local name = args.data.spec.name
    local kind = args.data.kind

    if name == "nvim-treesitter" and kind == "update" then
      if not args.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    elseif name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
      if not args.data.active then
        vim.cmd.packadd("telescope-fzf-native.nvim")
      end
      vim.system({ "make" }, { cwd = args.data.path }):wait()
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-telescope/telescope-file-browser.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

require("catppuccin").setup({
  background = {
    light = "latte",
    dark = "macchiato",
  },
})
vim.cmd.colorscheme("catppuccin")

require("lualine").setup({
  options = {
    theme = "catppuccin-nvim",
  },
  sections = {
    lualine_x = { "filetype" },
  },
})

do
  local telescope_api = require("telescope.builtin")
  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "<C-p>", telescope_api.find_files, opts)
  vim.keymap.set("n", "<C-S-p>", telescope_api.live_grep, opts)
  vim.keymap.set("n", "<C-b>", telescope_api.buffers, opts)

  vim.keymap.set("n", "grr", telescope_api.lsp_references, opts)
  vim.keymap.set("n", "gd", function()
    telescope_api.lsp_definitions({ reuse_win = true })
  end, opts)
  vim.keymap.set("n", "gi", function()
    telescope_api.lsp_implementations({ reuse_win = true })
  end, opts)
  vim.keymap.set("n", "go", function()
    telescope_api.lsp_type_definitions({ reuse_win = true })
  end, opts)

  local telescope = require("telescope")
  telescope.load_extension("fzf")
  telescope.load_extension("file_browser")

  vim.keymap.set("n", "<C-h>", function()
    telescope.extensions.file_browser.file_browser({
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
      select_buffer = true,
    })
  end, opts)

  vim.keymap.set("n", "<C-S-h>", function()
    telescope.extensions.file_browser.file_browser()
  end, opts)
end

require("nvim-treesitter").install({
  "awk", "bash", "c", "comment", "csv", "dockerfile","fish", "git_rebase",
  "gitcommit", "gitignore", "go", "gomod", "gosum", "gotmpl", "gowork",
  "hcl", "jq", "json", "lua", "luap", "markdown", "markdown_inline", "nix",
  "proto", "python", "regex", "sql", "toml", "yaml",
})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Start treesitter",
  pattern = "*",
  group = vim.api.nvim_create_augroup("start_treesitter", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end
})
