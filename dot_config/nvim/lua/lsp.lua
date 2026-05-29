vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = {
    "go.work",
    "go.mod",
    ".git",
  },
})

vim.lsp.enable({ "gopls" })

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
