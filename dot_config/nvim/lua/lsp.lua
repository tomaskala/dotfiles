vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = {
    "go.mod",
    "go.work",
    ".git",
  },
})

vim.lsp.config("lua-language-server", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim",
        },
      },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
})

vim.lsp.enable({ "gopls", "lua-language-server", "ruff" })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP",
  group = vim.api.nvim_create_augroup("lsp_config", { clear = true }),
  callback = function(args)
    -- Configure keybinds.
    local opts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set("n", "grf", vim.lsp.buf.format, opts)

    -- Configure completions.
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end,
})

