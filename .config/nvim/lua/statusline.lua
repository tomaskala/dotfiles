-- Statusline config
-------------------------------------------------------------------------------
local modemap = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  [""] = "V-BLOCK",
  ["s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  [""] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

function statusline()
  local currentmode = modemap[vim.api.nvim_get_mode().mode]
  local filepath = "%F"
  local modified = vim.bo.modified and "[+]" or ""
  local readonly = vim.bo.readonly and "[x]" or ""
  local filetype = vim.bo.filetype
  local fileformat = vim.bo.fileformat
  local cursorline = "[%l/%L]"
  local column = "col:%c"
  return string.format(
    "%s %s %s %s %%< %%= %s %s %s %s",
    currentmode,
    filepath,
    modified,
    readonly,
    filetype,
    fileformat,
    cursorline,
    column
  )
end

vim.opt.laststatus = 3  -- Display one statusline common to all windows.
vim.opt.statusline = "%{%v:lua.statusline()%}"
