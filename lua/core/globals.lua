-- Set leader key
vim.g.mapleader = ","

-- Set path to python binary
if vim.fn.has("macunix") then
  vim.g.python3_host_prog='/opt/homebrew/bin/python3'
else
  vim.g.python3_host_prog='/usr/bin/python'
end
