local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "awk",
        "bash",
        "c",
        "comment",
        "csv",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "hcl",
        "http",
        "ini",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "lua",
        "make",
        "nix",
        "proto",
        "python",
        "regex",
        "ssh_config",
        "toml",
        "typescript",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
      },
      sections = {
        lualine_x = { "filetype" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ansiblels",
        "dockerls",
        "eslint",
        "lua_ls",
        "nil_ls",
        "pyright",
        "ruff_lsp",
        "tsserver",
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup(opts)

      mason_lspconfig.setup_handlers({
        function(server)
          lspconfig[server].setup({})
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,

        ["tsserver"] = function()
          lspconfig.tsserver.setup({
            commands = {
              OrganizeImports = {
                function()
                  local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) },
                  }

                  vim.lsp.buf.execute_command(params)
                end,
                description = "Organize imports",
              },
            },
          })
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Global mappings.
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          -- Enable completion triggered by <c-x><c-o>.
          vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          local keymap_opts = { buffer = args.buf, noremap = true, silent = true }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, keymap_opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, keymap_opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, keymap_opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, keymap_opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, keymap_opts)
        end,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        file_ignore_patterns = {
          ".git",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
    config = function(_, opts)
      local builtin = require("telescope.builtin")
      local keymap_opts = { noremap = true }
      vim.keymap.set("n", "<leader>ff", builtin.find_files, keymap_opts)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, keymap_opts)
      vim.keymap.set("n", "<leader>fb", builtin.buffers, keymap_opts)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, keymap_opts)
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, keymap_opts)
      vim.keymap.set("n", "<leader>ft", builtin.treesitter, keymap_opts)

      require("telescope").setup(opts)
    end,
  },
})
