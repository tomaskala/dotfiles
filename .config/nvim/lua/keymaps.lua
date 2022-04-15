-- User commands
-------------------------------------------------------------------------------
-- MakeTags command to generate ctags.
-- ctrl+]   ... jump to tag under the cursor.
-- g+ctrl+] ... ambiguous tags
-- ctrl+t   ... jump back up the tag stack.
vim.api.nvim_create_user_command("MakeTags", "!ctags -R .", {})

-- Fix caps lock annoyances.
vim.api.nvim_create_user_command(
  "E",
  "e<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command(
  "W",
  "w<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command(
  "Wq",
  "wq<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command(
  "WQ",
  "wq<bang> <args>",
  {bang = true, nargs = "?", complete = "file"}
)
vim.api.nvim_create_user_command("Wa", "wa<bang>", {bang = true})
vim.api.nvim_create_user_command("WA", "wa<bang>", {bang = true})
vim.api.nvim_create_user_command("Q", "q<bang>", {bang = true})
vim.api.nvim_create_user_command("Qa", "qa<bang>", {bang = true})
vim.api.nvim_create_user_command("QA", "qa<bang>", {bang = true})

-- Keymaps
-------------------------------------------------------------------------------
-- Use ctrl+direction to change split panes.
vim.api.nvim_set_keymap("", "<C-h>", "<C-W>h", {noremap = true})
vim.api.nvim_set_keymap("", "<C-j>", "<C-W>j", {noremap = true})
vim.api.nvim_set_keymap("", "<C-k>", "<C-W>k", {noremap = true})
vim.api.nvim_set_keymap("", "<C-l>", "<C-W>l", {noremap = true})

-- Next tab.
vim.api.nvim_set_keymap(
  "n",
  "<C-Right>",
  ":tabnext<CR>",
  {noremap = true, silent = true}
)

-- Previous tab.
vim.api.nvim_set_keymap(
  "n",
  "<C-Left>",
  ":tabprevious<CR>",
  {noremap = true, silent = true}
)

-- Copy-paste
-- <leader>y yanks to system clipboard.
vim.api.nvim_set_keymap("n", "<leader>y", "\"+y", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>yy", "\"+yy", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>Y", "\"+Y", {noremap = false})

-- <leader>p pastes from system clipboard.
vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>p", "\"+p", {noremap = true})

-- Press <leader><space> to turn off search highlight.
vim.api.nvim_set_keymap(
  "n",
  "<leader><space>",
  ":nohlsearch<CR>",
  {noremap = true}
)
